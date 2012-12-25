//
//  FLService.h
//  FLCore
//
//  Created by Mike Fullerton on 11/2/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLServiceRequest.h"
#import "FLFinisher.h"
#import "FLResult.h"

// resources. move these.
extern NSString* FLUserDataObjectDatabase;
extern NSString* FLUserDataCacheDatabase;
extern NSString* FLUserDataImageCacheFolder;

@class FLServiceGroup;

@protocol FLService <NSObject>
@optional

- (void) didMoveToServiceGroup:(FLServiceGroup*) parent;
- (FLFinisher*) didReceiveServiceRequest:(FLServiceRequest*) request 
                              completion:(FLCompletionBlock) completion;

- (void) openService:(id) openedBy;
- (void) closeService:(id) closedBy;

- (id) resourceForKey:(id) key;

@end

@interface FLService : NSObject {
@private
    FLServiceGroup* _services; 
    NSMutableDictionary* _requestHandlers;
}
@property (readonly, assign) FLServiceGroup* services;

- (void) setRequestHandler:(SEL) handler forServiceRequestType:(id) serviceRequestType;


@end

@interface FLServiceGroup : NSObject {
@private
    NSMutableDictionary* _services;
}

+ (id) serviceGroup;

- (id) serviceForServiceType:(id) serviceType;
- (void) setService:(id) service forServiceType:(id) serviceType;
- (void) removeServiceForServiceType:(id) serviceType;

- (BOOL) canServiceRequest:(FLServiceRequest*) request;

- (FLFinisher*) sendServiceRequest:(FLServiceRequest*) request;

- (FLFinisher*) sendServiceRequest:(FLServiceRequest*) request 
                        completion:(FLCompletionBlock) completion;

- (void) openServices:(id) sender;
- (void) closeServices:(id) sender;

// TODO : some sort of FIFO queue for opening???

- (id) resourceForKey:(id) key;

@end

@interface NSError (FLService)
+ (NSError*) serviceRequestNotHandledError:(NSString*) serviceType;
- (BOOL) isUnhandledServiceRequestError;
- (NSString*) unhandledServiceRequestServiceType;
@end

