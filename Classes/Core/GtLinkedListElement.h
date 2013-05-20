//
//  GtLinkedListElement.h
//  FishLampCore
//
//  Created by Mike Fullerton on 4/24/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FishLampMinimum.h"

@class GtLinkedList;

/// GtLinkedListElement is protocol for a linked list object for use with GtLinkedList
@protocol GtLinkedListElement <NSObject>
@property (readwrite, strong, nonatomic) id nextObjectInLinkedList;
@property (readwrite, strong, nonatomic) id previousObjectInLinkedList;
@property (readwrite, weak, nonatomic) GtLinkedList* linkedList;
@end

/// Default methods for using any object in a GtLinkedList
@interface NSObject (GtLinkedList)
@property (readwrite, strong, nonatomic) id nextObjectInLinkedList;
@property (readwrite, strong, nonatomic) id previousObjectInLinkedList;
@property (readwrite, weak, nonatomic) GtLinkedList* linkedList;
@end

/// GtLinkedListElement is a concrete base class for making custom objects for use with GtLinkedList
@interface GtLinkedListElement : NSObject<GtLinkedListElement> {
@private
	id _nextObjectInLinkedList;
	id _previousObjectInLinkedList;
    __weak GtLinkedList* _linkedList;
}
@property (readwrite, strong, nonatomic) id nextObjectInLinkedList;
@property (readwrite, strong, nonatomic) id previousObjectInLinkedList;
@property (readwrite, weak, nonatomic) GtLinkedList* linkedList;

@end