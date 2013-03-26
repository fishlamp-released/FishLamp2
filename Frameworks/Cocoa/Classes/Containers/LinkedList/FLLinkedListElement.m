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
	FLSuperDealloc();
}
#endif

@end


@implementation NSObject (FLLinkedList)
FLSynthesizeAssociatedProperty(FLAssociationPolicyAssignNonatomic, linkedList, setLinkedList, FLLinkedList*);
FLSynthesizeAssociatedProperty(FLAssociationPolicyRetainNonatomic, nextObjectInLinkedList, setNextObjectInLinkedList, id);
FLSynthesizeAssociatedProperty(FLAssociationPolicyRetainNonatomic, previousObjectInLinkedList, setPreviousObjectInLinkedList, id);
@end
