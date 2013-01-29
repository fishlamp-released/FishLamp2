//
//	ZFZfGroup+More.h
//	MyZen
//
//	Created by Mike Fullerton on 10/24/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FishLampCocoa.h"
#import "ZFGroup.h"

@interface ZFGroup (More)

- (ZFGroupElement*) findById:(NSUInteger) groupId;
- (ZFGroupElement*) findByIdNumber:(NSNumber*) groupId;
- (ZFGroup*) findParentForElement:(ZFGroupElement*) element;

- (BOOL) isRootGroup;

- (BOOL) hasDirectDecendent:(ZFGroupElement*) inElement;

- (void) removeGroupElement:(ZFGroupElement*) element;
- (void) addGroupElement:(ZFGroupElement*) element;
- (BOOL) replaceGroupElement:(ZFGroupElement*) replacingElement;

// not needed anymore?
- (void) addGroupElement:(ZFGroupElement*) element parentId:(unsigned long) parentId;
- (void) removeGroupElement:(ZFGroupElement*) removeThisElement parentId:(unsigned long) parentId;;
- (BOOL) replaceElement:(ZFGroupElement*) replacingElement parentId:(unsigned long) parentId;;

@end
