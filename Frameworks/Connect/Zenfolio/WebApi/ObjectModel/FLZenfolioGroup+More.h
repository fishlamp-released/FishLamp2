//
//	FLZenfolioZenfolioGroup+More.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/24/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FishLampCocoa.h"
#import "FLZenfolioGroup.h"

@interface FLZenfolioGroup (More)

- (FLZenfolioGroupElement*) findById:(NSUInteger) groupId;
- (FLZenfolioGroupElement*) findByIdNumber:(NSNumber*) groupId;
- (FLZenfolioGroup*) findParentForElement:(FLZenfolioGroupElement*) element;

- (BOOL) isRootGroup;

- (BOOL) hasDirectDecendent:(FLZenfolioGroupElement*) inElement;

- (void) removeGroupElement:(FLZenfolioGroupElement*) element;
- (void) addGroupElement:(FLZenfolioGroupElement*) element;
- (BOOL) replaceGroupElement:(FLZenfolioGroupElement*) replacingElement;

// not needed anymore?
- (void) addGroupElement:(FLZenfolioGroupElement*) element parentId:(unsigned long) parentId;
- (void) removeGroupElement:(FLZenfolioGroupElement*) removeThisElement parentId:(unsigned long) parentId;;
- (BOOL) replaceElement:(FLZenfolioGroupElement*) replacingElement parentId:(unsigned long) parentId;;

// this is a bit wierd, since we're dealign with a tree here.
// this is a straighforward search through the heirarchy and obviously depends on sorts 
// orders of the subElements
- (id) elementAtIndex:(NSInteger) index;

- (NSArray*) pathComponentsToGroupElement:(FLZenfolioGroupElement*) element;

@end
