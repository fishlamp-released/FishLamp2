//
//  FLService.h
//  FLCore
//
//  Created by Mike Fullerton on 11/2/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaRequired.h"
#import "FLObservable.h"

@interface FLService : FLObservable {
@private
    NSMutableArray* _subServices;
    BOOL _serviceOpen;
    __unsafe_unretained id _superService;

//    SEL _didOpenDelegateMethod;
//    SEL _didCloseDelegateMethod;
}

//- (id) initWithDelegate:(id) delegate;
//- (id) initWithRootNameForDelegateMethods:(NSString*) rootName;
+ (id) service;

@property (readonly, assign) id superService;
@property (readonly, assign) id rootService;

@property (readonly, strong) NSArray* subServices; 
- (void) addSubService:(FLService*) service;
- (void) removeSubService:(FLService*) service;
- (void) visitSubServices:(void (^)(id service, BOOL* stop)) visitor;

@property (readonly, assign, getter=isServiceOpen) BOOL serviceOpen;
- (void) openService:(id) opener;
- (void) closeService:(id) opener;


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




