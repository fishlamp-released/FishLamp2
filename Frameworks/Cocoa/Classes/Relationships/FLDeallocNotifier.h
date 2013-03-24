//
//  FLDeallocNotifier.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/15/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"

#import "FLSimpleNotifier.h"
#import "FLDeletedObjectReference.h"

typedef void (^FLDeallocNotifierBlock)(FLDeletedObjectReference* deletedObject);

@interface NSObject (FLDeallocNotifier)
/**
    NOTE that the "sender" for the dealloc notification will be a FLDeletedObjectReference.
    This is for YOUR cleanup purposes only. DO NOT send messages or use to deletedObject in 
    any other way than, essentially, a long integer value (e.g. a pointer you've stored somewhere
    like with a assign property.
    
    See comment for [FLDeleteObjectReference deletedObject] in FLDeletedObjectReference.h.
    
    This is an asyncronous notification - it may not happen immediately when the 
    object is deleted - e.g. it's not the same as calling a method from the object's
    dealloc method.
    
    See also FLWeakReference.h.
*/
- (void) addDeallocNotifier:(FLSimpleNotifier*) notifier;

- (void) addDeallocNotifierWithBlock:(FLDeallocNotifierBlock) block;

- (void) addDeallocListener:(id) target action:(SEL) action;

/**
    You do NOT, I repeat NOT, have to call this. Deleting your 
    notifier will automatically remove the dealloc notification.
 */
- (void) removeDeallocNotifier:(FLSimpleNotifier*) notifier;

- (void) sendDeallocNotification;
@end

