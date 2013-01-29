//
//  ZFGroupViewWizardPanel.m
//  ZenLib
//
//  Created by Mike Fullerton on 12/21/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "ZFGroupViewWizardPanel.h"
#import "UIViewController+FLAdditions.h"
#import "ZFEntryCell.h"
#import "FLWizardViewController.h"
#import "NSFont+ZFAdditions.h"
#import "ZFProgressSheet.h"
#import "ZFSyncGroupHierarchyOperation.h"

@interface ZFSimpleClickOutlineView : NSOutlineView {
}

- (void) interceptEvent:(NSEvent*) event;
@end

@interface ZFDownloaderApplication : NSApplication {
@private
    id _interceptorView;
}
@property (readwrite, assign, nonatomic) id interceptorView;
@end

@implementation ZFDownloaderApplication 

@synthesize interceptorView = _interceptorView;

- (void)sendEvent:(NSEvent *)event {

// look for mouse down
    if(_interceptorView) {
//        if([_interceptorView hitTest:[event locationInWindow]]) {
            [_interceptorView interceptEvent:event];
//        }
    }
    
    [super sendEvent:event];
}

@end


@protocol ZFSimpleClickOutlineViewDelegate <NSTableViewDelegate>
@optional
- (void) tableView:(NSTableView*) table mouseDownInRow:(NSInteger) row;
- (void) tableView:(NSTableView*) table mouseDraggedIntoRow:(NSInteger) row fromRow:(NSInteger) fromRow;
@end


@implementation ZFSimpleClickOutlineView

int lastRow = -1;
int fromRow = -1;

- (void) interceptMouseDown:(NSEvent *)theEvent {
    
    fromRow = [self rowAtPoint:[self convertPoint:[theEvent locationInWindow] fromView:nil]];
    lastRow = fromRow;
    FLLog(@"clicked in row: %d", fromRow);
    [((id)self.delegate) tableView:self mouseDownInRow:fromRow];
}

- (void) interceptMouseDragged:(NSEvent *)theEvent {


//    NSInteger row = [self rowAtPoint:[self convertPoint:[theEvent locationInWindow] fromView:nil]];
//    FLLog(@"dragging in row: %d", row);
//    if(row >= 0) {
//        if(fromRow < 0) {
//            fromRow = row;
//            FLLog(@"start dragging into:%d", fromRow);
//        
//            [((id)self.delegate) tableView:self mouseDownInRow:fromRow];
//        }
//        else if(row != lastRow) {
//            FLLog(@"dragged into:%d from %d", row, fromRow);
//        
//            [((id)self.delegate) tableView:self mouseDraggedIntoRow:row fromRow:fromRow];
//        }
//
//        lastRow = row;
//    }
}

- (void) interceptMouseUp:(NSEvent*) event {
  
    FLLog(@"mouse up");
    
    lastRow = -1;
    fromRow = -1;
}

- (void) interceptEvent:(NSEvent*) event {
    
    FLLog(@"intercepted event: %d", event.type);
    switch(event.type) {
        case NSLeftMouseDown:
            [self interceptMouseDown:event];
            break;
        case NSLeftMouseUp:
            [self interceptMouseUp:event];
            break;
        case NSLeftMouseDragged:
            [self interceptMouseDragged:event];
            break;
       
        default:
            break;
    }
}

@end

@interface ZFGroupViewWizardPanel ()
@property (readwrite, strong, nonatomic) ZFGroup* rootGroup;
@end

@interface ZFGroupElement (sorting)
- (void) sort:(NSSortDescriptor*) descriptor;
@end

@implementation ZFGroupElement (sorting)
- (void) sort:(NSSortDescriptor*) descriptor {
}
@end

