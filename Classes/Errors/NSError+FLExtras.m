//
//	NSError.m
//	FishLamp
//
//	Created by Mike Fullerton on 5/22/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "NSError+FLExtras.h"
#import "NSException+FLExtras.h"
#import "FLErrors.h"
#import "FLStringUtils.h"
#import "FLDebug.h"

@implementation NSError (FLExtras)

- (id) initWithException:(NSException*) exception {
	if((self = [super init])) {
    //default values
		NSString* domain = FLFishlampErrorDomain;
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
    return FLReturnAutoreleased([[NSError alloc] initWithDomain:domain code:code userInfo:[NSDictionary dictionaryWithObject:localizedDescription forKey:NSLocalizedDescriptionKey]]);
}

+ (NSError*) errorWithException:(NSException*) exception {
	return FLReturnAutoreleased([[NSError alloc] initWithException:exception]);
}

- (BOOL) isErrorCode:(NSInteger) code domain:(NSString*) domain {
	return code == self.code && FLStringsAreEqual(domain, self.domain);
}

- (BOOL) isDomain:(NSString*) domain {
	return FLStringsAreEqual(domain, self.domain);
}

- (NSException*) exception {
	return (NSException*) [self.userInfo objectForKey:@"ex"];
}

// TODO(move these network errors into a NSError category in the network code)

- (BOOL) didTimeout {
	return	FLStringsAreEqual(NSURLErrorDomain, self.domain) && 
			self.code == NSURLErrorTimedOut; 
}

- (BOOL) didLoseNetwork {
	return	FLStringsAreEqual(NSURLErrorDomain, self.domain) &&
			((self.code == NSURLErrorNetworkConnectionLost) || 
			(self.code == NSURLErrorNotConnectedToInternet));
}

+ (NSError*) cancelError {
	return FLReturnAutoreleased([[NSError alloc] initWithDomain:NSURLErrorDomain 
                                                           code:NSURLErrorCancelled 
                                                       userInfo:[NSDictionary dictionaryWithObject:NSLocalizedString(@"Cancelled", @"used in cancel error localized description") 
                                                                                            forKey:NSLocalizedDescriptionKey]]);
}

- (BOOL) isCancelError {
	return	FLStringsAreEqual(NSURLErrorDomain, self.domain) && 
			self.code == NSURLErrorCancelled; 
}

- (BOOL) isNotConnectedToInternetError {
	return FLStringsAreEqual(NSURLErrorDomain, self.domain) && self.code == NSURLErrorNotConnectedToInternet;
}

#if UNIT_TEST

//+ (void) unitTestThrowAutoReleasePools:(FLUnitTest*) test
//{
//	  @try
//	  {
//		  NSAutoreleasePool* outer = [[NSAutoreleasePool alloc] init];
//		  @try
//		  {
//			  NSAutoreleasePool* inner = [[NSAutoreleasePool alloc] init];
//			  @try
//			  {
//				  FLThrowError([NSError errorWithDomain:@"test error" code:12345 userInfo:nil]);
//			  }
//			  @catch(NSException* ex)
//			  {
//				FLDrainPoolAndRethrow(&inner, ex);
//			  }
//		  }
//		  @catch(NSException* ex)
//		  {
//			  FLDrainPoolAndRethrow(&outer, ex);
//		  }	   
//	  }
//	  @catch(NSException* ex)
//	  {
//		  UTLog([ex description]);
//	  }
//}

#endif


@end


