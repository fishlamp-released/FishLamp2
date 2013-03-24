//
//	ZFZenfolioGroup+More.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/24/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FishLampCocoa.h"
#import "ZFGroup.h"

typedef void (^FLGroupElementVisitor)(ZFGroupElement* element, BOOL* stop);

@interface ZFGroup (More)

- (ZFGroupElement*) findById:(NSUInteger) groupId;
- (ZFGroupElement*) findByIdNumber:(NSNumber*) groupId;
- (ZFGroup*) findParentForElement:(ZFGroupElement*) element;

- (BOOL) isRootGroup;

- (BOOL) hasDirectDecendent:(ZFGroupElement*) inElement;

- (void) removeGroupElement:(ZFGroupElement*) element;
- (void) addGroupElement:(ZFGroupElement*) element;
//- (BOOL) replaceGroupElement:(ZFGroupElement*) replacingElement;

// not needed anymore?
- (void) addGroupElement:(ZFGroupElement*) element parentId:(unsigned long) parentId;
- (void) removeGroupElement:(ZFGroupElement*) removeThisElement parentId:(unsigned long) parentId;;
- (BOOL) replaceElement:(ZFGroupElement*) replacingElement parentId:(unsigned long) parentId;;


- (NSArray*) pathComponentsToGroupElement:(ZFGroupElement*) element;
- (NSString*) pathToGroupElement:(ZFGroupElement*) element withDelimiter:(NSString*) delimiter;

- (BOOL) visitParentsForElement:(ZFGroupElement*) element visitor:(void (^)(ZFGroup* parent)) visitor;

/// recursively all children (does NOT visit self)
- (BOOL) visitAllSubElements:(FLGroupElementVisitor) visitor;

#if OSX
- (void) sort:(NSSortDescriptor*) descriptor;
#endif

@end
