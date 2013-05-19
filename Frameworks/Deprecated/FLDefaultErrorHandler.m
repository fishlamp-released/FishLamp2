//
//	FLMobileErrorHandler.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/17/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLDefaultErrorHandler.h"

@implementation FLDefaultErrorHandler

FLSynthesizeSingleton(FLDefaultErrorHandler);

- (void) becomeDefaultHandler
{
}

- (void) onHandleUncaughtException:(NSException*) exception
{
}

@end

