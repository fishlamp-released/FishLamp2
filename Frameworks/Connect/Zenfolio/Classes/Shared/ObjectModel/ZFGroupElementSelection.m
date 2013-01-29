//
//  ZFGroupElementSelection.m
//  ZenLib
//
//  Created by Mike Fullerton on 12/22/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "ZFGroupElementSelection.h"

@implementation ZFGroupElement (Selection)

- (void) selectionDidChange:(BOOL) selected inSelection:(ZFGroupElementSelection*) selection {
    for(ZFGroupElement* element in self.elements) {
        [selection setGroupElementSelected:element selected:selected];
    }
}

- (NSArray *)selectedPhotoSets:(ZFGroupElementSelection*) selection {
	NSMutableArray *selectedSets = [NSMutableArray array];
    [self visitAllElements:^(ZFGroupElement* element, BOOL* stop) {
        if(!element.isGroupElement && [selection isGroupElementSelected:element]) {
            [selectedSets addObject:element];
        }
    }];
	return selectedSets;
}

- (long long) selectedPhotoBytes:(ZFGroupElementSelection*) selection {

	NSArray *elem = [self selectedPhotoSets:selection];
	return elem ? [[elem valueForKeyPath:@"@sum.photoBytes"] longLongValue] : 0;
}

- (int)selectedPhotoCount:(ZFGroupElementSelection*) selection {
	return [[[self selectedPhotoSets:selection] valueForKeyPath:@"@sum.photoCount"] intValue];
}

- (void) addSelectionsToIndexedSet:(NSMutableIndexSet*) set 
                     fromSelection:(ZFGroupElementSelection*) selection 
                     currentIndex:(NSUInteger*) currentIndex {
    
    if([selection isGroupElementSelected:self]) {
        [set addIndex:*currentIndex];
    }
    
    ++(*currentIndex);
    
    for(ZFGroupElement* element in self.elements) {
        [element addSelectionsToIndexedSet:set fromSelection:selection currentIndex:currentIndex];
    }
}     

- (ZFGroupElement*) elementAtIndex:(NSInteger) elementIndex counter:(NSInteger*) counter {
    if(elementIndex == (*counter)++) {
        return self;
    }
    
    for(ZFGroupElement* element in self.elements) {
        ZFGroupElement* found = [element elementAtIndex:elementIndex counter:counter];
        if(found) {
            return found;
        }
    }
    
    return nil;
}

- (ZFGroupElement*) elementAtIndex:(NSInteger) index {
    NSInteger counter = 0;
    return [self elementAtIndex:index counter:&counter];
}

@end

@implementation ZFGroupElementSelection

- (id) init {
    self = [super init];
    if(self) {
        _selected = [[NSMutableSet alloc] init];
    }
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_selected release];
    [super dealloc];
}
#endif

- (NSIndexSet*) indexSetForSelectionsInGroup:(ZFGroup*) group {
    NSMutableIndexSet* set = [NSMutableIndexSet indexSet];
    NSUInteger index = 0;
    [group addSelectionsToIndexedSet:set fromSelection:self currentIndex:&index];
    return set;
}

- (void) setGroupElementSelected:(ZFGroupElement*) element selected:(BOOL) selected {

    if(selected) {
        [_selected addObject:element.Id];
    }
    else {
        [_selected removeObject:element.Id];
    }

    [element selectionDidChange:selected inSelection:self];
}

- (BOOL) isGroupElementSelected:(ZFGroupElement*) element {
    return [_selected containsObject:element.Id];
}

- (void) toggleSelectionForGroupElement:(ZFGroupElement*) element {
    FLAssertNotNil_(element);
    BOOL selected = [self isGroupElementSelected:element];
    [self setGroupElementSelected:element selected:!selected];
}



//- (NSIndexSet*) selectedRowsInGroup:(ZFGroup*) rootGroup {
//
//
//}


@end
