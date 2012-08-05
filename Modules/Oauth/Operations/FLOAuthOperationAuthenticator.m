//
//  FLOuthOperationAuthenticator.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/19/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLOAuthOperationAuthenticator.h"


@implementation FLOAuthOperationAuthenticator

+ (FLOAuthOperationAuthenticator*) OAuthOperationAuthenticator
{
	return FLReturnAutoreleased([[FLOAuthOperationAuthenticator alloc] init]);
}

- (NSError*) doAuthenticateOperation:(FLOperation*) operation 
{
	return nil;
}

- (BOOL) shouldAuthenticateOperation:(FLOperation*) operation
{
	return YES;
}

- (void) prepareAuthenticatedOperation:(FLOperation*) operation
{
	
}

@end
