//
//  GtHttpRequest.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/22/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtHttpConnection.h"
#import "GtGlobalNetworkActivityIndicator.h"

#if DEBUG
#define TEST_TIMEOUT 0
#endif

@interface GtHttpConnection ()
@property (readwrite, retain, nonatomic) CFHTTPStreamWrapper* inputStream;
@property (readwrite, retain, nonatomic) NSError* error;
- (void) _finishAsyncRequest;
- (void) _closeRequest;
@end

#define GtSynthesizeConnectionCallbackSetter(name, callbackType, member) \
- (void) name:(callbackType) inBlock { \
    GtAssert(m_flags.canConfigure, @"can only set blocks in configure block"); \
    GtCopyBlock(member, inBlock); \
}

@implementation GtHttpConnection

@synthesize delegate=m_delegate;
@synthesize error = m_error;
@synthesize inputStream = m_inputStream;
@synthesize timeoutInterval = m_timeoutInterval;
@synthesize httpResponse = m_response;
@synthesize lastActivityTimestamp = m_timestamp;
@synthesize retryCount = m_retryCount;
@synthesize maxRetryCount = m_maxRetryCount;
GtSynthesizeStructProperty(canRetry, setCanRetry, BOOL, m_flags);

- (GtHttpRequest*) httpRequest
{
    return [m_requestQueue firstObject];
}

- (id) init
{
    if((self = [super init]))
    {
        m_timeoutInterval = GtHttpRequestDefaultTimeout;
        m_requestQueue = [[NSMutableArray alloc] initWithCapacity:1];

// TODO: make default way to set these per app.
        m_maxRetryCount = 1;
        m_flags.canRetry = YES;
    }
    
    return self;

}

-(id) initWithHttpRequest:(GtHttpRequest*) request
{
    if((self = [self init]))
    {
        [m_requestQueue addObject:request];
    }
    
    return self;
}

+ (id) httpConnection:(GtHttpRequest*) request
{
    return GtReturnAutoreleased([[[self class] alloc] initWithHttpRequest:request]);
}

- (void) _startActivityIndicator
{
    if(!m_flags.startedActivityIndicator)
    {
        m_flags.startedActivityIndicator = YES;
        [[GtGlobalNetworkActivityIndicator globalNetworkActivityIndicator] showNetworkActivityIndicator];
    }
}

- (void) _stopActivityIndicator
{
    if(m_flags.startedActivityIndicator)
    {
        m_flags.startedActivityIndicator = NO;
        [[GtGlobalNetworkActivityIndicator globalNetworkActivityIndicator] hideNetworkActivityIndicator];
    }
}

- (void) dealloc 
{
    [self _stopActivityIndicator];

    GtRelease(m_requestQueue);
    GtRelease(m_response);
    GtRelease(m_inputStream);
    GtRelease(m_error);
    GtSuperDealloc();
}

- (void) handleCancel
{
    BOOL wasCancelled = NO;
    @synchronized(self) {
        if(self.inputStream)
        {
            wasCancelled = YES;
            self.error = [NSError cancelError];
        
            [self _closeRequest];
        }
    }

    if( wasCancelled && [m_delegate respondsToSelector:@selector(httpConnectionWasCancelled:)])
    {
        [m_delegate httpConnectionWasCancelled:self];
    }
    
    [self _finishAsyncRequest];
}

- (BOOL) wasCancelled 
{
    @synchronized(self) {
        return m_error != nil && [m_error isCancelError];
    }
    return NO;
}

- (void) cancelRequest
{
    @synchronized(self) {
        [self performSelector:@selector(handleCancel) onThread:m_thread withObject:nil waitUntilDone:NO];
    }
}

- (void) prepareRequest
{
}

