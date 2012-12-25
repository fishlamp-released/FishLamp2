//
//  FLServiceMessage.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/24/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* const FLServiceTypeKey;

extern NSString* const FLServiceTypeCache;
extern NSString* const FLServiceTypeStorage;
extern NSString* const FLServiceTypeNetworkServer;

extern NSString* const FLServiceRequestTypeCreate;
extern NSString* const FLServiceRequestTypeRead;
extern NSString* const FLServiceRequestTypeUpdate;
extern NSString* const FLServiceRequestTypeDelete;

extern NSString* const FLServiceRequestTypeFind;


extern NSString* const FLServiceRequestArgumentURL;
extern NSString* const FLServiceRequestArgumentObject;
extern NSString* const FLServiceRequestArgumentImage;

//extern NSString* const FLServiceRequestArgumentDefault;
extern NSString* const FLServiceRequestArgumentSize;

@interface FLServiceRequest : NSObject<NSFastEnumeration, NSCoding, NSCopying> {
@private
    NSDictionary* _arguments;
    id _serviceType;
    id _requestType;
}

@property (readonly, strong, nonatomic) id requestType;
@property (readonly, strong, nonatomic) id serviceType;
@property (readonly, strong, nonatomic) NSDictionary* arguments;

- (id) argumentForKey:(id) key;

- (id) initWithServiceType:(id) serviceType 
               requestType:(id) requestType;

- (id) initWithServiceType:(id) serviceType 
               requestType:(id) requestType
                  argument:(id) argument
               argumentKey:(id) argumentKey;

- (id) initWithServiceType:(id) serviceType 
               requestType:(id) requestType
                 argument:(id) firstArgument, ...;

- (id) initWithServiceType:(id) serviceType 
               requestType:(id) requestType
                 arguments:(NSDictionary*) dictionaryWillBeCopied;

// designated
- (id) initWithServiceType:(id) serviceType 
               requestType:(id) requestType
               argumentsNoCopy:(NSDictionary*) arguments;

+ (id) serviceRequest:(id) serviceType 
          requestType:(id) requestType;

+ (id) serviceRequest:(id) serviceType 
          requestType:(id) requestType
             argument:(id) argument
          argumentKey:(id) argumentKey;

//+ (id) serviceRequest:(id) serviceType 
//          requestType:(id) requestType
//             argument:(id) argument;

+ (id) serviceRequest:(id) serviceType 
          requestType:(id) requestType
             argument:(id) firstArgument, ...;

@end

//@interface FLReadServiceRequest : FLServiceRequest
//+ (id) readServiceRequest:(id) serviceType firstArgument:(id) firstArgument, ...;
//@end
//
//@interface FLWriteServiceRequest : FLServiceRequest
//+ (id) writeServiceRequest:(id) object serviceType:(id) serviceType;
//@end
//
