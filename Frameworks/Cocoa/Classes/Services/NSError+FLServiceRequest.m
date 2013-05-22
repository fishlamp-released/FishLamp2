////
////  NSError+FLServiceRequest.m
////  FishLampCocoa
////
////  Created by Mike Fullerton on 12/26/12.
////  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
////
//
//#import "NSError+FLServiceRequest.h"
//
//NSString* const FLServiceRequestErrorKey = @"com.fishlamp.error.service-request";
//
//@implementation NSError (FLServiceRequest)
//
//+ (NSError*) serviceRequestNotHandledError:(NSString*) serviceID {
//    
//    NSString* notHandled = NSLocalizedString(@"Unhandled service request for service type", nil);
//
//    NSString* errorString = [NSString stringWithFormat:@"%@: %@", notHandled, serviceID];
//
//    return [NSError errorWithDomain:FLErrorDomain
//                                   code:FLUnhandledServiceRequestErrorCode
//                                   userInfo:[NSDictionary dictionaryWithObject:serviceID forKey:FLServiceRequestErrorKey]
//                                   reason:errorString
//                                   comment:nil
//                                   stackTrace:FLCreateStackTrace(NO)];
//}
//
//- (BOOL) isUnhandledServiceRequestError {
//	return	FLStringsAreEqual(NSURLErrorDomain, self.domain) && 
//			self.code == FLUnhandledServiceRequestErrorCode; 
//}
//
//- (NSString*) unhandledServiceRequestServiceType {
//    return [self.userInfo objectForKey:FLServiceRequestErrorKey];
//}
//
//@end
//