//
//  FLService.h
//  FLCore
//
//  Created by Mike Fullerton on 11/2/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLFinisher.h"
#import "FLResult.h"
#import "FLServiceProvider.h"
#import "FLServiceManager.h"
#import "FLObjectDataStore.h"

@class FLServiceManager;

@interface FLService : NSObject {
@private
    NSMutableArray* _services;
    BOOL _serviceOpen;
}
@property (readonly, assign, nonatomic, getter=isServiceOpen) BOOL serviceOpen;

- (void) addService:(FLService*) service;
- (void) removeService:(FLService*) service;

- (void) openService:(id) opener;
- (void) closeService:(id) closer;
@end

@interface FLDataStoreService : FLService {
@private
    id<FLObjectDataStore> _dataStore;
}
@property (readwrite, strong) id<FLObjectDataStore> dataStore;
@end

@interface FLDataStoreOpener <NSObject>
- (void) openDataStoreService:(FLDataStoreService*) cache;
- (void) closeDataStoreService:(FLDataStoreService*) cache;
@end