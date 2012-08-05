//
//	FLMobileErrorHandler.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/17/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCocoa.h"

@interface FLDefaultErrorHandler : NSObject {
}

// NOTE, to set your own, subclass this and then call [FLMobileErrorHandler setInstance:refToYourErrorHandler
FLSingletonProperty(FLDefaultErrorHandler);

- (void) becomeDefaultHandler;
- (void) onHandleUncaughtException:(NSException *) exception;

@end

extern void FLDefaultUncaughtExceptionHandler(NSException* exception);
