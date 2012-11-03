//
//  FLAppService.m
//  FishLampCore
//
//  Created by Mike Fullerton on 11/2/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLAppService.h"
#import "FLWorkFinisher.h"
#import "FLCollectionIterator.h"

@implementation FLAppService

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


- (void) setService:(id<FLAppService>) service forKey:(id) key {
    
    [self removeServiceForKey:key];
    
    [service addObserver:self];
    [self addObserver:service];
    
    /// TODO check for dupes
    
    [_services setObject:service forKey:key];
}

- (void) removeServiceForKey:(id) key {
    
    id<FLAppService> service = [_services objectForKey:key];
    if(service) {   
        [service removeObserver:self];
        [self removeObserver:service];
        [_services removeObjectForKey:key];
    }
}

- (id<FLAppService>) serviceForKey:(id) key {
    return [_services objectForKey:key];
}

- (BOOL) isServiceOpen {
    return NO;
}

//- (void) appServiceWillOpen:(id<FLUserSession>) userSession {
////    [self postObservation:@selector(appServiceWillOpen:) withObject:self];
//}
//
//- (void) appServiceDidOpen:(id<FLUserSession>) userSession {
////    [self postObservation:@selector(appServiceWillOpen:) withObject:self];
//}
//
//- (void) appServiceDidClose:(id<FLUserSession>) userSession {
//
//}

//- (void) openNext:(id<FLCollectionIterator>) services 
//          finisher:(id<FLFinisher>) finisher {
//    
//    id<FLAppService> service = services.nextObject;
//    if(service) {
//       [service startOpeningService:^(id<FLResult> result){
//            [self openNext:services finisher:finisher];
//       }];
//    }
//    else {
//        [finisher setFinished];
//    }
//}
//
//- (void) closeNext:(id<FLCollectionIterator>) services 
//          finisher:(id<FLFinisher>) finisher {
//    
//    id<FLAppService> service = services.nextObject;
//    if(service) {
//       [service startClosingService:^(id<FLResult> result){
//            [self closeNext:services finisher:finisher];
//       }];
//    }
//    else {
//        [finisher setFinished];
//    }
//}

- (id<FLPromisedResult>) startOpeningService:(FLResultBlock) completion {
    FLWorkFinisher* finisher = [FLWorkFinisher finisher:completion];
    [self openSelf:finisher];
    return finisher;
}

- (id<FLPromisedResult>) startClosingService:(FLResultBlock) completion {
    FLWorkFinisher* finisher = [FLWorkFinisher finisher:completion];
    [self closeSelf:finisher];
    return finisher;
}

- (void) openSelf:(id<FLFinisher>) finisher {

    FLAssertFailed_v(@"override this");
}

- (void) closeSelf:(id<FLFinisher>) finisher {
    FLAssertFailed_v(@"override this");
}

- (void) addToAppService:(id<FLAppService>) service {
    [service setService:self forKey:NSStringFromClass([self class])];
}

- (void) removeFromAppService:(id<FLAppService>) service {
    [service removeServiceForKey:NSStringFromClass([self class])];
}





@end