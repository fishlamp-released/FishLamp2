//
//  FLDeallocNotifier.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/15/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLDeallocNotifier.h"

@interface FLDeallocNotifier : NSObject {
@private
    FLDeletedObjectReference* _deletedObjectReference;
    NSMutableSet* _notifiers;
//    FLCallbackNotifier* _notifierDied;
}

- (id) initWithObject:(id) object;
+ (id) deallocNotifier:(id) object;

- (void) addNotifier:(FLSimpleNotifier*) notifier;
- (void) removeNotifier:(FLSimpleNotifier*) notifier;

- (void) sendDeallocNotification;
@end


@implementation NSObject (FLDeallocNotifier)
FLSynthesizeAssociatedProperty(FLRetainnonatomic, _deallocNotifier, _setDeallocNotifier, FLDeallocNotifier*);

- (FLDeallocNotifier*) deallocNotifier {
    @synchronized(self) {
        FLDeallocNotifier* notifier = [self _deallocNotifier];
        if(!notifier) {
            notifier = [FLDeallocNotifier deallocNotifier:self];
            [self _setDeallocNotifier:notifier];
        }
        return notifier;
    }
}

- (void) removeDeallocNotifier:(FLSimpleNotifier*) notifier {
    FLAssertIsNotNil_(notifier);
    @synchronized(self) {
        [[self deallocNotifier] removeNotifier:notifier];
    }
}

- (void) addDeallocNotifier:(FLSimpleNotifier*) notifier {
    FLAssertIsNotNil_(notifier);
    [[self deallocNotifier] addNotifier:notifier];
}

- (void) addDeallocNotifierWithBlock:(FLDeallocNotifierBlock) block {
    [self addDeallocNotifier:[FLBlockNotifier blockNotifier:block]];
}

- (void) addDeallocListener:(id) target action:(SEL) action {
    [self addDeallocNotifier:[FLCallbackNotifier callbackNotifier:target action:action]];
}

- (void) sendDeallocNotification {
    @synchronized(self) {
        FLDeallocNotifier* notifier = [self _deallocNotifier];
        if(notifier) {
            [notifier sendDeallocNotification];
        }
    }
}


@end

/// Special simpleNotifier where notify is called from dealloc.
/// don't send this into [NSObject addDeallocNotifier] - doing so will cause double notifications.
@implementation FLDeallocNotifier

#if DEBUG
static void (*originalDealloc)(id,SEL);

-(void) replacement__dealloc {
    objc_removeAssociatedObjects(self);
    originalDealloc(self,_cmd);
}

+(void)load {
    if (getenv("NSZombieEnabled")) {
        NSLog(@"### WARNING ### Work-around for associate releasing used--zombies are around!");

#if FL_MRC
        Method m=class_getInstanceMethod(NSObject.class,@selector(dealloc));
        originalDealloc=(__typeof__(originalDealloc))method_getImplementation(m);
        method_setImplementation(m,[self instanceMethodForSelector:@selector(replacement__dealloc)]);
#endif
   }
}
#endif

- (void) _removeNotifier:(FLSimpleNotifier*) notifier {
    @synchronized(self) {
        [_notifiers removeObject:notifier];
    }
}

- (void) _addNotifier:(FLSimpleNotifier*) notifier {
    @synchronized(self) {
        [_notifiers addObject:notifier];
    }
}

//- (void) _notifierDied:(FLDeletedObjectReference*) deletedNotifier {
//    [self _removeNotifier:deletedNotifier.deletedObject];
//}

- (id) initWithObject:(id) object {
    self = [super init];
    if(self) {
        _deletedObjectReference = [[FLDeletedObjectReference alloc] initWithObject:object];
        _notifiers = [[NSMutableSet alloc] init];
//        _notifierDied = [[FLCallbackNotifier alloc] initWithTarget:self action:@selector(_notifierDied:)];
    }
    return self;
}

+ (id) deallocNotifier:(id) object {
    return FLAutorelease([[FLDeallocNotifier alloc] initWithObject:object]);
}

- (void) addNotifier:(FLSimpleNotifier*) notifier {
    FLAssertIsNotNil_(notifier);
    @synchronized(self) {
//        [[notifier deallocNotifier] _addNotifier:_notifierDied];
        [_notifiers addObject:notifier];
    }
}

- (void) removeNotifier:(FLSimpleNotifier*) notifier {
    @synchronized(self) {
        [_notifiers removeObject:notifier];
//        [[notifier deallocNotifier] _removeNotifier:_notifierDied];
    }
}

- (void) sendDeallocNotification {
    NSSet* notifiers = nil;
    FLDeletedObjectReference* ref = nil;
    @synchronized(self) {
        notifiers = FLAutorelease(_notifiers);
        _notifiers = nil;

        ref = FLAutorelease(_deletedObjectReference);
        _deletedObjectReference = nil;
    }
    
    @try {
        if(notifiers) {
    //        [notifiers performBlockOnMainThread: ^{
                for(FLSimpleNotifier* notifier in notifiers) {
            //        [[notifier deallocNotifier] _removeNotifier:_notifierDied];
                    [notifier sendNotification:ref];
                }
    //        }];
        }
    }
    @catch(NSException* ex) {
        NSLog(@"exception thrown in sendDeallocNotification: %@", ex);
    }
}

- (void) dealloc {
    
    [self sendDeallocNotification];

#if FL_MRC
    [_notifiers release];
    [_deletedObjectReference release];
//    [_notifierDied release];
    [super dealloc];
#endif
}
@end
