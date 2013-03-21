//
//	FLZenfolioZenfolioGroup+More.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/24/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FishLampCocoa.h"
#import "FLZenfolioGroup.h"

typedef void (^FLGroupElementVisitor)(FLZenfolioGroupElement* element, BOOL* stop);

@interface FLZenfolioGroup (More)

- (FLZenfolioGroupElement*) findById:(NSUInteger) groupId;
- (FLZenfolioGroupElement*) findByIdNumber:(NSNumber*) groupId;
- (FLZenfolioGroup*) findParentForElement:(FLZenfolioGroupElement*) element;

- (BOOL) isRootGroup;

- (BOOL) hasDirectDecendent:(FLZenfolioGroupElement*) inElement;

- (void) removeGroupElement:(FLZenfolioGroupElement*) element;
- (void) addGroupElement:(FLZenfolioGroupElement*) element;
//- (BOOL) replaceGroupElement:(FLZenfolioGroupElement*) replacingElement;

// not needed anymore?
- (void) addGroupElement:(FLZenfolioGroupElement*) element parentId:(unsigned long) parentId;
- (void) removeGroupElement:(FLZenfolioGroupElement*) removeThisElement parentId:(unsigned long) parentId;;
- (BOOL) replaceElement:(FLZenfolioGroupElement*) replacingElement parentId:(unsigned long) parentId;;


- (NSArray*) pathComponentsToGroupElement:(FLZenfolioGroupElement*) element;
- (NSString*) pathToGroupElement:(FLZenfolioGroupElement*) element withDelimiter:(NSString*) delimiter;

- (BOOL) visitParentsForElement:(FLZenfolioGroupElement*) element visitor:(void (^)(FLZenfolioGroup* parent)) visitor;

/// recursively all children (does NOT visit self)
- (BOOL) visitAllSubElements:(FLGroupElementVisitor) visitor;

#if OSX
- (void) sort:(NSSortDescriptor*) descriptor;
#endif

@end
