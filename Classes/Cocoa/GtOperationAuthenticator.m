//
//	GtOperationAuthenticator.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/22/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtOperationAuthenticator.h"
#import "GtOperation.h"

#ifdef DEBUG
#define LOG 0
#endif
#if LOG
#warning LOG enabled
#endif

@implementation GtOperationAuthenticator

- (NSError*) doAuthenticateOperation:(GtOperation*) operation
{
	return nil;
}

- (BOOL) shouldAuthenticateOperation:(GtOperation*) operation
{
	return NO;
}

- (void) prepareAuthenticatedOperation:(GtOperation*) operation
{
}

- (void) configureDefaultSecurityForOperation:(GtOperation*) operation
{
}

- (NSError*) authenthicateOperation:(GtOperation*) operation
{ 
	GtAssertNotNil(operation);

	NSError* error = nil;

	if(GtBitMaskTest(operation.securityBehavior, GtOperationAuthenticationBehaviorAuthenticate))
	{
		if([self shouldAuthenticateOperation:operation])
		{
#if LOG
			GtLog(@"Will attempt to get lock for authentication: %@", NSStringFromClass([operation class]));
#endif		   
			@synchronized(self) 
			{
#if LOG
				GtLog(@"Got lock for authentication: %@", NSStringFromClass([operation class]));
#endif		   
				if([self shouldAuthenticateOperation:operation])
				{
					GtAssertNotNil(operation);

#if LOG
					GtLog(@"Operation will authenticate for operation: %@", NSStringFromClass([operation class]));
#endif		 
					
					error = [self doAuthenticateOperation:operation];
				}
#if DEBUG
				else
				{
#if LOG
					GtLog(@"Authentication not needed for: %@", NSStringFromClass([operation class]));
#endif 
				}
#endif				
			}
		}
#if DEBUG
		else
		{
#if LOG
			GtLog(@"Authentication and lock not needed for: %@", NSStringFromClass([operation class]));
#endif 
		}
#endif	  
	}

	if(!error && GtBitMaskTest(operation.securityBehavior, GtOperationAuthenticationBehaviorPrepare))
	{
		[self prepareAuthenticatedOperation:operation];
	}
	
	return error;
}

//- (void) prepareOperationIfSecure:(GtOperation*) operation
//{
//	GtAssertNotNil(operation);
//	GtAssertNotNil(operation.securityCredentials);
//
//	if(GtBitMaskTest(operation.securityBehavior, GtOperationAuthenticationBehaviorPrepare))
//	{
//		[self prepareAuthenticatedOperation:operation];
//	}
//}



@end