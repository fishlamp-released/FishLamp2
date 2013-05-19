//
//	FLMobileErrorHandler.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/17/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"

@interface FLDefaultErrorHandler : NSObject {
}

// NOTE, to set your own, subclass this and then call [FLMobileErrorHandler setInstance:refToYourErrorHandler
FLSingletonProperty(FLDefaultErrorHandler);

- (void) becomeDefaultHandler;
- (void) onHandleUncaughtException:(NSException *) exception;

@end

extern void FLDefaultUncaughtExceptionHandler(NSException* exception);
