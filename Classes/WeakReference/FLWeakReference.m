//
//	FLWeakReference.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/8/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//
#import "FLWeakReference.h"
#import <objc/runtime.h>

@interface FLWeakReference ()
- (void) setDidReleaseObject;
@end

@interface FLWeakObjectReference : NSObject {
@private
    NSMutableSet* _weakReferences;
}
+ (FLWeakObjectReference*) weakObjectReference;
@property (readwrite, retain, nonatomic) NSMutableSet* set;
@end

static void * const kAssociatedObjectKey = (void*)&kAssociatedObjectKey;

@implementation NSObject (FLWeakReference)

- (void) _addWeakReference:(NSValue*) weakRef {
    @synchronized(self) {
        FLWeakObjectReference* ref = objc_getAssociatedObject(self, &kAssociatedObjectKey);
        if(!ref) {
            ref = [[FLWeakObjectReference alloc] init];
            objc_setAssociatedObject(self, &kAssociatedObjectKey, ref, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            FLRelease(ref);
        }
        [ref.set addObject:weakRef];
    }
}

- (void) _removeWeakReference:(NSValue*) weakRef {
    @synchronized(self) {
        FLWeakObjectReference* ref = objc_getAssociatedObject(self, &kAssociatedObjectKey);
        if(ref) {
            [ref.set removeObject:weakRef];
        }
    }
}

@end

@implementation FLWeakReference

- (id) init {
    return [self initWithObject:nil];
}

- (id) initWithObject:(id) object {
	if((self = [super init])) {
		_pointerToSelf	= [NSValue valueWithNonretainedObject:self];
        FLRetain(_pointerToSelf);
        
        self.object = object;
    }
	
	return self;
}

- (void) setDidReleaseObject {   
    @synchronized(self) {
        _object = nil;
    }
}

+ (FLWeakReference*) weakReference:(id) object {
	return FLReturnAutoreleased([[FLWeakReference alloc] initWithObject:object]);
}

- (void) _releaseWeakRef {
    if(_object) {
        [_object _removeWeakReference:_pointerToSelf];
    }

    _object = nil;
}

- (void) dealloc  {
	[self _releaseWeakRef];
    FLRelease(_pointerToSelf);
    FLSuperDealloc();
}

- (NSString*) description {
	return [NSString stringWithFormat:@"FLWeakReference: %@", [self.object description]];
}

- (id) object {
    return _object;
}

- (void) setObject:(id) object {
    @synchronized(self) {
        if(_object != object) {
            if(_object) {
                [self _releaseWeakRef];
            }
            
            _object = object;
        
            if(_object) {
                [_object _addWeakReference:_pointerToSelf];
            }
        }
    }
}

- (BOOL) isNil {
	return self.object == nil;
}

@end

@implementation FLWeakObjectReference

@synthesize set = _weakReferences;

- (id) initWithObject:(id) obj {
    if((self = [super init])) {
        _weakReferences = [[NSMutableSet alloc] init];
    }
    
    return self;
}

- (id) init {
    if((self = [super init])) {
        _weakReferences = [[NSMutableSet alloc] init];
    }
    
    return self;
}

+ (FLWeakObjectReference*) weakObjectReference {
    return FLReturnAutoreleased([[FLWeakObjectReference alloc] init]);
}

- (void) dealloc {
    for(NSValue* value in _weakReferences) {
        [[value nonretainedObjectValue] setDidReleaseObject];
    }
    FLRelease(_weakReferences);
    FLSuperDealloc();
}

@end
