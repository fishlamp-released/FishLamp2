//
//  ZFGroupElementSelectionOutlineViewDataSource.m
//  FishLampConnect
//
//  Created by Mike Fullerton on 4/5/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "ZFGroupElementSelectionOutlineViewDataSource.h"

#if OSX

#define ItemFromElement(group) group
//[group Id]

#define ElementFromItem(item) item
//[_selection elementForID:item]

@interface ZFGroupElementSelectionOutlineViewDataSource ()
@property (readwrite, strong, nonatomic) NSMutableSet* updates;
@end

@implementation ZFGroupElementSelectionOutlineViewDataSource

@synthesize outlineView = _outlineView;
@synthesize updates = _updates;

- (void) setOutlineView:(NSOutlineView*) outlineView {
    if(_outlineView) {
        _outlineView.dataSource = nil;
    }
    _outlineView = outlineView;
    if(_outlineView) {
        _outlineView.dataSource = self;
    }
}

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item {

    if(item == nil) {
        return self.rootGroup ? 1 : 0;
    }

    ZFGroupElement* element = ElementFromItem(item);
    if(element) {
        return element.isGroupElement ? [self childCountForGroup:(ZFGroup*) element] : 0;
    }

    return 0;
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item {
    
    if(item == nil) {
        return ItemFromElement(self.rootGroup);
    }

    ZFGroupElement* element = ElementFromItem(item);
    if(element) {
        return element.isGroupElement ? ItemFromElement([self childElementForGroup:(ZFGroup*) element atIndex:index]) : nil;
    }
    
    return nil;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item {
	return [ElementFromItem(item) isGroupElement];
}

- (id)outlineView:(NSOutlineView *)outlineView 
objectValueForTableColumn:(NSTableColumn *)tableColumn
		   byItem:(id)item {
	
    return [ElementFromItem(item) valueForKey:[tableColumn identifier]];
}

- (id)outlineView:(NSOutlineView *)outlineView itemForPersistentObject:(id)object {
    return object;
//    [self elementForID:object];
}

- (id)outlineView:(NSOutlineView *)outlineView persistentObjectForItem:(id)item {
    return item;
    
//    [item Id];
}

- (BOOL) expandGroupWithTableItem:(id) item expanded:(BOOL) expanded {
    return [self expandElement:item expanded:expanded];
}

- (void) didExpandGroup:(ZFGroup*) group 
             isExpanded:(BOOL) isExpanded {
    FLAssertNotNil(group);
    FLAssert([_outlineView rowForItem:ItemFromElement(group)] != NSNotFound);
    FLAssert([_outlineView isExpandable:ItemFromElement(group)]);
    FLAssert([group isKindOfClass:[ZFGroup class]]);
   
    if(isExpanded) {
         [_outlineView expandItem:ItemFromElement(group) expandChildren:NO];
    }
    else {
         [_outlineView collapseItem:ItemFromElement(group) collapseChildren:NO];
    }
    
//    FLAssert([_outlineView isItemExpanded:group] == isExpanded);
}

- (void) dealloc {
    _outlineView.dataSource = nil;
#if FL_MRC
    [_updates release];
    [super dealloc];
#endif    
}

- (void) updateExpansions {
    [_outlineView reloadData];
    [super updateExpansions];
    [_outlineView reloadData];
}

- (NSIndexSet*) selectionIndexesForProposedSelection:(NSIndexSet *)proposedSelectionIndexes {

    [self setSelectedIndexSet:proposedSelectionIndexes];
    NSIndexSet* set = self.selectedIndexSet;
#if TRACE
    FLLog(@"new selection:");
    [set enumerateIndexesUsingBlock:^(NSUInteger index, BOOL* stop) {
        FLLog(@"%ld", index)
    }];
#endif
    return set;
}

- (void) updateSelections {
    NSIndexSet* set = [self selectedIndexSet];
    [_outlineView selectRowIndexes:set byExtendingSelection:NO];
    [_outlineView reloadData];
}

- (void) setAllExpanded:(BOOL) expanded {
    [super setAllExpanded:expanded];
    [_outlineView reloadData];
    [self updateSelections];
}

- (void) sortWithDescriptor:(NSSortDescriptor*) descriptor {
    [super sortWithDescriptor:descriptor];
    [self updateSelections];
}

- (void)outlineView:(NSOutlineView *)outlineView 
sortDescriptorsDidChange:(NSArray *)oldDescriptors {       
    [self sortWithDescriptor:[[outlineView sortDescriptors] firstObject]];
}

#define kUpdateDelay .15

- (void) updateQueuedUpdates {

    if(self.updates && self.updates.count) {
        for(id item in self.updates) {
            [_outlineView reloadItem:item];
        }
        [self.updates removeAllObjects];
        
        [self performSelector:@selector(updateQueuedUpdates) withObject:nil afterDelay:kUpdateDelay];
    }
    else {
        self.updates = nil;
    }
}

- (void) didReplaceElement:(id) oldItem atIndex:(NSUInteger) index withElement:(id) element {

//    id oldItem = FLRetainWithAutorelease([_outlineView itemAtRow:index]);
    
    // this can be nil if we get a new photoSet and there is a filter in place.
    if(oldItem) {
        if(!self.updates) {
            self.updates = [NSMutableSet set];
            [self performSelector:@selector(updateQueuedUpdates) withObject:nil afterDelay:kUpdateDelay];
        }
        
        [self.updates addObject:oldItem];
        
        ZFGroup* parent = [_outlineView parentForItem:oldItem];
    #if TRACE
        FLLog(@"Updated Element: %@ at row %d", [element Title], index);
    #endif
            
        while(parent) {
            [self.updates addObject:parent];
            parent = [_outlineView parentForItem:parent];
        }
    }
}

- (void) didChangeFilter {
    [super didChangeFilter];
    [self updateSelections];
    [_outlineView reloadData];
}




@end
#endif