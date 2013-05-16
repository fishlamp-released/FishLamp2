//
//  GtNetworkRequest.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/9/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtNetworkRequest.h"
#import "GtDefaultErrorHandler.h"

static NSTimeInterval s_timeout = GtDefaultTimeout;

@implementation GtNetworkRequest

GtSynthesize(receivedData, setReceivedData, NSData, m_receivedData);
GtSynthesize(error, setError, NSError, m_error); 
GtSynthesizeString(host, setHost);
GtSynthesizeString(url, setUrl);
GtSynthesize(response, setResponse, NSURLResponse, m_response);
GtSynthesize(request, setRequest, NSMutableURLRequest, m_request);

@synthesize delegate = m_delegate;
@synthesize timeout = m_timeout;

- (void) stopTimeoutTimer
{
    if(m_timeoutTimer)
	{
		[m_timeoutTimer invalidate];
		m_timeoutTimer = nil;	
	}
}


- (void) clearRequest
{
GtReleaseWithNil(m_request);
	
}

-(void) dealloc
{
    [self stopTimeoutTimer];

#if DEBUG
	GtTrace(GtTraceNetworkRequests, @"Request deleted");
#endif
	GtRelease(m_connection);
	GtRelease(m_lock);
	GtRelease(m_receivedData);
	GtRelease(m_request);
	GtRelease(m_response);
	GtRelease(m_error);
	GtRelease(m_host);
	GtRelease(m_url);
	
	[super dealloc];
}

GtAssertDefaultInitNotCalled();

- (void) updateTimestamp
{
    m_timeoutTimestamp = [NSDate timeIntervalSinceReferenceDate];
}

-(id) initWithUrl:(NSString*) urlString
{
	GtAssertIsValidString(urlString);

	if(self = [super init])
	{
		self.url = urlString;
        self.timeout = s_timeout;
        
		NSURL* url = [GtAlloc(NSURL) initWithString:self.url];
		
		self.host = url.host;
		
		m_request = [GtAlloc(NSMutableURLRequest) initWithURL:url
										cachePolicy:NSURLRequestReloadIgnoringLocalCacheData 
										timeoutInterval:240.0] ; // NOTE anything less that 240 seconds is ignored. Facepalm.
										
		GtRelease(url);
		
		[self updateTimestamp];
		
		static BOOL s_setCache = NO;
		if(!s_setCache)
		{
			[[NSURLCache sharedURLCache] setMemoryCapacity:0];
			[[NSURLCache sharedURLCache] setDiskCapacity:0];
        	s_setCache = YES;
		}
	}
	
	return self;
}

- (void) unlock
{

#if INTHREAD
	m_flags.locked = NO;
#else
    [m_lock signal];
#endif    

#if DEBUG
	GtTrace(GtTraceNetworkRequests, @"Unlocked thread");
#endif
}

- (void) onTimeoutCheck:(id) sender
{
    NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
    NSTimeInterval sinceLastUpdate = now - m_timeoutTimestamp;

	if(ABS(sinceLastUpdate) > self.timeout)
	{
        @synchronized(self) 
        {
            [self stopTimeoutTimer];

            NSError* timeout = [GtAlloc(NSError) initWithDomain:NSURLErrorDomain
                code:NSURLErrorTimedOut
                userInfo:nil];
                
            self.error = timeout;
            
            GtRelease(timeout);
            
            if(m_connection)
            {
                [m_connection cancel];
            }
            
            [self unlock];
        }
	}
}

- (void) startTimeoutTimer
{
   [self stopTimeoutTimer];

    m_timeoutTimer = [NSTimer timerWithTimeInterval:2.0
				target:self 
				selector:@selector(onTimeoutCheck:) 
				userInfo:nil 
				repeats:YES];
				
    [[NSRunLoop mainRunLoop] addTimer:m_timeoutTimer 
			forMode:NSRunLoopCommonModes];
	
}

