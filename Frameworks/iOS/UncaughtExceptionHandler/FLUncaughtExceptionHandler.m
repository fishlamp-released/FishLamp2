//
//	UncaughtExceptionHandler.m
//	UncaughtExceptions
//
//	Created by Matt Gallagher on 2010/05/25.
//	Copyright 2010 Matt Gallagher. All rights reserved.
//
//	Permission is given to use this source code file, free of charge, in any
//	project, commercial or otherwise, entirely at your risk, with the condition
//	that any redistribution (in part or whole) of source code must retain
//	this copyright and permission notice. Attribution in compiled projects is
//	appreciated but not required.
//

#import "FLUncaughtExceptionHandler.h"
#include <libkern/OSAtomic.h>
#include <execinfo.h>
#include <unistd.h>


NSString * const UncaughtExceptionHandlerSignalExceptionName = @"UncaughtExceptionHandlerSignalExceptionName";
NSString * const UncaughtExceptionHandlerSignalKey = @"UncaughtExceptionHandlerSignalKey";
NSString * const UncaughtExceptionHandlerAddressesKey = @"UncaughtExceptionHandlerAddressesKey";

volatile int32_t UncaughtExceptionCount = 0;
const int32_t UncaughtExceptionMaximum = 10;

const NSInteger UncaughtExceptionHandlerSkipAddressCount = 4;
const NSInteger UncaughtExceptionHandlerReportAddressCount = 5;

@implementation FLUncaughtExceptionHandler

+ (NSArray *)backtrace
{
	 void* callstack[128];
	 int frames = backtrace(callstack, 128);
	 char **strs = backtrace_symbols(callstack, frames);
	 
	 int i;
	 NSMutableArray *backtraceArray = [NSMutableArray arrayWithCapacity:frames];
	 for (
		i = UncaughtExceptionHandlerSkipAddressCount;
		i < UncaughtExceptionHandlerSkipAddressCount +
			UncaughtExceptionHandlerReportAddressCount;
		i++)
	 {
		[backtraceArray addObject:[NSString stringWithUTF8String:strs[i]]];
	 }
	 free(strs);
	 
	 return backtraceArray;
}

- (void)alertView:(UIAlertView *)anAlertView clickedButtonAtIndex:(NSInteger)anIndex
{
	if (anIndex == 0)
	{
		dismissed = YES;
	}
}

- (void)validateAndSaveCriticalApplicationData
{
	
}

- (void)handleException:(NSException *)exception
{
	FLLog(@"unhandled exception: %@", [exception description]);

//	[self validateAndSaveCriticalApplicationData];
//	
//	UIAlertView *alert =
//		[[[UIAlertView alloc]
//			initWithTitle:NSLocalizedString(@"Unhandled exception", nil)
//			message:[NSString stringWithFormat:NSLocalizedString(
//				@"You can try to continue but the application may be unstable.\n\n"
//				@"Debug details follow:\n%@\n%@", nil),
//				[exception reason],
//				[[exception userInfo] objectForKey:UncaughtExceptionHandlerAddressesKey]]
//			delegate:self
//			cancelButtonTitle:NSLocalizedString(@"Quit", nil)
//			otherButtonTitles:NSLocalizedString(@"Continue", nil), nil]
//		autorelease];
//	[alert showViewControllerAnimated:YES];
//	
//	CFRunLoopRef runLoop = CFRunLoopGetCurrent();
//	CFArrayRef allModes = CFRunLoopCopyAllModes(runLoop);
//	
//	while (!dismissed)
//	{
//		for (NSString *mode in (NSArray *)allModes)
//		{
//			CFRunLoopRunInMode((CFStringRef)mode, 0.001, false);
//		}
//	}
//	
//	CFRelease(allModes);
//
//	NSSetUncaughtExceptionHandler(NULL);
//	signal(SIGABRT, SIG_DFL);
//	signal(SIGILL, SIG_DFL);
//	signal(SIGSEGV, SIG_DFL);
//	signal(SIGFPE, SIG_DFL);
//	signal(SIGBUS, SIG_DFL);
//	signal(SIGPIPE, SIG_DFL);
//	
//	if ([[exception name] isEqual:UncaughtExceptionHandlerSignalExceptionName])
//	{
//		kill(getpid(), [[[exception userInfo] objectForKey:UncaughtExceptionHandlerSignalKey] intValue]);
//	}
//	else
//	{
//		[exception raise];
//	}
}

@end

void HandleException(NSException *exception)
{
	int32_t exceptionCount = OSAtomicIncrement32(&UncaughtExceptionCount);
	if (exceptionCount > UncaughtExceptionMaximum)
	{
		return;
	}
	
	NSArray *callStack = [FLUncaughtExceptionHandler backtrace];
	NSMutableDictionary *userInfo =
		[NSMutableDictionary dictionaryWithDictionary:[exception userInfo]];
	[userInfo
		setObject:callStack
		forKey:UncaughtExceptionHandlerAddressesKey];
	
	[FLAutorelease([[FLUncaughtExceptionHandler alloc] init])
		performSelectorOnMainThread:@selector(handleException:)
		withObject:
			[NSException
				exceptionWithName:[exception name]
				reason:[exception reason]
				userInfo:userInfo]
		waitUntilDone:YES];
}

void SignalHandler(int inSignal)
{
	int32_t exceptionCount = OSAtomicIncrement32(&UncaughtExceptionCount);
	if (exceptionCount > UncaughtExceptionMaximum)
	{
		return;
	}
	
	NSMutableDictionary *userInfo =
		[NSMutableDictionary
			dictionaryWithObject:[NSNumber numberWithInt:inSignal]
			forKey:UncaughtExceptionHandlerSignalKey];

	NSArray *callStack = [FLUncaughtExceptionHandler backtrace];
	[userInfo
		setObject:callStack
		forKey:UncaughtExceptionHandlerAddressesKey];
	
	[FLAutorelease([[FLUncaughtExceptionHandler alloc] init]) 
		performSelectorOnMainThread:@selector(handleException:)
		withObject:
			[NSException
				exceptionWithName:UncaughtExceptionHandlerSignalExceptionName
				reason:
					[NSString stringWithFormat:
						NSLocalizedString(@"Signal %d was raised.", nil),
						inSignal]
				userInfo:
					[NSDictionary
						dictionaryWithObject:[NSNumber numberWithInt:inSignal]
						forKey:UncaughtExceptionHandlerSignalKey]]
		waitUntilDone:YES];
}

void FLInstallUncaughtExceptionHandler()
{
	NSSetUncaughtExceptionHandler(&HandleException);
	signal(SIGABRT, SignalHandler);
	signal(SIGILL, SignalHandler);
	signal(SIGSEGV, SignalHandler);
	signal(SIGFPE, SignalHandler);
	signal(SIGBUS, SignalHandler);
	signal(SIGPIPE, SignalHandler);
}

