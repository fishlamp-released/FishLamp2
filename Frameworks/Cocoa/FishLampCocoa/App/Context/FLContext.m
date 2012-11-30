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


#if FL_MRC
- (void) dealloc {
    
    [_services release];
    [super dealloc];
}
#endif


- (void) registerService:(id<FLService>) service 
                   forID:(id) serviceUTI {

    [self removeServiceForID:serviceUTI];

    FLAssertNotNil_(service);

    [service addObserver:self];
    [self addObserver:service];

    [_services setObject:service forKey:serviceUTI];
    [service wasAddedToContext:self];
}

- (void) registerService:(id<FLService>) service {
    [self registerService:service forID:[[service class] serviceUTI]];
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
    [self removeServiceForID:[[service class] serviceUTI]];
}

//- (BOOL) serviceIsRegistered:(id) serviceUTI {
//    return [_services objectForKey:serviceUTI] != nil;
//}

- (id) serviceForID:(NSString*) serviceUTI {
    return [_services objectForKey:serviceUTI];
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


