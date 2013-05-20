//
//  GtDefaultErrorHandler.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/17/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtDefaultErrorHandler.h"

#import "GtReachability.h"
#import "GtWindow.h"
#import "GtFileUtilities.h"
#import "GtDevice.h"
#import "GtStringBuilder.h"
#import "GtUserNotificationView.h"

#import <execinfo.h>

@implementation GtDefaultErrorHandler

//GtSynthesize(reachability, setReachability, GtReachability, m_reachability);

@synthesize reachability = m_reachability;

- (NSString*) folder
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	return [paths objectAtIndex: 0];
}

- (NSString*) logFileName
{
	return [[self folder] stringByAppendingPathComponent:[GtFileUtilities timeStampedName:@"crash" optionalExtension:@".log"]]; 
}

- (void) printStackToLogFile:(NSString*) title 
                        info:(NSString*) info
                   callstack:(void*) callstack 
                   frameCount:(int) frameCount
{
    @synchronized(self)
    {
        @try
        {
            GtStringBuilder* builder = [GtAlloc(GtStringBuilder) initWithPrettyPrint:YES];
            
            [builder appendLineWithFormat:@"<begin>\n%@: %@", title, [NSDate date]];
            [builder appendLineWithFormat:@"Info: %@", info];
            [builder appendLineWithFormat:@"Product:%@", [GtFileUtilities appName]];
            [builder appendLineWithFormat:@"Version:%@", [GtFileUtilities appVersion]];
            [builder appendLineWithFormat:@"Device:%@", [UIDevice currentDevice].machineName];
            [builder appendLineWithFormat:@"SystemName:%@", [UIDevice currentDevice].systemName];
            [builder appendLineWithFormat:@"SystemVersion:%@", [UIDevice currentDevice].systemVersion];
            
            if(callstack)
            {
                char** strs = backtrace_symbols(callstack, frameCount);
                for (int i = 0; i < frameCount; ++i) 
                {
                    [builder appendLineWithFormat:@"%s", strs[i]];
                }
                free(strs);
            }
            else
            {
                [builder appendLine:@"No callstack available"];
            }
            
            
            [builder appendLine:@"<end>"];
            [builder appendLine];
            
            NSString* output = [builder toString];
            
            GtLog(output);
/*            
            NSError* err = nil;
            [output writeToFile:[self logFileName] atomically:NO encoding:NSUTF8StringEncoding error:&err];
            
            if(err)
            {
                GtLog([err description]);
            }
*/            
            GtRelease(builder);
        }
        @catch(NSException* ex)
        {
            GtLog(@"exception while writing stack crawl: %@", [ex description]);
        }
    }
}

- (BOOL) isCrashLog:(NSString*) path
{
    return [path rangeOfString:@"crash"].length > 0;
}

- (BOOL) hasCrashLogs
{
    NSError* err = nil;
    NSArray* items = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self folder] error:&err]; 
    for(NSString* file in items)
    {
        if([self isCrashLog:file])
        {
            return YES;
        }
    }
    
    return NO;
    
}

- (NSArray*) getAllCrashLogPaths
{
    NSError* err = nil;
    NSArray* items = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self folder] error:&err]; 

    NSMutableArray* outItems = [NSMutableArray array];
    for(NSString* file in items)
    {
        if([self isCrashLog:file])
        {
            [outItems addObject:[[self folder] stringByAppendingPathComponent:file]];
        }
    
    }
    
    return outItems;
}

- (void) deleteAllCrashLogs
{
    NSError* err = nil;
    NSArray* items = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self folder] error:&err]; 
    for(NSString* file in items)
    {
        if([self isCrashLog:file])
        {
            [[NSFileManager defaultManager] removeItemAtPath:[[self folder] stringByAppendingPathComponent:file] error:&err];
        }
    }
}

