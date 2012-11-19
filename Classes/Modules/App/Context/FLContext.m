//
//  FLContext.m
//  FishLampCore
//
//  Created by Mike Fullerton on 11/6/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLContext.h"
#import "FLService.h"

@interface FLContext ()
@property (readwrite, assign, getter=isContextOpen) BOOL sessionOpen;
@end

@implementation FLContext

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
    [service wasAddedToContext:self];
}

- (void) registerService:(id<FLService>) service {
    [self registerService:service forID:[[service class] serviceID]];
}

- (void) removeServiceForID:(id) key {
    id service = [_services objectForKey:key];
    if(service) {
        [service wasAddedToContext:nil];
        [service removeObserver:self];
        [self removeObserver:service];
        [_services removeObjectForKey:key];
    }
}

- (void) removeService:(id<FLService>) service {
    [self removeServiceForID:[[service class] serviceID]];
}

//- (BOOL) serviceIsRegistered:(id) serviceID {
//    return [_services objectForKey:serviceID] != nil;
//}

- (id) serviceForID:(NSString*) serviceID {
    return [_services objectForKey:serviceID];
}

- (void) openContext {
    [self postObservation:@selector(sessionWillOpen:)];

    self.sessionOpen = YES;
    for(id<FLService> service in _services.objectEnumerator) {
        [service openService];
    }
    
    [self postObservation:@selector(sessionDidOpen:)];
}

- (void) closeContext {
    [self postObservation:@selector(sessionWillClose:)];

    for(id<FLService> service in _services.objectEnumerator) {
        [service closeService];
    }
    self.sessionOpen = NO;
    [self postObservation:@selector(sessionDidClose:)];
}

@end


