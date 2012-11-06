//
//  FLService.m
//  FishLampCore
//
//  Created by Mike Fullerton on 11/2/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLService.h"
#import "FLWorkFinisher.h"
#import "FLCollectionIterator.h"

@interface FLService()
@property (readwrite, assign) id parentService;
@end

@implementation FLService

synthesize_(parentService)
synthesize_(isServiceOpen)

- (void) wasAddedToService:(id<FLService>) parent {
    self.parentService = parent;
}

+ (id) serviceID {
    return NSStringFromClass([self class]);
}


- (void) openService {
    _isServiceOpen = YES;
}

- (void) closeService {
    _isServiceOpen = NO;
}


@end

@implementation FLParentService

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

- (void) setService:(id<FLService>) service 
       forID:(id) serviceID {

    [self removeServiceForID:serviceID];

    FLAssertNotNil_(service);

    [service addObserver:self];
    [self addObserver:service];

    [_services setObject:service forKey:serviceID];
    [service wasAddedToService:self];
}

- (void) setService:(id<FLService>) service {
    [self setService:service forID:[[service class] serviceID]];
}

- (void) removeServiceForID:(id) key {
    id service = [_services objectForKey:key];
    if(service) {
        [service wasAddedToService:nil];
        [service removeObserver:self];
        [self removeObserver:service];
        [_services removeObjectForKey:key];
    }
}

- (void) removeService:(id<FLService>) service {
    [self removeServiceForID:[[service class] serviceID]];
}

- (id) serviceForID:(NSString*) serviceName {
    return [_services objectForKey:serviceName];
}

- (void) openService {
    for(id<FLService> service in _services.objectEnumerator) {
        [service openService];
    }
    
    [super openService];
}

- (void) closeService {
    for(id<FLService> service in _services.objectEnumerator) {
        [service closeService];
    }

    [super closeService];
}

@end