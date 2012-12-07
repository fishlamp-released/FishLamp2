//
//  FLLinkedListElement.m
//  FLCore
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

#if FL_MRC
- (void) dealloc {
    FLRelease(_nextObjectInLinkedList);
    FLRelease(_previousObjectInLinkedList);
	super_dealloc_();
}
#endif

@end


@implementation NSObject (FLLinkedList)
FLSynthesizeAssociatedProperty(assign_nonatomic, linkedList, setLinkedList, FLLinkedList*);
FLSynthesizeAssociatedProperty(FLRetainnonatomic, nextObjectInLinkedList, setNextObjectInLinkedList, id);
FLSynthesizeAssociatedProperty(FLRetainnonatomic, previousObjectInLinkedList, setPreviousObjectInLinkedList, id);
@end
