//
//  GtTextEditCellManager.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/4/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#include "GtTextEditCell.h"
#include "GtActionQueue.h"

@interface GtTextEditCellManager : NSObject<GtTextEditCellDelegate> {
	
    GtTextEditCell* m_currentCell;
    
	// not retained
	UITableView* m_tableView;
    id m_delegate;
	
    int m_prevHeight;
	struct {
        unsigned int resized:1;
        unsigned int keyboardShowing:1;
    } m_flags;
}

@property (readwrite, assign, nonatomic) id delegate;

- (id) initWithTableView:(UITableView*) tableView;

- (void) setDelegateForCellIfTextEditCell:(UITableViewCell*) cell;

- (void) beginEditingCell:(GtTextEditCell*) cell;
- (void) stopEditing;
- (void) cancelEditing; // short circuits any delegate callbacks.
- (BOOL) startEditingForRowIfTextEditCell:(UITableViewCell*) cell atIndexPath:(NSIndexPath*) indexPath;
- (BOOL) isEditing;

@end

@protocol GtTextEditCellManagerDelegate <NSObject>
- (id) textEditCellManager:(GtTextEditCellManager*) manager cellForIndexPath:(NSIndexPath*) indexPath;
- (NSIndexPath*) textEditCellManager:(GtTextEditCellManager*) manager indexPathForRowId:(id) rowId;
- (NSIndexPath*) textEditCellManager:(GtTextEditCellManager*) manager indexPathForCell:(UITableViewCell*) cell;
- (void) textEditCellManager:(GtTextEditCellManager*) manager didBeginEditingCell:(GtTextEditCell *)cell;
- (void) textEditCellManager:(GtTextEditCellManager*) manager didEndEditingCell:(GtTextEditCell *)cell;

@optional
- (void) textEditCellManager:(GtTextEditCellManager*) manager cellScrolledIntoView:(GtTextEditCell *)cell;

- (void) textEditCellManagerDidStartEditing:(GtTextEditCellManager*) manager;
- (void) textEditCellManagerDidEndEditing:(GtTextEditCellManager*) manager;

@end