void PrintExceptionInfo(NSException* exception)
{
    NSArray * addresses = [exception callStackReturnAddresses];
    if(addresses)
    {
        void * backtrace_frames[addresses.count];
   
        for (int i = 0; i < addresses.count; i++)
        {
            backtrace_frames[i] = (void *)[[addresses objectAtIndex:i] unsignedLongValue];
        }

        [[GtDefaultErrorHandler instance] printStackToLogFile:@"Uncaught Exception"
            info:[exception description]
            callstack:backtrace_frames
            frameCount: addresses.count];
    }
    else
    {
        [[GtDefaultErrorHandler instance] printStackToLogFile:@"Uncaught Exception"
            info:[exception description]
            callstack:nil
            frameCount:0];
    }

}

void GtDefaultUncaughtExceptionHandler(NSException* exception)
{
    PrintExceptionInfo(exception);
 /*
    NSArray *callStackArray = [exception callStackReturnAddresses];
    int frameCount = [callStackArray count];
    void *backtraceFrames[frameCount];
    for (int i=0; i<frameCount; i++) {
        backtraceFrames[i] = (void *)[[callStackArray objectAtIndex:i] unsignedIntegerValue];
    }
*/

}

NSString* GtStringForSigType(siginfo_t* info)
{
    switch(info->si_code)
    {
        case SIGQUIT: return @"SIGQUIT";
        case SIGILL: return @"SIGILL";
        case SIGTRAP: return @"SIGTRAP";
        case SIGABRT: return @"SIGABRT";
        case SIGEMT: return @"SIGEMT";
        case SIGFPE: return @"SIGFPE";
        case SIGBUS: return @"SIGBUS";
        case SIGSEGV: return @"SIGSEGV";
        case SIGSYS: return @"SIGSYS";
        case SIGPIPE: return @"SIGPIPE";
        case SIGALRM: return @"SIGALRM";
        case SIGXCPU: return @"SIGXCPU";
        case SIGXFSZ: return @"SIGXFSZ";
    }

    return [NSString stringWithFormat:@"UNKNOWN SIG TYPE: %d", info->si_code];
}

void mysighandler(int sig, siginfo_t *info, void *context) 
{
    void *backtraceFrames[128];
    int frameCount = backtrace(backtraceFrames, 128);
    [[GtDefaultErrorHandler instance] printStackToLogFile:@"Application received termination signal"
        info:GtStringForSigType(info)
        callstack:backtraceFrames
        frameCount:frameCount];
}

GtSynthesizeSingleton(GtDefaultErrorHandler);

- (id) init
{
	if(self = [super init])
	{
        m_notificationView = [GtAlloc(GtWeakReference) init];
        
		NSSetUncaughtExceptionHandler(GtDefaultUncaughtExceptionHandler);
        struct sigaction mySigAction;
        mySigAction.sa_sigaction = mysighandler;
        mySigAction.sa_flags = SA_SIGINFO;
        sigemptyset(&mySigAction.sa_mask);
        sigaction(SIGQUIT, &mySigAction, NULL);
        sigaction(SIGILL, &mySigAction, NULL);
        sigaction(SIGTRAP, &mySigAction, NULL);
        sigaction(SIGABRT, &mySigAction, NULL);
        sigaction(SIGEMT, &mySigAction, NULL);
        sigaction(SIGFPE, &mySigAction, NULL);
        sigaction(SIGBUS, &mySigAction, NULL);
        sigaction(SIGSEGV, &mySigAction, NULL);
        sigaction(SIGSYS, &mySigAction, NULL);
        sigaction(SIGPIPE, &mySigAction, NULL);
        sigaction(SIGALRM, &mySigAction, NULL);
        sigaction(SIGXCPU, &mySigAction, NULL);
        sigaction(SIGXFSZ, &mySigAction, NULL);
	}
	return self;
}


