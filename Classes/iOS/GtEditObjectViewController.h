//
//	GtObjectEditingViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/10/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <UIKit/UIKit.h>

#import "GtTableViewLayout.h"
#import "GtDisplayFormatters.h"
#import "GtTextEditingTableViewController.h"
#import "GtTextEditCell.h"

#import "GtEditObjectTableViewCell.h"
#import "GtDataSource.h"
#import "GtTableViewLayoutBuilder.h"
#import "GtEditObjectViewControllerButtonStrategy.h"
#import "GtFunctor.h"

#import "GtGradientButton.h"

@class GtEditObjectViewController;

typedef void (*GtEditObjectButtonStrategy)(GtEditObjectViewController* controller);

extern void GtEditObjectViewControllerShowNoButtons(GtEditObjectViewController* controller);
extern void GtEditObjectViewControllerShowBackButtonOnly(GtEditObjectViewController* controller); 
extern void GtEditObjectViewControllerShowCancelButtonOnly(GtEditObjectViewController* controller); 
extern void GtEditObjectViewControllerShowButtonsWhenEdited(GtEditObjectViewController* controller);
extern void GtEditObjectViewControllerShowButtonsImmediately(GtEditObjectViewController* controller);

@interface GtEditObjectViewController : GtTextEditingTableViewController<
	UITabBarDelegate,
	GtTableViewCellDataSource,
	GtDataSourceManagerDelegate> {

@private
	IBOutlet UITabBar* m_tabBar; // optional
	IBOutlet UIToolbar* m_bottomToolbar; // optional
	IBOutlet UIToolbar* m_topToolbar; // optional
	UIImageView* m_imageView;
	UIImage* m_backgroundImage;
	GtTableViewLayout* m_layout;
	GtDataSourceManager* m_dataSourceManager;
	NSString* m_cancelButtonTitle;
	NSString* m_saveButtonTitle;

	GtEditObjectButtonStrategy m_buttonStrategy;
	GtCallback m_beginSaveCallback;
	GtCallback m_dataChangedEvent;
	
	struct {
// construction
		unsigned int transparent:1;
		unsigned int loadingNetworkData: 1;
		unsigned int loadedNetworkData: 1;
		unsigned int requiresNetworkToEdit:1;
		unsigned int autoResizeHoverView:1;		   
		unsigned int willConfirmCancelIfChanged: 1;
// state
		unsigned int objectWasEdited:1;
		unsigned int loaded:1;
		unsigned int initialLoadCompleted:1;
		unsigned int isLoadingEditableData:1;
		unsigned int isSavingEditableData:1;
		unsigned int isModal:1;
		unsigned int backButtonSavesChanges: 1;
		unsigned int saveChangesImmediately: 1;
		unsigned int didSetSizeInPopover: 1;
	} m_editFlags;
}

@property (readwrite, assign, nonatomic) GtCallback dataChangedEvent;

@property (readwrite, assign, nonatomic) BOOL saveChangesImmediately;
@property (readwrite, assign, nonatomic) BOOL backButtonSavesChanges;

@property (readwrite, retain, nonatomic) NSString* cancelButtonTitle; // defaults to Cancel
@property (readwrite, retain, nonatomic) NSString* saveButtonTitle; // defaults to Save
@property (readonly, retain, nonatomic) GtButton* cancelButton;
@property (readonly, retain, nonatomic) GtButton* saveButton;

// state
@property (readwrite, assign, nonatomic) BOOL isModal;
@property (readwrite, assign, nonatomic) BOOL requiresNetworkToEdit;
@property (readwrite, assign, nonatomic) BOOL willConfirmCancelIfChanged;
@property (readwrite, assign, nonatomic) BOOL autoResizeHoverView;

// buttons
@property (readwrite, assign, nonatomic) GtEditObjectButtonStrategy buttonStrategy;
- (void) setButtonsEnabled:(BOOL) enabled; // for bottom toolbar buttons and save buttons.
- (IBAction) startEditing:(id) sender;

// editing text
- (void) beginEditingTextWithRowKey:(NSString*) rowKey;
- (void) stopEditing;

// tableLayout
@property (readonly, retain, nonatomic) GtTableViewLayout* tableLayout;
- (void) willConstructWithTableLayoutBuilder:(GtTableViewLayoutBuilder*) builder;

// data management
- (void) doUpdateDataSourceManager:(GtDataSourceManager*) dataSourceManager;
@property (readonly, retain, nonatomic) GtDataSourceManager* dataSourceManager;

// loading
@property (readonly, assign, nonatomic) BOOL isLoadingEditableData;
@property (readonly, assign, nonatomic) BOOL initialLoadCompleted;
@property (readonly, assign, nonatomic) BOOL loaded;
- (void) doBeginLoadingObject;
- (void) onDoneLoadingEditableData;

// saving
@property (readwrite, assign, nonatomic) GtCallback beginSaveCallback;
@property (readonly, assign, nonatomic) BOOL isSavingEditableData;
- (IBAction) respondToSaveButton:(id) sender; 
- (void) doBeginSavingChanges;
- (BOOL) willBeginSavingChanges;
- (void) didFinishSavingChanges:(BOOL) dismissViewController;

// finalizing data
- (void) finalizeDataBeforeCommit; // return NO stops commit
- (void) truncateEditedTextForDataRow:(GtEditObjectTableViewCell*) dataRow 
	forIndexPath:(NSIndexPath*) path;
- (void) doFinalizeDataInDataRow:(GtEditObjectTableViewCell*) dataRow;

// editing flags
@property (readwrite, assign, nonatomic) BOOL objectWasEdited; // if yes user will be prompted on cancel
- (BOOL) didChangeDataForKey:(id) key previousValue:(id) previousValue; // return YES if changes marks the object as edited.
- (BOOL) didRemoveDataForKey:(id) key previousValue:(id) previousValue;

// cancelling
//@property (readwrite, copy, nonatomic) GtBlock didCancelCallback;
- (IBAction) respondToCancelButton:(id) sender;
- (void) onBeginCancel;
- (void) onCancelComplete;
- (void) displayCancelAlert:(SEL) cancelAction;

// help
- (NSString*) helpFileName;

// views/controls
@property (readonly, retain, nonatomic) UITabBar* tabBar;
- (UITableViewCell*) cellForRowKey:(NSString*) rowKey;

// background image
@property (readwrite, retain, nonatomic) UIImage* backgroundImage;
- (void) showBackgroundImage:(BOOL) show animated:(BOOL) animated;

- (id) objectForKey:(id) key;
- (void) setObject:(id) object forKey:(id) key fireChangeEvent:(BOOL) fireChangeEvent;

@end
