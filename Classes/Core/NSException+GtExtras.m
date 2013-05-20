//
//	NSException(WithError).m
//	FishLamp
//
//	Created by Mike Fullerton on 9/22/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#import "NSException+GtExtras.h"
#import "NSError+GtExtras.h"

#import <execinfo.h>
#import <stdio.h>


@implementation NSException (GtExtras)

- (NSError*) error {	
	return self.userInfo ? [self.userInfo objectForKey:NSUnderlyingErrorKey] : nil;
}

- (id) initWithError:(NSError*)error {
	GtAssert(error.exception == nil, @"Error already has an enclosed exception");

    // copying the error here to prevent exception <-> error retains and memory leaks.

    self = [self initWithName:[NSString stringWithFormat:@"%@:%d", error.domain, error.code]		
                       reason:[error description] 
                     userInfo:[NSDictionary dictionaryWithObject:error forKey:NSUnderlyingErrorKey]]; 

	if(self) {  
	}
	return self;
}

+ (NSException *)exceptionWithError:(NSError*)error {
	return GtReturnAutoreleased([[NSException alloc] initWithError:error]);
}

@end


