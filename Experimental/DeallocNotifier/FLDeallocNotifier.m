//
//  FLDeallocNotifier.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 7/19/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLDeallocNotifier.h"
#import <objc/runtime.h>

static void * const kNotifierKey = (void*)&kNotifierKey;

@implementation NSObject (FLDeallocNotifier) 

- (void) addDeallocNotifier:(FLDeallocNotifier*) notifier {
    objc_setAssociatedObject(self, kNotifierKey, notifier, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation FLDeallocNotifier 

- (id) initWithTarget:(id) target action:(SEL) action {
    if((self = [super init])) {
        _callback = FLCallbackMake(target, action);
    }
    
    return self;
}

+ (FLDeallocNotifier*) deallocNotifier:(id) target action:(SEL) action {
    return FLReturnAutoreleased([[FLDeallocNotifier alloc] initWithTarget:target action:action]);
}

- (void) dealloc {
    FLCallbackPerformWithObject(_callback, nil);
    FLSuperDealloc();
}

@end
