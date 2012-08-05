//
//	FLOperationAuthenticator.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/22/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLOperationAuthenticator.h"
#import "FLOperation.h"

#ifdef DEBUG
#define LOG 0
#endif
#if LOG
#warning LOG enabled
#endif

@implementation FLOperationAuthenticator

- (NSError*) doAuthenticateOperation:(FLOperation*) operation
{
	return nil;
}

- (BOOL) shouldAuthenticateOperation:(FLOperation*) operation
{
	return NO;
}

- (void) prepareAuthenticatedOperation:(FLOperation*) operation
{
}

- (void) configureDefaultSecurityForOperation:(FLOperation*) operation
{
}

- (NSError*) authenthicateOperation:(FLOperation*) operation
{ 
	FLAssertIsNotNil(operation);

	NSError* error = nil;

	if(FLBitTest(operation.securityBehavior, FLOperationAuthenticationBehaviorAuthenticate))
	{
		if([self shouldAuthenticateOperation:operation])
		{
#if LOG
			FLDebugLog(@"Will attempt to get lock for authentication: %@", NSStringFromClass([operation class]));
#endif		   
			@synchronized(self) 
			{
#if LOG
				FLDebugLog(@"Got lock for authentication: %@", NSStringFromClass([operation class]));
#endif		   
				if([self shouldAuthenticateOperation:operation])
				{
					FLAssertIsNotNil(operation);

#if LOG
					FLDebugLog(@"Operation will authenticate for operation: %@", NSStringFromClass([operation class]));
#endif		 
					
					error = [self doAuthenticateOperation:operation];
				}
#if DEBUG
				else
				{
#if LOG
					FLDebugLog(@"Authentication not needed for: %@", NSStringFromClass([operation class]));
#endif 
				}
#endif				
			}
		}
#if DEBUG
		else
		{
#if LOG
			FLDebugLog(@"Authentication and lock not needed for: %@", NSStringFromClass([operation class]));
#endif 
		}
#endif	  
	}

	if(!error && FLBitTest(operation.securityBehavior, FLOperationAuthenticationBehaviorPrepare))
	{
		[self prepareAuthenticatedOperation:operation];
	}
	
	return error;
}

//- (void) prepareOperationIfSecure:(FLOperation*) operation
//{
//	FLAssertIsNotNil(operation);
//	FLAssertIsNotNil(operation.securityCredentials);
//
//	if(FLBitTest(operation.securityBehavior, FLOperationAuthenticationBehaviorPrepare))
//	{
//		[self prepareAuthenticatedOperation:operation];
//	}
//}



@end