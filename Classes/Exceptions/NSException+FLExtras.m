//
//	NSException(WithError).m
//	FishLamp
//
//	Created by Mike Fullerton on 9/22/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//
#import "NSException+FLExtras.h"
#import "NSError+FLExtras.h"
#import "FLAssertions.h"

#import <execinfo.h>
#import <stdio.h>

//
//#if DEBUG
//void FLThrow(NSException* exception)
//{
//	FLTrace(@"Throwing exception: %@", [exception description]); 
//	FLLogStackTrace(); 
//    
//    @throw exception;
//}
//#endif

//NSException* __FLWillThrowException(const char* file, int line, NSException* exception) {
//    if(FLLoggerGetLevel(FLLoggerDefault()) >= FLLoggerLevelMedium) {
//        FLLogStackTrace(FLLoggerLevelMedium);
//        FLLogger(FLLoggerLevelMedium, @"Throwing exception: %@", [exception description]); 
//    }
//    return exception;
//}

@implementation NSException (FLExtras)

- (NSError*) error {	
	return self.userInfo ? [self.userInfo objectForKey:NSUnderlyingErrorKey] : nil;
}

- (id) initWithError:(NSError*)error {
	FLAssert(error.exception == nil, @"Error already has an enclosed exception");

    // copying the error here to prevent exception <-> error retains and memory leaks.

    self = [self initWithName:[NSString stringWithFormat:@"%@:%ld", error.domain, (long) error.code]
                       reason:[error description] 
                     userInfo:[NSDictionary dictionaryWithObject:error forKey:NSUnderlyingErrorKey]]; 

	if(self) {  
	}
	return self;
}

+ (NSException *)exceptionWithError:(NSError*)error {
	return FLReturnAutoreleased([[NSException alloc] initWithError:error]);
}



//- (void) describeToStringBuilder:(FLStringBuilder*) builder
//{
//	[super describeToStringBuilder:builder];
//	[builder appendLineWithFormat:@"%@: %@", self.name, self.reason];
//	if(self.userInfo)
//	{
//		[self.userInfo describeToStringBuilder:builder];
//	}
//}
//
//- (NSString*) description
//{
//	return [self prettyDescription];
//}

//- (BOOL) willPrettyDescribe
//{
//	return YES;
//}



#if UNIT_TEST

//+ (void) unitTestThrowAutoReleasePools:(FLUnitTest*) test
//{
//	  @try
//	  {
//		  NSAutoreleasePool* outer = [[NSAutoreleasePool alloc] init];
//		  @try
//		  {
//			  NSAutoreleasePool* inner = [[NSAutoreleasePool alloc] init];
//			  @try
//			  {
//				  FLThrowException(@"hello", @"test");
//			  }
//			  @catch(NSException* ex)
//			  {
//				  FLDrainPoolAndRethrow(&inner, ex);
//			  }
//		  }
//		  @catch(NSException* ex)
//		  {
//			  FLDrainPoolAndRethrow(&outer, ex);
//		  }
//		  
//	  }
//	  @catch(NSException* ex)
//	  {
//		  UTLog([ex description]);
//	  }
//}

#endif

@end


