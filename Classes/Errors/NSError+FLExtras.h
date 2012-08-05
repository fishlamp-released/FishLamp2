//
//	NSError.h
//	FishLamp
//
//	Created by Mike Fullerton on 5/22/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLCoreFlags.h"
#import "FLCoreObjC.h"

@interface NSError (FLExtras) 

- (id) initWithException:(NSException*) exception;

+ (NSError*) errorWithDomain:(NSString*) domain code:(NSInteger) code  localizedDescription:(NSString*) localizedDescription;

+ (NSError*) errorWithException:(NSException*) exception;

+ (NSError*) cancelError;

@property (readonly, retain, nonatomic) NSException* exception;

@property (readonly, assign, nonatomic) BOOL isCancelError;

- (BOOL) isErrorCode:(NSInteger) code domain:(NSString*) domain;
- (BOOL) isDomain:(NSString*) domain;

// Network errors 

// TODO move these
@property (readonly, assign, nonatomic) BOOL didTimeout;
@property (readonly, assign, nonatomic) BOOL didLoseNetwork;
@property (readonly, assign, nonatomic) BOOL isNotConnectedToInternetError;

@end