@implementation ZFGroup (sorting)
- (void) sort:(NSSortDescriptor*) descriptor {
    NSMutableArray* elements = self.Elements;
    
    [elements sortUsingComparator:^NSComparisonResult (id lhs, id rhs) {
        [lhs sort:descriptor];
        [rhs sort:descriptor];
        id lhsValue = [lhs valueForKey:descriptor.key];
        id rhsValue = [rhs valueForKey:descriptor.key];
        if([lhsValue respondsToSelector:@selector(localizedCaseInsensitiveCompare:)]) {
        
            return descriptor.ascending ?   [lhsValue localizedCaseInsensitiveCompare:rhsValue]: 
                                            [rhsValue localizedCaseInsensitiveCompare:lhsValue];
        }
        return descriptor.ascending ? [lhsValue compare:rhsValue] : [rhsValue compare:lhsValue];
    }];
}
@end


@implementation ZFGroupViewWizardPanel

@synthesize rootGroup = _rootGroup;

- (id) init {
    self = [super initWithNibName:@"ZFGroupViewWizardPanel" bundle:nil];
    if(self) {
        self.title = @"Select Galleries to Download";
        self.breadcrumbTitle = @"Galleries";
//        self.enabled = NO;
    }
    return self;
}

+ (id) groupViewWizardPanel {
    return FLAutorelease([[[self class] alloc] init]);
}

#if FL_MRC
- (void) dealloc {
    [_rootGroup release];
    [super dealloc];
}
#endif

- (void) loadView {
    [super loadView];
    [self view];
    
//    [_outlineView moveColumn:[_outlineView columnWithIdentifier:_nameColumn.identifier] toColumn:0];
    
    
	[_nameColumn setDataCell:[ZFEntryCell cell]];
    
//    NSSortDescriptor* titleSort = 
//        [NSSortDescriptor sortDescriptorWithKey:@"Title" 
//                                      ascending:YES 
//                                     comparator:^NSComparisonResult(id obj1, id obj2) {
//                                         return [[obj1 Title] localizedCaseInsensitiveCompare:[obj2 Title]];
//                                     }];
//
//    [_nameColumn setSortDescriptorPrototype:titleSort];
    
  	[_outlineView setAutoresizesOutlineColumn:NO];
    [_outlineView setSelectionHighlightStyle:NSTableViewSelectionHighlightStyleSourceList];
    [_outlineView setAllowsMultipleSelection:YES];
    [_outlineView setAllowsTypeSelect:YES];
    [_outlineView setAllowsEmptySelection:YES];
    
    if(_rootGroup) {
        _expandedFirstTime = YES;
        [_outlineView expandItem:nil  expandChildren:YES];
    }
    
    for(NSTableColumn* column in _outlineView.tableColumns) {
        id cell = [column dataCell];
        [cell setFont:[NSFont boldZenfolioFontOfSize:12]];
        [cell setTextColor:[NSColor darkGrayColor]];
    }
}

- (void) expandFirstTimeIfNeeded {
    if(_rootGroup) {
        [_outlineView reloadData];

        if(_rootGroup && !_expandedFirstTime) {
            _expandedFirstTime = YES;
            [_outlineView expandItem:nil  expandChildren:YES];
        }
    //    [_outlineView selectRowIndexes:]
        
        [_outlineView reloadData];
    }
}

- (void) downloadGroupsIfNeeded {
        
//    [operation addObserver:self];    

//    [operation startOperationInContext:_downloaderSession 
//                            completion:^(FLResult result) {
    
    if(!_rootGroup) {
    
        ZFSyncGroupHierarchyOperation* operation = [ZFSyncGroupHierarchyOperation syncGroupHierarchyOperation:[self.userContext userLogin]];    
        [self.wizard showProgress:@"Downloading Gallery Info…"];
    
//        [self.wizard progressWindow].cancelBlock = ^{
//            [[self.wizard userContext] requestCancel];
//            [self.wizard hideProgress];
//        };    


        [operation startOperationInContext:self.userContext completion:^(FLResult result) {
            [self.wizard hideProgress];
            self.rootGroup = result;
            
            [self expandFirstTimeIfNeeded];
        }];
        
    }
}

