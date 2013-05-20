//
//	GtTextEditingTableViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/20/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtTableViewController.h"
#import "GtTextEditingBar.h"
#import "GtTextEditCell.h"

@interface GtTextEditingTableViewController : GtTableViewController<GtTextEditCellDelegate, GtTextEditingBarDelegate> {
@private
	GtTextEditCell* m_currentCell;
	GtTextEditingBar* m_textEditBar;
	UIScrollView* m_intermediateScrollView;
	NSMutableArray* m_textEditCells;
	
	struct {
		unsigned int resizedForEditing:1;
		unsigned int showTextEditingBar:1;
		unsigned int keyboardWillShowInView:1; 
	} m_textEditingTableViewControllerFlags;
	UIEdgeInsets m_previousInsets;
}

@property (readonly, retain, nonatomic) UIScrollView* intermediateScrollView;

@property (readwrite, assign, nonatomic) BOOL keyboardWillShowInView; // YES by default. Set to NO if showing in Popover on iPad.
@property (readwrite, assign, nonatomic) BOOL showTextEditingBar;

- (void) beginEditingTextInCell:(GtTextEditCell*) cell;
- (BOOL) beginEditingTextInCell:(UITableViewCell*) cell atIndexPath:(NSIndexPath*) indexPath;

// per cell
- (void) didBeginEditingTextInCell:(GtTextEditCell *)cell;
- (void) didStopEditingTextInCell:(GtTextEditCell *)cell;

/// global editing switch
- (void) didBeginEditingText;
- (void) didStopEditingText:(BOOL) withDonePress;

- (BOOL) isEditingText;

- (void) stopEditingText:(BOOL) withDonePress;

- (void) setDelegateForCellIfTextEditCell:(UITableViewCell*) cell;

- (void) scrollTextEditCellIntoView:(GtTextEditCell*) cell animated:(BOOL) animated;

- (void) keyboardDidHide;
- (void) keyboardDidShow;

@end


@interface GtTextEditingTableViewController (Protected) 

- (id) cellForIndexPath:(NSIndexPath*) indexPath;
- (NSIndexPath*) indexPathForRowId:(id) rowId;
- (NSIndexPath*) indexPathForCell:(UITableViewCell*) cell;

- (GtTextEditCell*) textEditCellGetNextEditableCell:(GtTextEditCell*) cell;
- (GtTextEditCell*) textEditCellGetPreviousEditableCell:(GtTextEditCell*) cell;

@end