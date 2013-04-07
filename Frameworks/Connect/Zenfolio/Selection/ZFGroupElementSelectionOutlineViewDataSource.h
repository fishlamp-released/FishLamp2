//
//  ZFGroupElementSelectionOutlineViewDataSource.h
//  FishLampConnect
//
//  Created by Mike Fullerton on 4/5/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//


#if OSX
#import "ZFGroupElementSelection.h"

@interface ZFGroupElementSelectionOutlineViewDataSource : ZFGroupElementSelection<NSOutlineViewDataSource> {
@private
    __unsafe_unretained NSOutlineView* _outlineView;
    
    NSMutableSet* _updates;
}
@property (readwrite, assign, nonatomic) NSOutlineView* outlineView;

- (BOOL) expandGroupWithTableItem:(id) item expanded:(BOOL) expanded;

- (NSIndexSet*) selectionIndexesForProposedSelection:(NSIndexSet*) selection;

- (void) updateSelections;
- (void) updateExpansions;

@end


#endif