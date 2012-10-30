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
FLSynthesizeAssociatedProperty(retain_nonatomic, _deallocNotifier, _setDeallocNotifier, FLDeallocNotifier*);

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

#if FL_NO_ARC
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
    return FLReturnAutoreleased([[FLDeallocNotifier alloc] initWithObject:object]);
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
        notifiers = _notifiers;
        _notifiers = nil;
        FLAutorelease(notifiers);

        ref = _deletedObjectReference;
        _deletedObjectReference = nil;
        FLAutorelease(ref);
    }
    
    if(notifiers) {
//        [notifiers performBlockOnMainThread: ^{
            for(FLSimpleNotifier* notifier in notifiers) {
        //        [[notifier deallocNotifier] _removeNotifier:_notifierDied];
                [notifier sendNotification:ref];
            }
//        }];
    }
}

- (void) dealloc {
    
    [self sendDeallocNotification];

#if FL_NO_ARC
    [_notifiers release];
    [_deletedObjectReference release];
//    [_notifierDied release];
    [super dealloc];
#endif
}
@end

#if TEST

#import "FLCallback.h"

@interface FLDeleteNotifier : FLCallback {
}
@end

@implementation FLDeleteNotifier
- (void) dealloc {
    [self invoke:nil];
#if FL_NO_ARC
    [super dealloc];
#endif
}
@end

#import "FLDispatchQueues.h"

@interface FLDeallocNotifierSanityCheck : FLSanityCheck
@end

@implementation FLDeallocNotifierSanityCheck


//- (void) testAssociatedObjectsDelete {
//    s_deleted = NO;
//    NSMutableString* str = [[NSMutableString alloc] initWithString:@"hello world"];
//    [str setTestThingy:[FLDeleteObjectThingy new]];
//    str = nil;
//    FLAssert_(s_deleted == YES);
//}

//- (void) didDelete:(id) sender {
//    [self.finisher setFinished];
//    self.finisher = nil;
//}

- (void) testLazyCreate {
    NSMutableString* str = [NSMutableString string];
    FLAssertIsNil_([str _deallocNotifier]);
    id notifier = [str deallocNotifier];
    FLAssertIsNotNil_(notifier);
    FLAssert_(notifier == [str _deallocNotifier]);
    FLAssert_(notifier == [str deallocNotifier]);
}

- (void) testDeletNotification {

    __block BOOL objectDeleted = NO;
    __block BOOL notified = NO;

#if FL_ARC
    __block __weak id test = nil;
#endif    
    
    FLPromisedResult result = [[FLDispatchQueue instance] dispatchAsyncBlock:^(FLFinisher finisher){
        FLDeleteNotifier* notifier = [[FLDeleteNotifier alloc] initWithBlock:^(id sender){
            objectDeleted = YES;
        }];
        
        [notifier addDeallocNotifierWithBlock:^(FLDeletedObjectReference* ref){
            notified = YES;
            [finisher setFinished];
        }];

        FLManuallyRelease(&notifier);
        FLAssertIsNil_(notifier);
          
#if FL_ARC
        FLAssertIsNil_(test);
#endif        
    }];
    
    
#if FL_ARC
    FLAssertIsNil_(test);
#endif    
    
    [result waitForResult];
    
    FLAssertIsTrue_(objectDeleted);
    FLAssertIsTrue_(notified);
}

//- (void) testNotify:(FLWorkFinisher*) finisher {
//
//    NSMutableString* str = [[NSMutableString alloc] initWithString:@"hello world"];
//    
//    [str addDeallocListener:self action:@selector(didDelete:)];
//    FLReleaseWithNil(str);
//
//    self.finisher = finisher;
//}





@end

#endif


