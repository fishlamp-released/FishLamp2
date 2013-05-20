//
//  GtOuthOperationAuthenticator.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/19/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtOAuthOperationAuthenticator.h"


@implementation GtOAuthOperationAuthenticator

+ (GtOAuthOperationAuthenticator*) OAuthOperationAuthenticator
{
	return GtReturnAutoreleased([[GtOAuthOperationAuthenticator alloc] init]);
}

- (NSError*) doAuthenticateOperation:(GtOperation*) operation 
{
	return nil;
}

- (BOOL) shouldAuthenticateOperation:(GtOperation*) operation
{
	return YES;
}

- (void) prepareAuthenticatedOperation:(GtOperation*) operation
{
	
}

@end
