//
//	GtWeakReference.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/8/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

/**
    A GtWeakReference points to an object that is expected to be deleted out from under the 
    weak reference at any time. This object needs to implement the GtWeaklyReferencedObject
    protocol.

    A weak reference does not retain the object it points to. When the object it points to is
    deleted, the weak reference is set to nil.
        
    If a weak references has a valid delegate, the delegate method is invoked when the referenced object 
    is deleted (and the weak reference is set to nil). Note that The delegate is not invoked if the 
    weak reference (not the object pointed to) is changed or set to nil, e.g. the delegate selector 
    is only performed when the object pointed to is deleted.
*/
#import "FishLampMinimum.h"

@interface GtWeakReference : NSObject {
@private
	id _object;
    NSValue* _pointerToSelf;
}

/** 
    This is the property for accessing the weakly references object.
    The object is NOT retained.
*/
@property (readwrite, assign) id object;

@property (readonly, assign) BOOL isNil;

- (id) initWithObject:(id) object;

+ (GtWeakReference*) weakReference:(id) object;
@end


@interface GtWeakRefMember : NSObject {
@private
    id _weaklyReferencedObject;
}
@end

@protocol GtWeaklyReferencedObject 
@end

#define GtDeclareWeakRefMember() GtWeakRefMember* _weaklyReferencedObject
#define GtSynthesizeWeakRefProperty()
#define GtReleaseWeakRef() [_weaklyReferencedObject release]