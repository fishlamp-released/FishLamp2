//
//	FLWeakReference.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/8/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//
#import "FLWeakReference.h"
#import "FLDeallocNotifier.h"

@interface FLWeakReference ()
@property (readwrite, weak) id object_ref;
@property (readwrite, assign) NSUInteger hash;
@end

@implementation FLWeakReference
@synthesize hash = _hash;
@synthesize object_ref = _object;

- (id) object {
    return self.object_ref;
}

- (void) setObject:(id) object {

    id prev = self.object_ref;
    if(prev) {
        [prev removeDeallocNotifier:self];
    }
    
    self.hash = [object hash];
    self.object_ref = object;
    
    if(object) {
        [object addDeallocNotifier:self];
    }
}

- (id) initWithObject:(id) object {
    self = [super init];
	if(self) {
        self.object = object;
    }
	
	return self;
}

- (void) setObjectToNil {   
    self.object = nil;
}

- (void) receiveNotification:(id) sender {
    self.object_ref = nil;
}

+ (id) weakReference:(id) object {
	return FLReturnAutoreleased([[[self class] alloc] initWithObject:object]);
}

+ (id) weakReference {
	return FLReturnAutoreleased([[[self class] alloc] init]);
}

- (NSString*) description {
    id obj = self.object_ref;
	return [NSString stringWithFormat:@"FLWeakReference: %@", [obj description]];
}

- (BOOL) isNil {
	return self.object_ref == nil;
}

- (BOOL) isEqual:(id) object {
    id obj = self.object_ref;
    return self == object || obj == object || [obj isEqual:object];
}

@end

#if TEST
#import "FLCallback.h"
#import "FLFifoQueue.h"

@interface FLWeakRefTestObject : FLCallback {
@private
}

@end

@implementation FLWeakRefTestObject
- (void) dealloc {
    [self invoke:nil];
#if FL_NO_ARC
    [super dealloc];
#endif
}
@end

@interface FLCriticalWeakRefTest : FLSanityCheck {
}

@end


@implementation FLCriticalWeakRefTest

#if FL_NO_ARC
- (void) testWeakRef {
    FLAssertFailed_v(@"weak ref not supported without ARC for now");
}

#else
- (void) a_testWeakRefDelete {

    

    __block BOOL wasDeleted = NO;

    FLWeakRefTestObject* obj = [[FLWeakRefTestObject alloc] initWithBlock:^(id sender){
        wasDeleted = YES;
    }];
    
    __weak id test = obj;
    
    FLManuallyRelease(&obj);

    FLAssertIsTrue_(wasDeleted);
    FLAssertIsNil_(obj);
    FLAssertIsNil_(test);
//    FLAssertIsNil_(weakRef.object);
}

- (void) b_testWeakRefDeleteNotification {


    FLFinisher* notifier = [FLFinisher finisher];
  
    // Note need to run the test on a thread because the associated objects
    // are autoreleased in the thread and running the test in the main
    // loop causes a deadlock.
  
    [FLAsyncQueue addBlock:^{
        __block BOOL wasDeleted = NO;
    
        FLWeakRefTestObject* obj = [[FLWeakRefTestObject alloc] initWithBlock:^(id sender){
            wasDeleted = YES;
        }];
        __weak id test = obj;
        
        FLWeakReference* ref = [FLWeakReference weakReference:obj];
        [ref addNotifierWithBlock:^(id sender) {
            [notifier setFinished];
        }];

// assert here takes a ref on obj, causing it not to delete.
//        FLAssert_(ref.object == test);
//        FLAssert_(ref.object == obj);

        FLManuallyRelease(&obj);

        FLAssertIsNil_(ref.object);

        FLAssertIsTrue_(wasDeleted);
        FLAssertIsNil_(obj);
        FLAssertIsNil_(test);
    }];
    
    [notifier waitUntilFinished];
    
//    FLAssertIsNil_(weakRef.object);
}

#endif

@end

#endif



