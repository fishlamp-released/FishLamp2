//
//  FLService.h
//  FLCore
//
//  Created by Mike Fullerton on 11/2/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLObservable.h"

@interface FLService : FLObservable {
@private
    NSMutableArray* _subServices;
    BOOL _serviceOpen;
    __unsafe_unretained id _superService;
    __unsafe_unretained id _delegate;
    
    SEL _didOpenDelegateMethod;
    SEL _didCloseDelegateMethod;
}

- (id) initWithRootNameForDelegateMethods:(NSString*) rootName;

@property (readonly, assign) id superService;
@property (readonly, assign) id rootService;

@property (readonly, strong) NSArray* subServices; 
- (void) addSubService:(FLService*) service;
- (void) removeSubService:(FLService*) service;
- (void) visitSubServices:(void (^)(id service, BOOL* stop)) visitor;

@property (readonly, assign, getter=isServiceOpen) BOOL serviceOpen;
- (void) openService:(id) opener;
- (void) closeService:(id) opener;


// for delegates
@property (readwrite, assign, nonatomic) id delegate;

// optional overrides
- (void) didMoveToSuperService:(id) superService;

- (void) willOpenService;
- (void) openService;
- (void) didOpenService;

- (void) willCloseService;
- (void) closeService;
- (void) didCloseService;

@end

@protocol FLServiceDelegate <NSObject>

@end




