//
//	GtWeakReference.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/8/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#import "GtWeakReference.h"
#import <objc/runtime.h>

@interface GtWeakReference ()
- (void) setDidReleaseObject;
@end

@interface GtWeakObjectReference : NSObject {
@private
    NSMutableSet* _weakReferences;
}
+ (GtWeakObjectReference*) weakObjectReference;
@property (readwrite, retain, nonatomic) NSMutableSet* set;
@end

static void * const kAssociatedObjectKey = (void*)&kAssociatedObjectKey;

@implementation NSObject (GtWeakReference)

- (void) _addWeakReference:(NSValue*) weakRef {
    @synchronized(self) {
        GtWeakObjectReference* ref = objc_getAssociatedObject(self, &kAssociatedObjectKey);
        if(!ref) {
            ref = [[GtWeakObjectReference alloc] init];
            objc_setAssociatedObject(self, &kAssociatedObjectKey, ref, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            GtRelease(ref);
        }
        [ref.set addObject:weakRef];
    }
}

- (void) _removeWeakReference:(NSValue*) weakRef {
    @synchronized(self) {
        GtWeakObjectReference* ref = objc_getAssociatedObject(self, &kAssociatedObjectKey);
        if(ref) {
            [ref.set removeObject:weakRef];
        }
    }
}

@end

@implementation GtWeakReference

- (id) init {
    return [self initWithObject:nil];
}

- (id) initWithObject:(id) object {
	if((self = [super init])) {
		_pointerToSelf	= [NSValue valueWithNonretainedObject:self];
        GtRetain(_pointerToSelf);
        
        self.object = object;
    }
	
	return self;
}

- (void) setDidReleaseObject {   
    @synchronized(self) {
        _object = nil;
    }
}

+ (GtWeakReference*) weakReference:(id) object {
	return GtReturnAutoreleased([[GtWeakReference alloc] initWithObject:object]);
}

- (void) _releaseWeakRef {
    if(_object) {
        [_object _removeWeakReference:_pointerToSelf];
    }

    _object = nil;
}

- (void) dealloc  {
	[self _releaseWeakRef];
    GtRelease(_pointerToSelf);
    GtSuperDealloc();
}

- (NSString*) description {
	return [NSString stringWithFormat:@"GtWeakReference: %@", [self.object description]];
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

@implementation GtWeakObjectReference

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

+ (GtWeakObjectReference*) weakObjectReference {
    return GtReturnAutoreleased([[GtWeakObjectReference alloc] init]);
}

- (void) dealloc {
    for(NSValue* value in _weakReferences) {
        [[value nonretainedObjectValue] setDidReleaseObject];
    }
    GtRelease(_weakReferences);
    GtSuperDealloc();
}

@end
