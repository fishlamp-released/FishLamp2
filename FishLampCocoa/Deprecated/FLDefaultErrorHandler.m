//
//	FLMobileErrorHandler.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/17/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
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