- (void) _openRequest
{
    GtReleaseWithNil(m_error);
    GtReleaseWithNil(m_response);
    m_response = [[GtHttpResponse alloc] init];
    m_flags.finished = NO;
    m_flags.timedOut = NO;
    [self updateLastActivityTimestamp];

    self.inputStream = [[m_requestQueue lastObject] openHttpRequest];
    self.inputStream.delegate = self;
    [self.inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    if(![self.inputStream open])
    {
        GtThrowError(self.inputStream.error);
    }
}

- (void) _closeRequest
{
    self.inputStream.delegate = nil;
    [[m_requestQueue lastObject] closeHttpRequest];
    [self.inputStream close];
    [self.inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    self.inputStream = nil;
}

- (void) readResponseHeaders:(CFHTTPStreamWrapper*) readStream 
{
    CFHTTPMessageWrapper* httpMsg = readStream.responseHeader;
    if(httpMsg.isHeaderComplete)
    {
        m_response.responseHeaders = httpMsg.allHeaders;
        m_response.responseStatusLine = httpMsg.responseStatusLine;
        m_response.responseStatusCode = httpMsg.responseStatusCode;
        
        if([m_delegate respondsToSelector:@selector(httpConnection:didReceiveResponse:)])
        {
            [m_delegate httpConnection:self didReceiveResponse:m_response];
        }
    } 
}

- (void) readAvailableBytes:(CFHTTPStreamWrapper*) readStream
{
	while(readStream.hasBytesAvaialable)
    {
// TODO: revisit this number? TODO: Get this from header? 

        static long long bufferSize = 16384;
        
    //	if (contentLength > 262144) {
    //		bufferSize = 262144;
    //	} else if (contentLength > 65536) {
    //		bufferSize = 65536;
    //	}

        UInt8 buffer[bufferSize];
        NSInteger bytesRead = [readStream read:buffer maxLength:sizeof(buffer)];
        if(bytesRead > 0)
        {
            [m_response.responseData appendBytes:buffer length:bytesRead];
        }
        
//        if([m_delegate respondsToSelector:@selector(httpConnection:didReceiveBytes:length:)])
//        {
//            [m_delegate httpConnection:self didReceiveBytes:buffer length:bytesRead];
//        }
    }
}

- (void) updateLastActivityTimestamp
{
    m_timestamp = [NSDate timeIntervalSinceReferenceDate];
}

- (void) _updateSentProgress
{
    if([m_delegate respondsToSelector:@selector(httpConnection:sentBytes:totalSentBytes:totalBytesExpectedToSend:)])
    {
        unsigned long long bytesSent = m_inputStream.bytesSent;
        if(bytesSent > m_bytesSent)
        {
            m_lastBytesSent =  bytesSent - m_bytesSent;
            m_bytesSent = bytesSent;

#if TRACE
            GtLog(@"bytes this time: %qu, total bytes sent: %qu, expected to send: %qu",  m_lastBytesSent, m_bytesSent, [[m_requestQueue lastObject] postLength]);
#endif
            [m_delegate httpConnection:self sentBytes:m_lastBytesSent totalSentBytes:m_bytesSent totalBytesExpectedToSend:[[m_requestQueue lastObject] postLength]];
       }
    }
}

- (BOOL) shouldRedirectToURL:(NSURL*) url
{
    BOOL redirect = YES;
    if([m_delegate respondsToSelector:@selector(httpConnection:shouldRedirectToURL:)])
    {
        redirect = [m_delegate httpConnection:self shouldRedirectToURL:url];
    }

    return redirect;
}

- (void) startRedirectToURL:(NSURL*) url
{
    GtHttpRequest* newRequest = [[m_requestQueue lastObject] copy];
    newRequest.requestUrl = url;
    [m_requestQueue addObject:newRequest];
    GtRelease(newRequest);
	
    [self _openRequest];
}

- (void) readStreamBytesAvailable:(CFHTTPStreamWrapper*) readStream
{
    [self updateLastActivityTimestamp];
    if(!m_response.responseHeaders)
    {
        [self readResponseHeaders:readStream];
    }
    [self readAvailableBytes:readStream];
}
            
- (void) readStreamEndEncountered:(CFHTTPStreamWrapper*) readStream
{
    [self updateLastActivityTimestamp];
    if(!m_response.responseHeaders)
    {
        [self readResponseHeaders:readStream];
    }
    [self _updateSentProgress];
    [self _closeRequest];

    if(m_response.wantsRedirect)
    {
        NSURL* redirectURL = [NSURL URLWithString:[m_response headerValue:@"Location"] 
                                relativeToURL:[[m_requestQueue lastObject] requestUrl]];
    
        if([self shouldRedirectToURL:redirectURL])
        {
            [self startRedirectToURL:redirectURL];
            
            return; // else we're done.
        }
    }
    
    m_flags.finished = YES;
    
    if([m_delegate respondsToSelector:@selector(httpConnectionDidComplete:)])
    {
        [m_delegate httpConnectionDidComplete:self];
    }

    [self _finishAsyncRequest];
}

- (void) readStreamOpenCompleted:(CFReadStreamWrapper*) readStream
{
    [self updateLastActivityTimestamp];
    // TODO: add delegate event?
}

- (BOOL) _retryIfPossible
{
    if(!self.wasCancelled &&
        m_flags.canRetry && 
        m_retryCount < m_maxRetryCount &&
        (!m_delegate || [m_delegate httpConnectionShouldRetry:self]))
    {
        m_retryCount++;
        GtLog(@"Retrying request: %d of %d retries.", m_retryCount, m_maxRetryCount);
    
        [self _openRequest];
        return YES;
    }
    
    return NO;
}

- (void) readStreamErrorOccurred:(CFReadStreamWrapper*) readStream
{
    GtAssignObject(m_error, readStream.error);
    [self updateLastActivityTimestamp];
    [self _closeRequest];

    GtLog(@"stream received error: %@", [m_error description]);
        
    if(![self _retryIfPossible])
    {
        m_flags.finished = YES;
        
        if([m_delegate respondsToSelector:@selector(httpConnection:didFailWithError:)])
        {
            [m_delegate httpConnection:self didFailWithError:m_error];
        }
            
        [self _finishAsyncRequest];
    }
}
            
- (void) readStreamCanAcceptBytes:(CFReadStreamWrapper*) readStream
{
    [self updateLastActivityTimestamp];
    // TODO: add delegate event?
}

- (NSTimeInterval) idleTimeInterval
{
    return ([NSDate timeIntervalSinceReferenceDate] - m_timestamp);
}

- (BOOL) _checkTimeout:(NSTimeInterval) idleSeconds
{
#if TEST_TIMEOUT
    return m_retryCount < m_maxRetryCount;

    return YES;
#endif

	return (m_timeoutInterval > 0.0f) && (idleSeconds > m_timeoutInterval);
}

- (BOOL) hasTimedOut
{
    return [self _checkTimeout:self.idleTimeInterval];
}

- (void) _handleTimerEvent:(NSTimer*) timer
{
#if TEST_TIMEOUT
    [NSThread sleepForTimeInterval:2.0f];
#endif

    NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
    NSTimeInterval idleSeconds = now - m_timestamp;
    
    if([self _checkTimeout:idleSeconds])
    {
        if(!m_flags.timedOut)
        {
            m_flags.timedOut = YES;
            GtLog(@"request timed out");

            [self _closeRequest];

            NSError* timeout = [[NSError alloc] initWithDomain:NSURLErrorDomain code:NSURLErrorTimedOut userInfo:nil];
            self.error = timeout;
            GtReleaseWithNil(timeout);
        
            if(![self _retryIfPossible])
            {
                if([m_delegate respondsToSelector:@selector(httpConnectionDidTimeout:)])
                {
                    [m_delegate httpConnectionDidTimeout:self];
                }
            
                [self _finishAsyncRequest];
            }
        }
    }
    else 
    {
        if(idleSeconds > 1.0f || m_lastIdleTimeSpan > 0)
        {
            if(((now - m_lastIdleEvent) >= 1.0f))
            {
                if(idleSeconds <= 1.0f)
                {
                    m_lastIdleTimeSpan = 0;
                }
                else
                {
                    m_lastIdleTimeSpan = idleSeconds;
                }
            
                m_lastIdleEvent = now;
                
                if([m_delegate respondsToSelector:@selector(httpConnection:isIdle:)])
                {
                    [m_delegate httpConnection:self isIdle:m_lastIdleTimeSpan];
                }
            }
        }
    
        [self _updateSentProgress];
    }
} 

- (void) _stopTimer
{
    if(m_timeoutTimer)
    {
        [m_timeoutTimer invalidate];
        m_timeoutTimer = nil;
    }
}

- (void) beginAsyncRequest
{
    GtAutorelease(GtRetain(self));
    @try {
        [self _stopTimer];
        [self _startActivityIndicator];
        
        m_flags.timedOut = NO;
        m_flags.finished = NO;
        GtReleaseWithNil(m_error);
        m_thread = [NSThread currentThread];

        [self prepareRequest];

        if([m_delegate respondsToSelector:@selector(httpConnectionWillBegin:)])
        {
            [m_delegate httpConnectionWillBegin:self];
        }
                
        [self _openRequest];
        
// TODO: this .25 for progress. It could be closer to 1 second if
// we don't need to report progress.        
        m_timeoutTimer = [NSTimer timerWithTimeInterval:0.25f 
            target:self 
            selector:@selector(_handleTimerEvent:) 
            userInfo:nil 
            repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:m_timeoutTimer forMode:NSDefaultRunLoopMode];
    }
    @catch(NSException* ex)
    {
        GtAssignObject(m_error, ex.error);
        
        if([m_delegate respondsToSelector:@selector(httpConnection:didFailWithError:)])
        {
            [m_delegate httpConnection:self didFailWithError:m_error];
        }

        [self _finishAsyncRequest];
    }
}

- (void) _finishAsyncRequest
{
    [self _stopActivityIndicator];
    [self _stopTimer];
    m_thread = nil;
}

- (void) performSynchronously
{
    [self beginAsyncRequest];
    @try {
        while(  !m_flags.finished && 
                !m_flags.timedOut && 
                !self.error)
        {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
    }
    @finally {
    // just in case. This should have already been called,
    // but it doesn't hurt to make sure. 
        [self _finishAsyncRequest];
    }
}

@end
