//
//	FLZfZfGroup+More.h
//	MyZen
//
//	Created by Mike Fullerton on 10/24/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FishLampCocoa.h"
#import "FLZfGroup.h"

@interface FLZfGroup (More)

- (FLZfGroupElement*) findById:(NSUInteger) groupId;
- (FLZfGroupElement*) findByIdNumber:(NSNumber*) groupId;
- (FLZfGroup*) findParentForElement:(FLZfGroupElement*) element;

- (BOOL) isRootGroup;

- (BOOL) hasDirectDecendent:(FLZfGroupElement*) inElement;

- (void) removeGroupElement:(FLZfGroupElement*) element;
- (void) addGroupElement:(FLZfGroupElement*) element;
- (BOOL) replaceGroupElement:(FLZfGroupElement*) replacingElement;

// not needed anymore?
- (void) addGroupElement:(FLZfGroupElement*) element parentId:(unsigned long) parentId;
- (void) removeGroupElement:(FLZfGroupElement*) removeThisElement parentId:(unsigned long) parentId;;
- (BOOL) replaceElement:(FLZfGroupElement*) replacingElement parentId:(unsigned long) parentId;;

@end
