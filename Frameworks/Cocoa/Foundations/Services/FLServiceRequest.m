////
////  FLServiceMessage.m
////  FishLampCocoa
////
////  Created by Mike Fullerton on 12/24/12.
////  Copyright (c) 2012 Mike Fullerton. All rights reserved.
////
//
//#import "FLServiceRequest.h"
//
//
//
//@interface FLServiceRequest ()
//@end
//
//@implementation FLServiceRequest
//
//@synthesize serviceID = _serviceType;
//@synthesize requestType = _actionType;
//
//
////- (void)encodeWithCoder:(NSCoder *)aCoder {
////    [aCoder encodeObject:_requestType forKey:@"requestType"];
////    [aCoder encodeObject:_serviceType forKey:@"serviceID"];
////    if(_arguments) {
////        [aCoder encodeObject:_arguments forKey:@"arguments"];
////    }
////}
////- (id)initWithCoder:(NSCoder *)aDecoder {
////    self = [super init];
////    if(self) {
////    	self.serviceID = [aDecoder decodeObjectForKey:@"serviceID"];
////    	self.requestType = [aDecoder decodeObjectForKey:@"requestType"];
////        self.arguments = [aDecoder decodeObjectForKey:@"arguments"];
////	}
////    
////    return self;
////}
////
//
//
//
//#if FL_MRC
//- (void) dealloc {
//    [_requestType release];
//    [_serviceType release];
//    [super dealloc];
//}
//#endif
//
//
////- (id)copyWithZone:(NSZone *)zone {
////    return [[FLServiceRequest alloc] initWithServiceType:self.serviceID 
////                                             requestType:self.requestType 
////                                               arguments:self.arguments];
////}
//
//- (id) initWithServiceType:(id) serviceID 
//               requestType:(id) requestType {
//    return [self initWithServiceType:serviceID requestType:requestType withObject:nil withObject:nil withObject:nil];
//}               
//
//- (id) initWithServiceType:(id) serviceID 
//               requestType:(id) requestType
//                withObject:(id) argument1 {
//    return [self initWithServiceType:serviceID requestType:requestType withObject:argument1 withObject:nil withObject:nil];
//}               
//
//- (id) initWithServiceType:(id) serviceID 
//               requestType:(id) requestType
//                 withObject:(id) argument1 
//                 withObject:(id) argument2 {
//    return [self initWithServiceType:serviceID requestType:requestType withObject:argument1 withObject:argument2 withObject:nil];
//}               
//
//- (id) initWithServiceType:(id) serviceID 
//               requestType:(id) requestType
//                withObject:(id) argument1 
//                withObject:(id) argument2 
//                withObject:(id) argument3 {
//    self = [super initWithArgument:argument1 withObject:argument2 withObject:argument3];
//    if(self) {
//        _serviceType = serviceID;
//        _requestType = requestType;
//    }
//
//    return self;
//}
//
//+ (id) serviceRequest:(id) serviceID 
//          requestType:(id) requestType {
//    return FLAutorelease([[[self class] alloc] initWithServiceType:serviceID requestType:requestType withObject:nil withObject:nil withObject:nil]);
//}
//
//+ (id) serviceRequest:(id) serviceID 
//          requestType:(id) requestType
//           withObject:(id) argument1 {
//    return FLAutorelease([[[self class] alloc] initWithServiceType:serviceID requestType:requestType withObject:argument1 withObject:nil withObject:nil]);
//}
//
//
//+ (id) serviceRequest:(id) serviceID 
//          requestType:(id) requestType
//           withObject:(id) argument1 
//           withObject:(id) argument2 {
//    return FLAutorelease([[[self class] alloc] initWithServiceType:serviceID requestType:requestType withObject:argument1 withObject:argument2 withObject:nil]);
//}
// 
//
//+ (id) serviceRequest:(id) serviceID 
//          requestType:(id) requestType
//           withObject:(id) argument1 
//           withObject:(id) argument2 
//           withObject:(id) argument3 {
//    return FLAutorelease([[[self class] alloc] initWithServiceType:serviceID requestType:requestType withObject:argument1 withObject:argument2 withObject:argument3]);
//}
//
//
//
//
//@end
//
////@implementation FLReadServiceRequest : FLServiceRequest
////+ (id) readServiceRequest:(id) key serviceID:(id) serviceID;
////@end
////
////@implementation FLWriteServiceRequest : FLServiceRequest
////+ (id) writeServiceRequest:(id) object serviceID:(id) serviceID;
////@end
