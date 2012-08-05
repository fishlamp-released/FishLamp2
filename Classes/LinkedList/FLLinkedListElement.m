//
//  FLLinkedListElement.m
//  FishLampCore
//
//  Created by Mike Fullerton on 4/24/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLLinkedListElement.h"
#import "FLLinkedList.h"
#import <objc/runtime.h>

@implementation FLLinkedListElement

@synthesize nextObjectInLinkedList = _nextObjectInLinkedList;
@synthesize previousObjectInLinkedList = _previousObjectInLinkedList;
@synthesize linkedList = _linkedList;

#if FL_DEALLOC
- (void) dealloc {
    [_nextObjectInLinkedList release];
    [_previousObjectInLinkedList release];
	[super dealloc];
}
#endif

@end


@implementation NSObject (FLLinkedList)

static void * const kNextObjectKey = (void*)&kNextObjectKey;
static void * const kPrevObjectKey = (void*)&kPrevObjectKey;
static void * const kLinkedListObjectKey = (void*)&kLinkedListObjectKey;

- (FLLinkedList*) linkedList {
    return  objc_getAssociatedObject(self, kLinkedListObjectKey);
}

- (void) setLinkedList:(FLLinkedList *)linkedList {
    FLAssert(   linkedList == nil ||
                [self linkedList] == nil, @"already in a linked list?"); 
    objc_setAssociatedObject(self, kLinkedListObjectKey, linkedList, OBJC_ASSOCIATION_ASSIGN);
}

- (id) nextObjectInLinkedList {
    return objc_getAssociatedObject(self, kNextObjectKey);
}

- (void) setNextObjectInLinkedList:(id) object {
    objc_setAssociatedObject(self, kNextObjectKey, object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id) previousObjectInLinkedList {
    return objc_getAssociatedObject(self, kPrevObjectKey);
}

- (void) setPreviousObjectInLinkedList:(id) object {
    objc_setAssociatedObject(self, kPrevObjectKey, object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
  
@end
