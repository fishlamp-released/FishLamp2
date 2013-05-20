//
//	NSException(WithError).h
//	FishLamp
//
//	Created by Mike Fullerton on 9/22/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
// WARNING: don't import anything here. This file is imported by FishLamp.  This is imported by everything.

@interface NSException (GtExtras) 

@property (readonly, retain, nonatomic) NSError* error;

- (id) initWithError:(NSError*)error;

+ (NSException *)exceptionWithError:(NSError*)error;

@end

    
