//
//	NSError.m
//	FishLamp
//
//	Created by Mike Fullerton on 5/22/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "NSError+GtExtras.h"
#import "NSException+GtExtras.h"

@implementation NSError (GtExtras)

- (id) initWithException:(NSException*) exception {
	if((self = [super init])) {
    //default values
		NSString* domain = GtFishlampErrorDomain;
		NSInteger code = NSURLErrorUnknown;

		NSError* error = exception.error;
		if(error) {
			domain = error.domain;
			code = error.code;
		}

    // copying the exception to prevent exception <-> error retains, and therefore memory leaks.
		
		if((self = [self initWithDomain:domain
								   code:code
							   userInfo:[NSDictionary dictionaryWithObject:exception forKey:@"ex"]])) {
		}
		
	}
	
	return self;
}

+ (NSError*) errorWithDomain:(NSString*) domain code:(NSInteger) code  localizedDescription:(NSString*) localizedDescription {
    return GtReturnAutoreleased([[NSError alloc] initWithDomain:domain code:code userInfo:[NSDictionary dictionaryWithObject:localizedDescription forKey:NSLocalizedDescriptionKey]]);
}

+ (NSError*) errorWithException:(NSException*) exception {
	return GtReturnAutoreleased([[NSError alloc] initWithException:exception]);
}

- (BOOL) isErrorCode:(NSInteger) code domain:(NSString*) domain {
	return code == self.code && GtStringsAreEqual(domain, self.domain);
}

- (BOOL) isDomain:(NSString*) domain {
	return GtStringsAreEqual(domain, self.domain);
}

- (NSException*) exception {
	return (NSException*) [self.userInfo objectForKey:@"ex"];
}

// TODO(move these network errors into a NSError category in the network code)

- (BOOL) didTimeout {
	return	GtStringsAreEqual(NSURLErrorDomain, self.domain) && 
			self.code == NSURLErrorTimedOut; 
}

- (BOOL) didLoseNetwork {
	return	GtStringsAreEqual(NSURLErrorDomain, self.domain) &&
			((self.code == NSURLErrorNetworkConnectionLost) || 
			(self.code == NSURLErrorNotConnectedToInternet));
}

+ (NSError*) cancelError {
	return GtReturnAutoreleased([[NSError alloc] initWithDomain:NSURLErrorDomain 
                                                           code:NSURLErrorCancelled 
                                                       userInfo:[NSDictionary dictionaryWithObject:NSLocalizedString(@"Cancelled", @"used in cancel error localized description") 
                                                                                            forKey:NSLocalizedDescriptionKey]]);
}

- (BOOL) isCancelError {
	return	GtStringsAreEqual(NSURLErrorDomain, self.domain) && 
			self.code == NSURLErrorCancelled; 
}

- (BOOL) isNotConnectedToInternetError {
	return GtStringsAreEqual(NSURLErrorDomain, self.domain) && self.code == NSURLErrorNotConnectedToInternet;
}

#if UNIT_TEST

//+ (void) _testThrowAutoReleasePools:(GtUnitTest*) test
//{
//	  @try
//	  {
//		  NSAutoreleasePool* outer = [[NSAutoreleasePool alloc] init];
//		  @try
//		  {
//			  NSAutoreleasePool* inner = [[NSAutoreleasePool alloc] init];
//			  @try
//			  {
//				  GtThrowError([NSError errorWithDomain:@"test error" code:12345 userInfo:nil]);
//			  }
//			  @catch(NSException* ex)
//			  {
//				GtDrainPoolAndRethrow(&inner, ex);
//			  }
//		  }
//		  @catch(NSException* ex)
//		  {
//			  GtDrainPoolAndRethrow(&outer, ex);
//		  }	   
//	  }
//	  @catch(NSException* ex)
//	  {
//		  UTLog([ex description]);
//	  }
//}

#endif


@end


