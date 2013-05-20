//
//  GtLinkedListObjectContainer.h
//  FishLampCore
//
//  Created by Mike Fullerton on 4/24/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FishLampMinimum.h"

#import "GtLinkedListElement.h"
#import "GtLinkedList.h"

@interface GtLinkedListObjectContainer : GtLinkedListElement {
@private
	id _object;
    id _key;
}
@property (readwrite, retain, nonatomic) id key;
@property (readwrite, retain, nonatomic) id object;

- (id) initWithObject:(id) object;
+ (GtLinkedListObjectContainer*) linkedListObjectContainer:(id) object;

@end

/// This is a category added to GtLinkedList for finding GtLinkedListObjectContainer in a list.
/// This assumes all the elements in the list are GtLinkedListObjectContainer objects.
@interface GtLinkedList (GtLinkedListObjectContainer)
    
/// Find an GtLinkedListObjectContainer in the list using a contained object.
/// @param object The contained object in owned by a GtLinkedListObjectContainer in the list to find.
/// @returns The container that owns the searched for object.
- (GtLinkedListObjectContainer*) findContainerWithObject:(id) object;

/// Find an GtLinkedListObjectContainer in the list using a container key.
/// @param key The key for GtLinkedListObjectContainer in the list to find.
/// @returns The container that has a matching key.
- (GtLinkedListObjectContainer*) findContainerWithKey:(id) key;
@end