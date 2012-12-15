//
//	FLObjectEditingViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/10/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FLTableViewLayout.h"
#import "FLDisplayFormatters.h"
#import "FLTextEditingTableViewController.h"
#import "FLTextEditCell.h"

#import "FLEditObjectTableViewCell.h"
#import "FLLegacyDataSource.h"
#import "FLTableViewLayoutBuilder.h"
#import "FLEditObjectViewControllerButtonStrategy.h"
#import "FLFunctor.h"

#import "FLGradientButton.h"

@class FLEditObjectViewController;

typedef void (*FLEditObjectButtonStrategy)(FLEditObjectViewController* controller);

extern void FLEditObjectViewControllerShowNoButtons(FLEditObjectViewController* controller);
extern void FLEditObjectViewControllerShowBackButtonOnly(FLEditObjectViewController* controller); 
extern void FLEditObjectViewControllerShowCancelButtonOnly(FLEditObjectViewController* controller); 
extern void FLEditObjectViewControllerShowButtonsWhenEdited(FLEditObjectViewController* controller);
extern void FLEditObjectViewControllerShowButtonsImmediately(FLEditObjectViewController* controller);

@interface FLEditObjectViewController : FLTextEditingTableViewController<
	UITabBarDelegate,
	FLTableViewCellDataSource,
	FLLegacyDataSourceDelegate> {

@private
	IBOutlet UITabBar* _tabBar; // optional
	IBOutlet UIToolbar* _bottomToolbar; // optional
	IBOutlet UIToolbar* _topToolbar; // optional
	UIImageView* _imageView;
	UIImage* _backgroundImage;
	FLTableViewLayout* _layout;
	FLLegacyDataSource* _dataSourceManager;
	NSString* _cancelButtonTitle;
	NSString* _saveButtonTitle;

	FLEditObjectButtonStrategy _buttonStrategy;
	FLCallback_t _beginSaveCallback;
	FLCallback_t _dataChangedEvent;
	
	struct {
// construction
		unsigned int transparent:1;
		unsigned int loadingNetworkData: 1;
		unsigned int loadedNetworkData: 1;
		unsigned int requiresNetworkToEdit:1;
		unsigned int autoResizeFloatingView:1;		   
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
	} _editFlags;
}

@property (readwrite, assign, nonatomic) FLCallback_t dataChangedEvent;

@property (readwrite, assign, nonatomic) BOOL saveChangesImmediately;
@property (readwrite, assign, nonatomic) BOOL backButtonSavesChanges;

@property (readwrite, retain, nonatomic) NSString* cancelButtonTitle; // defaults to Cancel
@property (readwrite, retain, nonatomic) NSString* saveButtonTitle; // defaults to Save
@property (readonly, retain, nonatomic) FLLegacyButton* cancelButton;
@property (readonly, retain, nonatomic) FLLegacyButton* saveButton;

// state
@property (readwrite, assign, nonatomic) BOOL isModal;
@property (readwrite, assign, nonatomic) BOOL requiresNetworkToEdit;
@property (readwrite, assign, nonatomic) BOOL willConfirmCancelIfChanged;
@property (readwrite, assign, nonatomic) BOOL autoResizeFloatingView;

// buttons
@property (readwrite, assign, nonatomic) FLEditObjectButtonStrategy buttonStrategy;
- (void) setButtonsEnabled:(BOOL) enabled; // for bottom toolbar buttons and save buttons.
- (IBAction) startEditing:(id) sender;

// editing text
- (void) beginEditingTextWithRowKey:(NSString*) rowKey;
- (void) stopEditing;

// tableLayout
@property (readonly, retain, nonatomic) FLTableViewLayout* tableLayout;
- (void) willConstructWithTableLayoutBuilder:(FLTableViewLayoutBuilder*) builder;

// data management
- (void) doUpdateDataSourceManager:(FLLegacyDataSource*) dataSourceManager;
@property (readonly, retain, nonatomic) FLLegacyDataSource* dataSourceManager;

// loading
@property (readonly, assign, nonatomic) BOOL isLoadingEditableData;
@property (readonly, assign, nonatomic) BOOL initialLoadCompleted;
@property (readonly, assign, nonatomic) BOOL loaded;
- (void) doBeginLoadingObject;
- (void) onDoneLoadingEditableData;

// saving
@property (readwrite, assign, nonatomic) FLCallback_t beginSaveCallback;
@property (readonly, assign, nonatomic) BOOL isSavingEditableData;
- (IBAction) respondToSaveButton:(id) sender; 
- (void) doBeginSavingChanges;
- (BOOL) willBeginSavingChanges;
- (void) didFinishSavingChanges:(BOOL) hideViewController;

// finalizing data
- (void) finalizeDataBeforeCommit; // return NO stops commit
- (void) truncateEditedTextForDataRow:(FLEditObjectTableViewCell*) dataRow 
	forIndexPath:(NSIndexPath*) path;
- (void) doFinalizeDataInDataRow:(FLEditObjectTableViewCell*) dataRow;

// editing flags
@property (readwrite, assign, nonatomic) BOOL objectWasEdited; // if yes user will be prompted on cancel
- (BOOL) didChangeDataForKey:(id) key previousValue:(id) previousValue; // return YES if changes marks the object as edited.
- (BOOL) didRemoveDataForKey:(id) key previousValue:(id) previousValue;

// cancelling
//@property (readwrite, copy, nonatomic) dispatch_block_t didCancelCallback;
- (IBAction) respondToCancelButton:(id) sender;
- (void) onPrepareCancel;
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
