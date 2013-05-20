//
//	NSError.h
//	FishLamp
//
//	Created by Mike Fullerton on 5/22/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
// WARNING: don't import anything here. This file is imported by FishLamp.  This is imported by everything.

@interface NSError (GtExtras) 

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