/*

NSString *urlEncodeValue(NSString *str) {
        CFStringRef urlString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                (CFStringRef)str, NULL, CFSTR(";/?:@&=+$,"), kCFStringEncodingUTF8);
        return [(NSString *)urlString autorelease];
}
void bugzScout(NSString *description, NSString *extra) 
{
        NSMutableString *post = [NSMutableString string];
        [post appendString:@"ScoutUserName="];
        [post appendString:urlEncodeValue(@"Your BugzScout User")];
       
        [post appendString:@"&ScoutProject="];
        [post appendString:urlEncodeValue(@"Your Project")];
       
        [post appendString:@"&ScoutArea="];
        [post appendString:urlEncodeValue(@"Your Area")];
       
        [post appendString:@"&Description="];
        [post appendString:urlEncodeValue(description)];
       
        [post appendString:@"&Extra="];
        [post appendString:urlEncodeValue(extra)];
       
        [post appendString:@"&ScoutDefaultMessage=&FriendlyResponse=0&ForceNewBug=0"];
       
        //NSLog(post);
       
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
       
        NSURL *webServiceURL = [NSURL URLWithString:@"https://yourcompany.fogbugz.com/ScoutSubmit.asp"];
        NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:webServiceURL];
       
        [req setHTTPMethod:@"POST"];
        [req addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField: @"Content-Type"];
        [req addValue:postLength forHTTPHeaderField: @"Content-Length"];
        [req setHTTPBody:postData];
       
        [NSURLConnection sendSynchronousRequest:req returningResponse:nil error:nil];   
}
*/

- (void) setReachability:(GtReachability*) reachability
{
    if(m_reachability != reachability)
    {
        GtRelease(m_reachability);
        m_reachability = [reachability retain];
    }
    
    [m_reachability startNotifer];
}

- (void) becomeDefaultHandler
{
	[GtCoreDefaultErrorHandler setInstance:self];

	[[NSNotificationCenter defaultCenter] addObserver: self 
		selector: @selector(reachabilityChanged:) 
		name: GtNetworkReachabilityChangedNotification object:[UIApplication sharedApplication]];
}

- (void) dealloc
{
	[m_notificationView.object hide];
    
    GtRelease(m_notificationView);
	GtRelease(m_reachability);

	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[super dealloc];
}

- (void) reachabilityChanged: (NSNotification* )note
{
    GtReachability* reachability = [note.userInfo objectForKey:[GtReachability class]];
    if(reachability == m_reachability)
    {
        if(reachability.isReachable)
        {
            if(m_notificationView.object)
            {
                [m_notificationView.object hide];
            }
        }
        else if(!m_notificationView.object)
        {
            GtUserNotificationView* view = [GtAlloc(GtUserNotificationView) initAsWarningNotification];;
            view.isModal = YES;
            view.canDismiss = NO;
            view.location = GtNotificationViewLocationCentered;
            
            if( reachability.reachabilityType == GtHostReachability && 
                [GtReachability isConnectedToNetwork])
            {
                view.title = @"Unable to connect to server";
                [view.text appendLineWithFormat:@"%@ may be offline or down for maintainance.", reachability.hostName];
                [view.text appendLine];
                [view.text appendLineWithFormat:@"Please try again later.", reachability.hostName];
            }
            else
            {
                view.title = @"The network is unavailable.";
                [view.text appendString:NSLocalizedStringFromTable(@"GT_NETWORK_UNAVAILABLE_STR", @"FishLamp", nil)];
            }
            
            m_notificationView.object = view;
            [[GtWindow topWindow] addSubview:view];
            GtRelease(view);
        }
    }
}

- (void) onHandleUncaughtException:(NSException*) exception
{
    PrintExceptionInfo(exception);
}

- (void) showDatabaseError:(NSException*) exception
{
	UIAlertView* alert = [GtAlloc(UIAlertView) initWithTitle:NSLocalizedStringFromTable(@"GT_DB_OPERATION_FAILED_STR", @"FishLamp", nil)
					message:[exception description]
					delegate:nil 
					cancelButtonTitle:NSLocalizedStringFromTable(@"GT_OK_STR", @"FishLamp", nil) otherButtonTitles:nil
					];
		
	[alert show];
	GtRelease(alert);
}

- (void) onHandleDatabaseException:(GtObjectDatabase*) database exception:(NSException*) exception
{
	[self performSelectorOnMainThread:@selector(showDatabaseError:) withObject:exception waitUntilDone:YES];
}



@end

