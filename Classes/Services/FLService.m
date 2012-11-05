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

- (void) addService:(id<FLService>) appService {
    [appService addObserver:self];
    [self addObserver:appService];

    [_services setObject:appService forKey:[[appService class] serviceID]];
}

- (void) removeService:(id<FLService>) appService {

    [appService removeObserver:self];
    [self removeObserver:appService];

    [_services removeObjectForKey:[[appService class] serviceID]];
}

- (id<FLService>) serviceByID:(NSString*) serviceName {
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