- (void) wizardPanelWillAppearInWizard:(FLWizardViewController*) wizard {
    [super wizardPanelWillAppearInWizard:wizard];

    [self expandFirstTimeIfNeeded];

//    wizard.otherButton.selected = @"Refresh";
//    wizard.otherButton.enabled = YES;
//    wizard.otherButton.hidden = NO;
    self.enabled = YES;
}

- (void) wizardPanelDidAppearInWizard:(FLWizardViewController*) wizard {
    [((id)[NSApplication sharedApplication]) setInterceptorView:_outlineView];
    [self downloadGroupsIfNeeded];
}

- (void) wizardPanelWillDisappearInWizard:(FLWizardViewController *)wizard {
    [((id)[NSApplication sharedApplication]) setInterceptorView:nil];
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item {
	return item ? [[item elements] objectAtIndex:index] : self.rootGroup;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item {
	return [item isGroupElement];
}

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item {
	return item ? [[item elements] count] : (self.rootGroup ? 1 : 0);
}

- (id)outlineView:(NSOutlineView *)outlineView 
objectValueForTableColumn:(NSTableColumn *)tableColumn
		   byItem:(id)item {
	
    return [item valueForKey:[tableColumn identifier]];
}

- (void)toggleSelectionForItemAtRow:(int)itemRow {
	ZFGroupElement *entry = [_outlineView itemAtRow:itemRow];
    [[self.userContext selection] toggleSelectionForGroupElement:entry];
	[_outlineView reloadData]; /* can be optimized */
}

- (void)outlineView:(NSOutlineView *)outlineView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn item:(id)item {
// set the group element for drawing the cell for this item.
    if(tableColumn == _nameColumn) {
        [cell setGroupElement:item];
    }
}

- (void) tableView:(NSTableView*) table mouseDraggedIntoRow:(NSInteger) row fromRow:(NSInteger) fromRow {
    
    [[self.userContext selection] setGroupElementSelected:[_rootGroup elementAtIndex:row] 
                               selected:[[self.userContext selection] isGroupElementSelected:[_rootGroup elementAtIndex:row]]];

    [_outlineView selectRowIndexes:[[self.userContext selection] indexSetForSelectionsInGroup:_rootGroup] byExtendingSelection:NO];
}


- (void) tableView:(NSTableView*) table mouseDownInRow:(NSInteger) row {
    
    if(row >= 0) {
        [[self.userContext selection] toggleSelectionForGroupElement:[_rootGroup elementAtIndex:row]];
    }
    
    [_outlineView selectRowIndexes:[[self.userContext selection] indexSetForSelectionsInGroup:_rootGroup] byExtendingSelection:NO];
}

- (BOOL)outlineView:(NSOutlineView *)outlineView shouldSelectItem:(id)item {
    return [[self.userContext selection] isGroupElementSelected:item];
}

- (NSIndexSet *)outlineView:(NSOutlineView *)outlineView 
selectionIndexesForProposedSelection:(NSIndexSet *)proposedSelectionIndexes {
    NSIndexSet* selections = [[self.userContext selection] indexSetForSelectionsInGroup:_rootGroup];
    return selections;
}

- (void)outlineView:(NSOutlineView *)outlineView sortDescriptorsDidChange:(NSArray *)oldDescriptors
{       
    NSSortDescriptor* newDescriptor = [[outlineView sortDescriptors] firstObject];
    [_rootGroup sort:newDescriptor];
    [_outlineView reloadData];
    [_outlineView selectRowIndexes:[[self.userContext selection] indexSetForSelectionsInGroup:_rootGroup] byExtendingSelection:NO];
}

- (id)outlineView:(NSOutlineView *)outlineView itemForPersistentObject:(id)object {
    return [_rootGroup findByIdNumber:object];
}

- (id)outlineView:(NSOutlineView *)outlineView persistentObjectForItem:(id)item {
    return [item Id];
}


@end
