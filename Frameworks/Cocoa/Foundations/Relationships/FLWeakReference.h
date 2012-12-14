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

#import "FLCore.h"
#import "FLSimpleNotifier.h"
#import "FLDeallocNotifier.h"
#import "FLWeaklyReferenced.h"

// IMPORTANT NOTE for NON-ARC builds:
//
// For objects that are weakly referenced in NON-ARC builds you MUST have
// your object implement the FLWeaklyReferenced protocol - though there is nothing to implement
// this essentially tells the compiler to point out to YOU which of your objects 
// need to call FLSendDeallocNotification() in their dealloc methods. You MUST do this.
// Or the framework WILL crash.

// example:
// - (void) dealloc {
//      FLSendDeallocNotification();
//      [super dealloc];
// }
//

// <LongWindedReason>
//
// There are two behaviors of a FLWeakReference to be aware of:
// 1. when is the reference is set to nil (and how)?
// 2. when do you receive notifications from the FLWeakReference of the deletion?
//
// FLSendDeallocNotification() is not needed in ARC build because the compiler sets the actual reference to nil for us - 
// e.g. the object reference (held by the FLWeakReference) is automatically set to nil when the object is deleted (a great
// new Objective-C language feature) - so there's no way to call methods on a deleted object when using
// the FLWeakReference object. 
// 
// But for NON ARC builds we need to call it manually so that the weak references to the object getting deleted 
// are either nil or valid.
//
// So the only thing that is changing here (when you call it manually) is that the timing of the FLWeakReference object sending out its notifications of 
// the deletion (because it's a FLSimpleNotifier) is slightly different. In ARC builds the associated objects are essentially asynchronously 
// autoreleased a bit later - so the notification comes a bit later. You should not expect synchronous notifications
// from the FLWeakReference object. So it doesn't hurt to have this called in ARC builds, and it's needed for NON-ARC builds.
//
// Thus, this is fine for ARC build because
// 
// But this is NOT fine on NON-ARC build because the object is NOT set to nil by the runtime when dealloc is called, 
// there's that lag between the object's dealloc and the notification for the FLSimpleNotifier, which I noted above.
//
// This means there's a very real span of time that has the FLWeakReference pointing at a deleted object (that you
// can invoke methods on, which is a mortal sin of course). 
//
// The bottom line is that we can't rely on the notification to set the object reference to nil. Hence the crashing.
//
// This is why this hack is required on NON-ARC builds - unfortunately.
//
// </LongWindedReason>


#if FL_MRC
typedef id<FLWeaklyReferenced> FLWeaklyReferencedObject;
#else
typedef id FLWeaklyReferencedObject;
#endif

@interface FLWeakReference : FLSimpleNotifier {
@private
	__weak FLWeaklyReferencedObject _object;
    NSUInteger _hash;
}

/** 
    This is the property for accessing the weakly references object.
    The object is NOT retained.
*/
@property (readwrite, assign) FLWeaklyReferencedObject object;

@property (readonly, assign) BOOL isNil;

- (void) setObjectToNil;

- (id) initWithObject:(FLWeaklyReferencedObject) object;

+ (id) weakReference:(FLWeaklyReferencedObject) object;

+ (id) weakReference;
@end
