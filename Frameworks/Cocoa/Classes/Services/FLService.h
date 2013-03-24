//
//  FLService.h
//  FLCore
//
//  Created by Mike Fullerton on 11/2/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"

@interface FLService : NSObject {
@private
    NSMutableArray* _subServices;
    BOOL _serviceOpen;
    __unsafe_unretained id _superService;
}

@property (readonly, assign, getter=isServiceOpen) BOOL serviceOpen;

@property (readonly, assign) id superService;
@property (readonly, assign) id rootService;

@property (readonly, strong) NSArray* subServices; 
- (void) addSubService:(FLService*) service;
- (void) removeSubService:(FLService*) service;
- (void) visitSubServices:(void (^)(id service, BOOL* stop)) visitor;

// optional overrides
- (void) openService:(id) opener;
- (void) closeService:(id) closer;
- (void) didMoveToSuperService:(id) superService;

@end

#define FLSynthesizeServiceProperty(__GETTER__, __SETTER__, __SERVICE_TYPE__, __IVAR_NAME__) \
    - (__SERVICE_TYPE__) __GETTER__ { return FLAtomicPropertyGet(&__IVAR_NAME__); } \
    - (void) __SETTER__:(__SERVICE_TYPE__) newValue { FLAtomicAddServiceToService(&__IVAR_NAME__, newValue, self); } 

extern void FLAtomicAddServiceToService(__strong id* ivar, FLService* newService, FLService* parentService);