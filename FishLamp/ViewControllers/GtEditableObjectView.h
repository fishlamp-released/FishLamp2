//
//  GtEditableObjectView.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/10/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GtObjectEditHandler.h"
#import "GtDisplayDataGroup.h"
#import "GtDisplayFormatters.h"
#import "GtEditPanel.h"
#import "GtViewController.h"
#import "GtTextEditCell.h"
#import "GtTextEditCellManager.h"
#import "GtImageView.h"
#import "GtViewAnimator.h"

typedef enum 
{
	GtEditingModeLoading,
	GtEditingModeSaving,
	GtEditingModeUploading
} GtEditingMode;

typedef enum 
{
    GtSaveButtonStateNone,
    GtSaveButtonStateSave,
    GtSaveButtonStateDoneEditingText,
    GtSaveButtonStateEdit
} GtSaveButtonState;

@interface GtEditableObjectView : GtViewController<
	UITableViewDataSource, 
	UITableViewDelegate, 
	UITabBarDelegate,
	UIAlertViewDelegate,
	GtEditPanelDelegate,
	GtTextEditCellManagerDelegate,
	GtDisplayDataRowDataSource>  {

@private

/* views, all retained */	
	IBOutlet UITableView* m_tableView;
	IBOutlet UIBarButtonItem* m_leftButton;
	IBOutlet UIBarButtonItem* m_rightButton;
	IBOutlet UITabBar* m_tabBar; // optional
	IBOutlet UIToolbar* m_bottomToolbar; // optional
	IBOutlet UIToolbar* m_topToolbar; // optional
	GtImageView* m_imageView;
	
/* retained */
    id m_editableData;
	UIImage* m_backgroundImage;
	GtTextEditCellManager* m_textEditCellManager;
    id<GtViewAnimatorProtocol> m_viewAnimator;
    UINavigationController* m_rootNavigationController;
	GtObjectEditHandler* m_handler; // holds our data, and cached cells    

/* state */
    struct {
        unsigned int updated:1;
        unsigned int loaded:1;
        unsigned int wantsEditButton:1;
        unsigned int wantsSaveButton:1;
        unsigned int transparent:1;
        unsigned int editingMode:3;
        
        unsigned int saveButtonState:5; // a couple of extra
        unsigned int tab:3;
    } m_editFlags;

    CGFloat m_cellOpacity;
    CGFloat m_tableOpacity;

// not retained  
	id m_editableObjectViewDelegate;

}

// delegate
@property (readwrite, assign, nonatomic) id editableObjectViewDelegate;

// instantiation flags
@property (readwrite, assign, nonatomic) BOOL transparent;
@property (readwrite, assign, nonatomic) BOOL wantsEditButton;
@property (readwrite, assign, nonatomic) BOOL wantsSaveButton;

@property (readwrite, assign, nonatomic) CGFloat cellOpacity;
@property (readwrite, assign, nonatomic) CGFloat tableOpacity;

// state
@property (readwrite, assign, nonatomic) BOOL updated; // if yes user will be prompted on cancel

// this holds the rows and cells and groups, etc..
@property (readonly, assign, nonatomic) GtObjectEditHandler* editHandler;	

// background image
@property (readonly, assign, nonatomic) UIImage* backgroundImage;
- (void) setBackgroundImage:(UIImage*) backgroundImage fadeIn:(BOOL) fadeIn;

// views
@property (readonly, assign, nonatomic) UITableView* tableView;
@property (readonly, assign, nonatomic) UITabBar* tabBar;

@property (readwrite, assign, nonatomic) id editableData; // optional
    // note that this object must respond to objectForKey and setObject as in NSDictionary

@property (readonly, assign, nonatomic) UINavigationController* rootNavigationController;

- (void) createRootNavigationController:(UIBarStyle) style;
- (void) releaseRootNavigationController;

// TODO: need to add the other views

// events
- (IBAction) rightButton:(id) sender;
- (IBAction) leftButton:(id) sender;
- (IBAction) beginCommit:(id) sender; 

- (void) cancelEditing; 

- (void) updateButtons:(BOOL) animate;

- (void) configureTransparentCell:(GtTableViewCell*) cell;

- (NSString*) cancelMessage;

- (void) show:(UIView*) superView;
- (void) hide;
@property (readwrite, assign, nonatomic) id<GtViewAnimatorProtocol> viewAnimator;

@property (readwrite, assign, nonatomic) GtEditingMode editingMode;

@end

@interface GtEditableObjectView (Protected)

- (void) onAddRowsToEditHandler:(GtObjectEditHandler*) handler;

- (void) beginLoadingEditableData;
- (void) onDoneLoadingEditableData;

- (void) onBeginCommitChanges; // override this
- (void) onChangesCommitted; // call this 
- (void) onCommitFailed; // or call this

- (void) onBeginCancel;
- (void) onCancelComplete;

- (void) setSaveButton:(BOOL) animate;
- (void) setCancelButton:(BOOL) animate;
- (void) onSetInsetsAndTransparencies;

- (void) onRowWasEditedWithEditPanel:(id<GtEditPanelProtocol>) panel 
    row:(GtDisplayDataRow*) row
    newData:(id) newData;

- (void) onShowSelf:(UIView*) superView;
- (void) onHideSelf;

- (void) getSaveButtonForState:(GtSaveButtonState) state 
    outButton:(UIBarButtonItem**) outButton
    action:(SEL) action;

- (BOOL) finalizeDataBeforeCommit; // return NO stops commit

- (void) truncateEditedTextForDataRow:(GtDisplayDataRow*) dataRow 
    forIndexPath:(NSIndexPath*) path;
    
- (BOOL) shouldCommitDisplayDataRow:(GtDisplayDataRow*) dataRow
    forIndexPath:(NSIndexPath*) path; // return NO stops entire commit
@end

@protocol GtEditableObjectViewDelegate <NSObject>
@optional
- (void) editableObjectViewDataEditingCompleted:(GtEditableObjectView*) editableObjectView;
- (void) editableObjectViewDataEditingCancelled:(GtEditableObjectView*) editableObjectView;

@end