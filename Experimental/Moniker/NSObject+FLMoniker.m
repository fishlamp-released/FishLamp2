//
//  NSObject+FLMoniker.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 7/18/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "NSObject+FLMoniker.h"

#import <objc/runtime.h>

static void * const kMonikerKey = (void*)&kMonikerKey;

@implementation NSObject (FLMoniker)

- (id) moniker {
    return objc_getAssociatedObject(self, kMonikerKey);
}

- (void) setMoniker:(id) moniker {
    objc_setAssociatedObject(self, kMonikerKey, moniker, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL) monikerIsEqualTo:(id) aMoniker {
    return [[self moniker] isEqual:aMoniker];
}

- (id) objectByMoniker:(id) aMoniker {
    return [self monikerIsEqualTo:aMoniker] ? self : nil;
}

@end

//@implementation NSArray (FLMoniker)
//
//- (id) objectByMoniker:(id) aMoniker {
//    if([super objectByMoniker:aMoniker]) {
//        return self;
//    }
//    
//    for(id obj in self) {
//        if([obj hasMoniker:aMoniker]) {
//            return obj;
//        }
//    }
//    
//    return self;
//}
//@end

//@implementation NSDictionary (FLMoniker)
//
//- (id) objectByMoniker:(id) aMoniker {
//    if([super objectByMoniker:aMoniker]) {
//        return self;
//    }
//    
//    for(id obj in self) {
//        if([obj hasMoniker:aMoniker]) {
//            return obj;
//        }
//    }
//    
//    return self;
//}
//
//
//@end

//@implementation NSSet (FLMoniker)
//
//- (id) objectByMoniker:(id) aMoniker {
//    if([super objectByMoniker:aMoniker]) {
//        return self;
//    }
//    
//    for(id obj in self) {
//        if([obj hasMoniker:aMoniker]) {
//            return obj;
//        }
//    }
//    
//    return self;
//}
//
//
//@end
