//
//  FLService.m
//  FLCore
//
//  Created by Mike Fullerton on 11/2/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLService.h"

NSString* const FLServiceDidCloseNotificationKey = @"FLServiceDidCloseNotificationKey";
NSString* const FLServiceDidOpenNotificationKey = @"FLServiceDidOpenNotificationKey";;


@interface FLService ()
@property (readwrite, assign, getter=isServiceOpen) BOOL serviceOpen;
@property (readwrite, assign) id superService;
@end

@implementation FLService
@synthesize serviceOpen = _serviceOpen;
@synthesize superService = _superService;
@synthesize subServices = _subServices;
//@synthesize delegate = _delegate;

//- (id) init {
//    return [self initWithDelegate:nil];
//}

//- (id) initWithDelegate:(id) delegate {
//	self = [super init];
//	if(self) {
//        self.delegate = delegate;
//	}
//	return self;
//}
//
//- (id) initWithRootNameForDelegateMethods:(NSString*) rootName {
//    self = [self initWithDelegate:nil];
//    if(self) {
//        if(rootName) {
//            _didOpenDelegateMethod = NSSelectorFromString([NSString stringWithFormat:@"%@DidOpen:", rootName]);
//            _didCloseDelegateMethod = NSSelectorFromString([NSString stringWithFormat:@"%@DidClose:", rootName]);
//        }
//    }
//    return self;
//}

+ (id) service {
    return FLAutorelease([[[self class] alloc] init]);
}

#if FL_MRC
- (void) dealloc {
    [_subServices release];
    [super dealloc];
}
#endif


- (void) setOpen { 
    [self openSelf];
    self.serviceOpen = YES;
}
- (void) openSelf {
}

- (void) setClosed {
    [self closeSelf];
    self.serviceOpen = NO;
}
- (void) closeSelf {
}

- (void) willOpenService {
}

- (void) didOpenService {
}

- (void) willCloseService {
}

- (void) didCloseService {
}

- (void) willOpenServiceAndSubservices {
    [self willOpenService];
    for(FLService* service in _subServices) {
        [service willOpenServiceAndSubservices];
    }
}

- (void) openServiceAndSubservices {
    [self setOpen];
    for(FLService* service in _subServices) {
        [service openServiceAndSubservices];
    }
}

- (void) didOpenServiceAndSubservices {
    [self didOpenService];
    for(FLService* service in _subServices) {
        [service didOpenServiceAndSubservices];
    }
    FLTrace(@"opened %@", NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] postNotificationName:FLServiceDidOpenNotificationKey object:self];
}


- (void) willCloseServiceAndSubservices {
    [self willCloseService];
    for(FLService* service in _subServices) {
        [service willCloseServiceAndSubservices];
    }
}

- (void) closeServiceAndSubservices {
    [self setClosed];
    for(FLService* service in _subServices) {
        [service closeServiceAndSubservices];
    }
}

- (void) didCloseServiceAndSubservices {
    [self didCloseService];
    for(FLService* service in _subServices) {
        [service didCloseServiceAndSubservices];
    }
    FLTrace(@"opened %@", NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] postNotificationName:FLServiceDidOpenNotificationKey object:self];
}

- (void) openService {
    if(!self.isServiceOpen) {
        [self willOpenServiceAndSubservices];
        [self openServiceAndSubservices];
        [self didOpenServiceAndSubservices];
    }
}


- (void) closeService {
    if(self.isServiceOpen) {
        [self willCloseServiceAndSubservices];
        [self closeServiceAndSubservices];
        [self didCloseServiceAndSubservices];
    }
}

- (void) addSubService:(id) service {
    if(!_subServices) {
        _subServices = [[NSMutableArray alloc] init];
    }
    [_subServices addObject:service];
    
    [service setSuperService:self];
    [service didMoveToSuperService:self];
}

- (void) removeSubService:(id) service {
    [_subServices removeObject:service];

    [service setSuperService:nil];
    [service didMoveToSuperService:nil];
}

- (void) didMoveToSuperService:(id) superService {

}

- (id) rootService {
    id superService = self.superService;
    return superService == nil ? self : [superService rootService];
}

- (void) visitSubServicesWithStop:(void (^)(id service, BOOL* stop)) visitor stop:(BOOL*) stop {
    for(id service in _subServices) {
        if(*stop) {
            break;
        }

        visitor(service, stop);

        [service visitSubServicesWithStop:visitor stop:stop];
        if(*stop) {
            break;
        }
    }
}

- (void) visitSubServices:(void (^)(id service, BOOL* stop)) visitor {
    BOOL stop = NO;
    [self visitSubServicesWithStop:visitor stop:&stop];
}

- (void) willStartProcessingObject:(id) object {
}

- (void) willStopProcessingObject:(id) object {
}

- (void) startProcessingObject:(id) object {
    [self willStartProcessingObject:object];
    for(id<FLService> service in _subServices) {
        [service startProcessingObject:object];
    }
}

- (void) stopProcessingObject:(id) object {
    [self willStopProcessingObject:object];
    for(id<FLService> service in _subServices) {
        [service stopProcessingObject:object];
    }
}

@end

void FLAtomicAddServiceToService(__strong id* ivar, FLService* newService, FLService* parentService) {
    FLAtomicPropertySet(ivar, newService, ^{ 
        if(*ivar) {
            [parentService removeSubService:*ivar];
        }
        if(newService) {
            [parentService addSubService:newService];
        }
    });
}


