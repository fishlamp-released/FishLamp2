//
//  FLDeallocNotifier.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/15/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLSimpleNotifier.h"
#import "FLDeletedObjectReference.h"

typedef void (^FLDeallocNotifierBlock)(FLDeletedObjectReference* deletedObject);

@interface NSObject (FLDeallocNotifier)
/**
    NOTE that the "sender" for the dealloc notification will be a FLDeletedObjectReference.
    This is for cleanup purposes only. DO NOT send messages to deletedObject. See comment
    for [FLDeleteObjectReference deletedObject];
*/
- (void) addDeallocNotifier:(FLSimpleNotifier*) notifier;

- (void) addDeallocNotifierBlock:(FLDeallocNotifierBlock) block;

- (void) addDeallocListener:(id) target action:(SEL) action;

/**
    You do NOT, I repeat NOT, have to call this. Deleting your 
    notifier will automatically remove the dealloc notification.
    Pretty cool, huh!? ;-)
 */
- (void) removeDeallocNotifier:(FLSimpleNotifier*) notifier;
@end

