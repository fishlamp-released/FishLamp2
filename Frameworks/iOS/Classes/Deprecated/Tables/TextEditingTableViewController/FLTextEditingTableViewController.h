//
//	FLTextEditingTableViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/20/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLTableViewController.h"
#import "FLTextEditingBar.h"
#import "FLTextEditCell.h"

@interface FLTextEditingTableViewController : FLTableViewController<FLTextEditCellDelegate, FLTextEditingBarDelegate> {
@private
	FLTextEditCell* _currentCell;
	FLTextEditingBar* _textEditBar;
	UIScrollView* _intermediateScrollView;
	NSMutableArray* _textEditCells;
	
	struct {
		unsigned int resizedForEditing:1;
		unsigned int showTextEditingBar:1;
		unsigned int keyboardWillShowInView:1; 
	} _textEditingTableViewControllerFlags;
	UIEdgeInsets _previousInsets;
}

@property (readonly, retain, nonatomic) UIScrollView* intermediateScrollView;

@property (readwrite, assign, nonatomic) BOOL keyboardWillShowInView; // YES by default. Set to NO if showing in Popover on iPad.
@property (readwrite, assign, nonatomic) BOOL showTextEditingBar;

- (void) beginEditingTextInCell:(FLTextEditCell*) cell;
- (BOOL) beginEditingTextInCell:(UITableViewCell*) cell atIndexPath:(NSIndexPath*) indexPath;

// per cell
- (void) didBeginEditingTextInCell:(FLTextEditCell *)cell;
- (void) didStopEditingTextInCell:(FLTextEditCell *)cell;

/// global editing switch
- (void) didBeginEditingText;
- (void) didStopEditingText:(BOOL) withDonePress;

- (BOOL) isEditingText;

- (void) stopEditingText:(BOOL) withDonePress;

- (void) setDelegateForCellIfTextEditCell:(UITableViewCell*) cell;

- (void) scrollTextEditCellIntoView:(FLTextEditCell*) cell animated:(BOOL) animated;

- (void) keyboardDidHide;
- (void) keyboardDidShow;

@end


@interface FLTextEditingTableViewController (Protected) 

- (id) cellForIndexPath:(NSIndexPath*) indexPath;
- (NSIndexPath*) indexPathForRowId:(id) rowId;
- (NSIndexPath*) indexPathForCell:(UITableViewCell*) cell;

- (FLTextEditCell*) textEditCellGetNextEditableCell:(FLTextEditCell*) cell;
- (FLTextEditCell*) textEditCellGetPreviousEditableCell:(FLTextEditCell*) cell;

@end