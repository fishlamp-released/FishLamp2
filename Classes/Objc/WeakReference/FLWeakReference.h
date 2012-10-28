//
//	FLWeakReference.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/8/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

/**
    A FLWeakReference points to an object that is expected to be deleted out from under the 
    weak reference at any time. 

    A weak reference does not retain the object it points to. When the object it points to is
    deleted, the weak reference is set to nil.
        
    Note that because this is a simpleNotifier, uou can add child notifications if you need to do something proactive
    when the reference object is released.
*/

#import "FishLampCore.h"
#import "FLSimpleNotifier.h"

@interface FLWeakReference : FLSimpleNotifier {
@private
	__weak id _object;
    NSUInteger _hash;
}

/** 
    This is the property for accessing the weakly references object.
    The object is NOT retained.
*/
@property (readwrite, assign) id object;

@property (readonly, assign) BOOL isNil;

- (void) setObjectToNil;

- (id) initWithObject:(id) object;

+ (id) weakReference:(id) object;

+ (id) weakReference;
@end


