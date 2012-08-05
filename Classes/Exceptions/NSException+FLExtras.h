//
//	NSException(WithError).h
//	FishLamp
//
//	Created by Mike Fullerton on 9/22/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLCoreFlags.h"
#import "FLCoreObjC.h"

@interface NSException (FLExtras) 

@property (readonly, retain, nonatomic) NSError* error;

- (id) initWithError:(NSError*)error;

+ (NSException *)exceptionWithError:(NSError*)error;

@end