-(void) send
{
	GtAssert(m_receivedData == nil, @"received data should be nil");
	GtAssert(m_connection == nil, @"connection data should be nil");
	GtAssert(m_response == nil, @"response should be nil");

   	m_receivedData = [GtAlloc(NSMutableData) init];
	m_lock = [GtAlloc(NSCondition) init]; 
	m_lock.name = @"myLock";
	
	[m_lock lock];

#if INTHREAD
	m_flags.locked = YES;
#endif	

	@try
	{
		[self updateTimestamp];

		m_connection = [GtAlloc(NSURLConnection) initWithRequest:m_request 
				delegate:self startImmediately:NO];
		
#if INTHREAD
        [NSThread detachNewThreadSelector:@selector(myConnectionThread:) toTarget:self withObject:self];
#else
        [m_connection scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        [m_connection start];
        
        m_timeoutTimer = [NSTimer timerWithTimeInterval:2.0
				target:self 
				selector:@selector(onTimeoutCheck:) 
				userInfo:nil 
				repeats:YES];
				
        [[NSRunLoop mainRunLoop] addTimer:m_timeoutTimer 
			forMode:NSRunLoopCommonModes];
#endif        
        
	
#if DEBUG
		GtTrace(GtTraceNetworkRequests, @"waiting for lock to release");
		int spinCount = 0;
#endif

#if INTHREAD
		while(m_flags.locked)
#endif
		{
#if DEBUG
			GtTrace(GtTraceNetworkRequests, @"waiting on lock, spincount = %d", spinCount++);
#endif		
			[m_lock wait];
			
		}
		
		if(m_flags.cancelled)
		{
			GtReleaseWithNil(m_receivedData);
		}
		
	}
	@finally
	{
		[m_lock unlock];
#if DEBUG
		GtTrace(GtTraceNetworkRequests, @"lock released, moving forward");
#endif

        [self stopTimeoutTimer];

        m_delegate = nil; 

        GtReleaseWithNil(m_request);
        GtReleaseWithNil(m_lock);

        [m_connection unscheduleFromRunLoop:[NSRunLoop mainRunLoop] 
            forMode:NSDefaultRunLoopMode];

        GtReleaseWithNil(m_connection);
    
	}
    
}

- (void) cancel
{
	if(!m_flags.cancelled)
	{
		@synchronized(self) 
		{
            [self stopTimeoutTimer];
        
			if(!m_flags.cancelled)
			{
#if DEBUG
				GtTrace(GtTraceNetworkRequests, @"network request cancelled");
#endif
				m_flags.cancelled = YES;
				if(m_connection)
				{
					[m_connection cancel];
				}

                NSError* error = [GtAlloc(NSError) initWithDomain:NSURLErrorDomain code:NSURLErrorCancelled userInfo:nil];
                self.error = error;
                GtRelease(error);

				[self unlock];
			}
		}
	}
}

- (BOOL) wasCancelled
{
	return m_flags.cancelled;
}

- (void) connection:(NSURLConnection *)connection 
 didReceiveResponse:(NSURLResponse *)response
{
// This method is called when the server has determined that it has
//	 enough information to create the NSURLResponse. It can be called
//	 multiple times, for example in the case of a redirect, so each time
//	 we reset the data. 
	@synchronized(self) 
	{ 
#if DEBUG
        GtTrace(GtTraceNetworkRequests, @"got response");
#endif

		[self updateTimestamp];
		self.response = response;
		[m_receivedData setLength:0];
	}
}

- (void) connection:(NSURLConnection*)connection 
	 didReceiveData:(NSData *)data
{
    @synchronized(self) 
	{ 
#if DEBUG
        GtTrace(GtTraceNetworkRequests, @"received %d bytes", [data length]);
#endif

		[self updateTimestamp];

		// Append the new data to the received data. 
		if(m_receivedData)
		{
			[m_receivedData appendData:data];
		}
	}
}

- (void) connection:(NSURLConnection*)connection 
   didFailWithError:(NSError *)error
{
	@synchronized(self) 
	{
        NSLog(@"got network error: %@\n\tuserinfo:%@", [error description], error.userInfo);

        @try
        {
            [self updateTimestamp];

            self.error = error;
        }
        @finally
        {
            [self unlock];
        }
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	@synchronized(self) 
	{
    	[self updateTimestamp];

        [self unlock];
    }
}

- (NSCachedURLResponse *) connection:(NSURLConnection *)connection 
				   willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
	// this application does not use a NSURLCache disk or memory cache 
    return nil;
}

- (void)connection:(NSURLConnection *)connection 
	didSendBodyData:(NSInteger)bytesWritten 
	totalBytesWritten:(NSInteger)totalBytesWritten 
	totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
	@synchronized(self) 
	{
#if DEBUG
        GtTrace(GtTraceNetworkRequests, @"sent bytes: %d. Total: %d of %d", bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
#endif

        [self updateTimestamp];

#if DEBUG
        if(GtTestBoolEnvironmentVariable(GtFake3gUploadError) && totalBytesWritten > 200 * 1024)
        {
            [self connection:connection 
                didFailWithError:[NSError errorWithDomain:NSPOSIXErrorDomain code:EPERM userInfo: nil]];
                
            [m_connection cancel];
				    
        }
#endif

        if(m_delegate)
        {
            [m_delegate networkRequest:self 
                didSendBodyData:bytesWritten 
                totalBytesWritten:totalBytesWritten 
                totalBytesExpectedToWrite:totalBytesExpectedToWrite];
        }
    }
}


+ (void) setTimeoutInSeconds:(NSTimeInterval) timeout
{
	s_timeout = timeout;
}

+ (NSTimeInterval) timeoutInSeconds
{
	return s_timeout;
}

@end

/*
    
    NOT USED

*/ 

#if INTHREAD

- (void) doRunLoop:(NSRunLoop*) runLoop
{
	[m_connection scheduleInRunLoop:runLoop forMode:NSDefaultRunLoopMode];
	[m_connection start];

	while(m_flags.locked)
	{
 //       GtLog(@"In network run loop");
		[runLoop runUntilDate:[NSDate date]];
	}
}

- (void) myConnectionThread:(id) sender
{
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];

	@try
	{
    
        NSRunLoop* runLoop = [NSRunLoop currentRunLoop];
/*	
        m_timeoutTimer = [NSTimer timerWithTimeInterval:2.0
				target:self 
				selector:@selector(onTimeoutCheck:) 
				userInfo:nil 
				repeats:YES];
				
        [runLoop addTimer:m_timeoutTimer 
			forMode:NSRunLoopCommonModes];
*/

#if TRACE
        if(GtTestBoolEnvironmentVariable(GtFakeNetworkTimeouts))
		{
			while(m_flags.locked)
			{
				[runLoop runUntilDate:[NSDate date]];
			}
		}
		else
		{
			[self doRunLoop:runLoop];
		}
    	
#else 
		[self doRunLoop:runLoop];
#endif

    }
    @catch(NSException* ex)
    {
        [[GtDefaultErrorHandler instance] onHandleUncaughtException:ex];
    }
    @finally 
	{
        [self stopTimeoutTimer];
		
#if TRACE
		GtConditionalLog(m_doTrace, @"Thread exited");
#endif	
		GtRelease(pool);
		
		[m_lock signal];
	}
    
}
#endif
