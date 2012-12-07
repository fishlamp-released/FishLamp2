//
//  FLContext.m
//  FLCore
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
        _registeredServices = [[NSMutableSet alloc] init];
    }
    
    return self;
}


#if FL_MRC
- (void) dealloc {
    [_registeredServices release];
    [super dealloc];
}
#endif

- (BOOL) serviceIsRegistered:(NSString*) name {
    FLAssertStringIsNotEmpty_(name);
    return [_registeredServices containsObject:name];
}

- (id) serviceForName:(NSString*) name {
    FLAssertStringIsNotEmpty_(name);
    return ([_registeredServices containsObject:name]) ? [self valueForKey:name] : nil;
} 

- (void) removeServiceForName:(NSString*) name {
    FLAssertStringIsNotEmpty_(name);

    id service = [self serviceForName:name];
    if(service) {
        [service wasAddedToContext:nil];
        [service removeObserver:self];
        [self removeObserver:service];
        [_registeredServices removeObject:name];
    }
}

- (void) setService:(id<FLService>) service 
                 forName:(NSString*) name{

    FLAssertStringIsNotEmpty_(name);
    FLAssertNotNil_(service);
    
    [self removeServiceForName:name];
    [_registeredServices addObject:name];
    [service addObserver:self];
    [self addObserver:service];
    [service wasAddedToContext:self];
}

- (void) openContext {
    [self postObservation:@selector(sessionWillOpen:)];

    self.sessionOpen = YES;
    for(NSString* serviceName in _registeredServices) {
        [[self serviceForName:serviceName] openService];
    }
    
    [self postObservation:@selector(sessionDidOpen:)];
}

- (void) closeContext {
    [self postObservation:@selector(sessionWillClose:)];

    for(NSString* serviceName in _registeredServices) {
        [[self serviceForName:serviceName] closeService];
    }

    self.sessionOpen = NO;
    [self postObservation:@selector(sessionDidClose:)];
}

@end


