//
//  FLSession.m
//  FishLampCore
//
//  Created by Mike Fullerton on 11/6/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLSession.h"

@interface FLSession ()
@property (readwrite, assign, getter=isSessionOpen) BOOL sessionOpen;
@end

@implementation FLSession

synthesize_(sessionOpen);

- (id) init {
    self = [super init];
    if(self) {
        _services = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

dealloc_(    
    [_services release];
)

- (void) registerService:(id<FLService>) service 
       forID:(id) serviceID {

    [self removeServiceForID:serviceID];

    FLAssertNotNil_(service);

    [service addObserver:self];
    [self addObserver:service];

    [_services setObject:service forKey:serviceID];
    [service wasAddedToSession:self];
}

- (void) registerService:(id<FLService>) service {
    [self registerService:service forID:[[service class] serviceID]];
}

- (void) removeServiceForID:(id) key {
    id service = [_services objectForKey:key];
    if(service) {
        [service wasAddedToSession:nil];
        [service removeObserver:self];
        [self removeObserver:service];
        [_services removeObjectForKey:key];
    }
}

- (void) removeService:(id<FLService>) service {
    [self removeServiceForID:[[service class] serviceID]];
}

- (BOOL) serviceIsRegistered:(id) serviceID {
    return [_services objectForKey:serviceID] != nil;
}

- (id) serviceForID:(NSString*) serviceID {
    FLAssert_v([self serviceIsRegistered:serviceID], @"service not registered in session");

    return [_services objectForKey:serviceID];
}

- (void) openSession {
    [self postObservation:@selector(sessionWillOpen:)];

    self.sessionOpen = YES;
    for(id<FLService> service in _services.objectEnumerator) {
        [service openService];
    }
    
    [self postObservation:@selector(sessionDidOpen:)];
}

- (void) closeSession {
    [self postObservation:@selector(sessionWillClose:)];

    for(id<FLService> service in _services.objectEnumerator) {
        [service closeService];
    }
    self.sessionOpen = NO;
    [self postObservation:@selector(sessionDidClose:)];
}

@end