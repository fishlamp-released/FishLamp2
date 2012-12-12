//
//	EditableItemsBaseViewController.m
//	FishLamp
//
//	Created by Mike Fullerton on 6/4/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLEditObjectViewController.h"
#import "FLLegacyAlertView.h"
#import "FLGeometry.h"
#import "FLHtmlHelpViewController.h"
#import "FLLegacyDataSource.h"
#import "FLTableView.h"
#import "FLReachableNetwork.h"
#import "FLOldUserNotificationView.h"
#import "FLAlert.h"
#import "FLEditObjectViewControllerButtonStrategy.h"

#import "FLGradientView.h"
#import "FLFloatingViewController.h"
#import "FLButtons.h"

#pragma GCC diagnostic ignored "-Warc-performSelector-leaks"

@implementation FLEditObjectViewController

FLSynthesizeStructProperty(loaded, setLoaded, BOOL, _editFlags);
FLSynthesizeStructProperty(autoResizeFloatingView, setAutoResizeFloatingView, BOOL, _editFlags);
FLSynthesizeStructProperty(isLoadingEditableData, setIsLoadingEditableData, BOOL, _editFlags);
FLSynthesizeStructProperty(initialLoadCompleted, setInitialLoadCompleted, BOOL, _editFlags);
FLSynthesizeStructProperty(isSavingEditableData, setIsSavingEditableData, BOOL, _editFlags);
FLSynthesizeStructProperty(requiresNetworkToEdit, setRequiresNetworkToEdit, BOOL, _editFlags);
FLSynthesizeStructProperty(backButtonSavesChanges, setBackButtonSavesChanges, BOOL, _editFlags);
FLSynthesizeStructProperty(saveChangesImmediately, setSaveChangesImmediately, BOOL, _editFlags);

@synthesize dataChangedEvent = _dataChangedEvent;
@synthesize beginSaveCallback = _beginSaveCallback;
@synthesize backgroundImage = _backgroundImage; // setter is below
@synthesize tabBar = _tabBar;
@synthesize dataSourceManager = _dataSourceManager;
@synthesize tableLayout = _layout;
@synthesize buttonStrategy = _buttonStrategy;
@synthesize saveButtonTitle = _saveButtonTitle;
@synthesize cancelButtonTitle = _cancelButtonTitle;

- (BOOL) willConfirmCancelIfChanged
{
	return _editFlags.willConfirmCancelIfChanged;
}

- (void) setWillConfirmCancelIfChanged:(BOOL) confirm
{
	_editFlags.willConfirmCancelIfChanged = confirm;
}

- (void) _initEditObjectViewController
{
	self.autoResizeFloatingView = YES;
	self.wantsFullScreenLayout = YES;
	self.showTextEditingBar = YES;
	self.willConfirmCancelIfChanged = YES;
	
	_dataSourceManager = [[FLLegacyDataSource alloc] init];
	_dataSourceManager.delegate = self;
	
	self.cancelButtonTitle = NSLocalizedString(@"Cancel", nil);
	self.saveButtonTitle = NSLocalizedString(@"Save", nil);
	
	self.buttonStrategy = FLEditObjectViewControllerShowBackButtonOnly;
    
    self.contentSizeForViewInFloatingView = DeviceIsPad() ? FLSizeMake(500, 600) : FLSizeMake(320, 480);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
	{
		[self _initEditObjectViewController];
	}
	return self;
}

- (UIScrollView*) createScrollView
{
    FLTableView* tableView = FLAutorelease([[FLTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain]);
    tableView.autoresizingMask = UIViewAutoresizingFlexibleEverything;
    tableView.autoresizesSubviews = YES;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    return tableView;
}

//- (void)loadView
//{
//	if(FLStringIsNotEmpty(self.nibName))
//	{
//		[super loadView];
//	}
//	else
//	{
//		FLGradientView* view = [[[FLGradientView alloc] initWithFrame:CGRectMake(0,0,320,480)]);		
//		view.autoresizingMask = UIViewAutoresizingFlexibleEverything;
//		view.autoresizesSubviews = YES;
//		self.view = view;
//	}
//}

- (void) _createTableLayout
{
	FLReleaseWithNil(_layout);
	FLPerformBlockInAutoreleasePool(^{
        _layout = [[FLTableViewLayout alloc] initWithCellDataSouce:self];
        [self doUpdateDataSourceManager:self.dataSourceManager];
        [self willConstructWithTableLayoutBuilder:[FLTableViewLayoutBuilder tableViewLayoutBuilder:_layout]];
    });
}

- (CGRect) autoSizedTableViewFrame
{
    CGRect frame = self.tableView.frame;
    
    if(CGRectIsEmpty(frame))
    {
        return self.view.frame;
    }
    
    frame.size.height = [self.tableView calculateTotalHeight];
    frame.size.height += DeviceIsPad() ? 20.0f : 10.0f;
    frame.size.height += self.scrollView.contentInset.top;
    
    return frame;
}

//- (void) willShowInFloatingViewController:(FLFloatingViewController*) controller
//{
//    controller.contentViewSize = self.contentSizeForViewInFloatingView;
//
//    if(self.autoResizeFloatingView)
//    {
//        controller.contentViewSize = [self autoSizedTableViewFrame].size;
//    }
//    else
//    {
//        controller.contentViewSize = FLSizeMake( 500, MIN(600, self.view.frame.size.height));
//    }
//}

- (void) viewDidLoad
{
    [super viewDidLoad];
	
    FLAssertIsNotNil_(self.tableView);

	FLAssert_v(self.tableView.style == UITableViewStylePlain, @"TableView must be UITableViewStylePlain");
	FLAssert_v(self.tableView.separatorStyle == UITableViewCellSeparatorStyleNone, @"TableView.seperatorStyle must be UITableViewCellSeparatorStyleNone");
	
	self.tableView.backgroundColor = [UIColor clearColor];
	self.tableView.cellSeparatorLine = FLTableViewCellSeparatorLineSingleLineEtched;
	self.tableView.drawSectionBorders = YES;
	self.tableView.sectionMargins = DeviceIsPad() ? UIEdgeInsetsMake(0,10.0f,0,10.0f):UIEdgeInsetsMake(0,5.0f,0,5.0f);
	self.tableView.sectionPadding = UIEdgeInsetsMake(10.0f,10.0f,10.0f,10.0f);

	[self _createTableLayout];

//    if(self.autoResizeFloatingView)
//    {
//        self.view.frame = CGRectSetSize(self.view.frame, self.autoSizeWidth, self.autoSizeWidth);
//    }

    if(DeviceIsPad())
	{
		self.tableView.sectionHeaderHeight = 16.0f;
	}
	else
	{
		self.tableView.sectionHeaderHeight = 6.0f;
	}
	
	self.tableView.sectionFooterHeight = 0;
	
	if(_tabBar)
	{
		_tabBar.selectedItem = [_tabBar.items objectAtIndex:0];
	}
	
	FLAssert_v([self.tableView isKindOfClass:[FLTableView class]], @"TableView needs to be a FLTableView");

    self.contentSizeForViewInFloatingView = FLSizeMake( 500, MIN(600, self.view.frame.size.height));
}

- (BOOL) objectWasEdited
{
	return _editFlags.objectWasEdited;
}

- (void) setObjectWasEdited:(BOOL) wasEdited
{
    _editFlags.objectWasEdited = YES;

    FLInvokeCallback(_dataChangedEvent, self);

    if(_buttonStrategy)
    {
        _buttonStrategy(self);
    }
}

- (void) saveChanges
{

}

- (BOOL) didChangeDataForKey:(id) key previousValue:(id) previousValue
{

	return YES;
}

- (BOOL) didRemoveDataForKey:(id) key previousValue:(id) previousValue
{
 

	return YES;
}

- (void) updateModalState
{
	FLFloatingViewController* popover = self.floatingViewController;
	if(popover)
	{
		popover.contentViewIsModal = self.isModal;
	}
	
}

- (BOOL) isModal
{
	return _editFlags.isModal;
}

- (void) setIsModal:(BOOL) isModal
{
	_editFlags.isModal = isModal;
	
	[self updateModalState];
}

- (void) dataSourceManager:(FLLegacyDataSource*) dataSource 
	dataChangedForKeyPath:(id) key 
	newValue:(id) newValue
	previousValue:(id) previousValue
{
	if(self.loaded && self.initialLoadCompleted)
	{
		if([self didChangeDataForKey:key previousValue:previousValue])
		{
			self.objectWasEdited = YES;
		}
	}
}

- (void) dataSourceManager:(FLLegacyDataSource*) dataSource 
	dataRemovedForKeyPath:(id) key 
	previousValue:(id) previousValue
{
	if(self.loaded && self.initialLoadCompleted)
	{
		if([self didRemoveDataForKey:key previousValue:previousValue])
		{
			self.objectWasEdited = YES;
		}
	}
}

- (void) cleanUpEditableObjectView
{
	FLReleaseWithNil(_tabBar);
	FLReleaseWithNil(_bottomToolbar);
	FLReleaseWithNil(_topToolbar);
	FLReleaseWithNil(_imageView);

	FLTableViewLayout* layout = _layout;
	_layout = nil;
	[layout prepareForDestruction];
	FLRelease(layout);
}

- (NSString*) helpFileName
{
	return nil;
}

- (void) shutDown
{
/*	this destroys stuff in a way that prevents delegates
	and views from calling back into us and crashing us 
	after we're gone */
	
	self.tableView.delegate = nil;
	self.tableView.dataSource = nil;
	_dataSourceManager.delegate = nil;
	[self stopEditing];

	[self cleanUpEditableObjectView];
}

- (void)dealloc 
{	
	[self shutDown];
	FLRelease(_cancelButtonTitle);
	FLRelease(_saveButtonTitle);
	FLRelease(_dataSourceManager);
	FLRelease(_backgroundImage);
	super_dealloc_();
}

- (void) showBackgroundImage:(BOOL) show animated:(BOOL) animated
{
	if(_backgroundImage)
	{
		if(show)
		{
			if(_imageView)
			{
				[_imageView removeFromSuperview];
				FLRelease(_imageView);
			}

			_imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
			_imageView.contentMode = UIViewContentModeScaleAspectFit;
			_imageView.autoresizingMask = UIViewAutoresizingFlexibleEverything;
			_imageView.backgroundColor = [UIColor clearColor];
			_imageView.image = _backgroundImage;
			[self.view insertSubview:_imageView atIndex:0];
			if(animated)
			{
				[_imageView animateOntoScreen:FLViewAnimationTypeFade duration:0.3 finishedBlock:nil];
			}
		}
		else
		{
			if(animated)
			{
				[_imageView removeFromSuperviewWithAnimationType:FLViewAnimationTypeFade duration:0.3 finishedBlock:nil];
			}
			else
			{
				[_imageView removeFromSuperview];
			}
			FLReleaseWithNil(_imageView);
		}
	}
	else
	{
		[_imageView removeFromSuperview];
		FLReleaseWithNil(_imageView);
	}
}

- (void) hideNavigationController:(BOOL) animated
{
	[self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void) updateViewContentsDescriptor
{
    FLMutableViewContentsDescriptor* descriptor = [FLMutableViewContentsDescriptor viewContentsDescriptorWithTop:FLViewContentItemNone bottom:FLViewContentItemNone hasStatusBar:YES];

    if(self.navigationController && !self.navigationController.navigationBarHidden)
    {
        descriptor.topItem = FLViewContentItemNavigationBar;
    }
    
    if(_topToolbar && !_topToolbar.hidden)
    {
        descriptor.topItem = FLViewContentItemToolbar;
    }

    descriptor.hasStatusBar = self.floatingViewController == nil;
        
	if(_tabBar && !_tabBar.hidden)
	{
		descriptor.bottomItem = FLViewContentItemTabBar;
	}
	
	if(_bottomToolbar && !_bottomToolbar.hidden)
	{
		descriptor.bottomItem = FLViewContentItemToolbar;
	}
    
    self.viewContentsDescriptor = descriptor;
}

- (void) willConstructWithTableLayoutBuilder:(FLTableViewLayoutBuilder*) builder
{

}

- (void) doUpdateDataSourceManager:(FLLegacyDataSource*) dataSourceManager
{

}

- (void) doBeginLoadingObject
{
	[self onDoneLoadingEditableData];
}

- (void) beginLoadingEditableData
{
	self.loaded = NO;
	_editFlags.isLoadingEditableData = YES;
	_editFlags.initialLoadCompleted = NO;
	
	if(self.requiresNetworkToEdit)
	{
		_editFlags.loadingNetworkData = [FLReachableNetwork instance].isReachable;
	}
	
	[self setButtonsEnabled:NO];
	if(_buttonStrategy)
	{
		_buttonStrategy(self);
	}

	[self doBeginLoadingObject];
}

- (void) buttonClickForHelpButton:(id) sender
{
	FLHtmlHelpViewController* helpView = [[FLHtmlHelpViewController alloc] initWithButtonMode:FLWebViewControllerButtonModeNone];
	helpView.fileName = self.helpFileName;
	[self.navigationController pushViewController:helpView animated:YES];
	FLReleaseWithNil(helpView);
}

- (id) objectForKey:(id) key
{
	id dataSource = [self.dataSourceManager dataSourceForDataSourceKey:key];
	if(dataSource)
	{
		return dataSource;
	}

	return [self.dataSourceManager objectForKeyPath:key];
}

- (void) setObject:(id) object forKey:(id) key fireChangeEvent:(BOOL) fireChangeEvent
{
	[self.dataSourceManager setObject:object forKeyPath:key fireDataChangedEvent:fireChangeEvent];
}

- (void) viewWillDisappear:(BOOL)animated
{
	[self stopEditing];
	[super viewWillDisappear:animated];
}

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
//	if(FLStringIsNotEmpty(self.helpFileName) && self.buttonbar)
//	{	
//		[self.buttonbar addViewToRightSide:
//			[FLDeprecatedButtonbarView createImageButtonByName:@"help-white.png" imageColor:FLImageColorBlack target:self action:@selector(buttonClickForHelpButton:)] forKey:@"help" animated:NO];
//	}
	
	if(!self.loaded)
	{
		[self beginLoadingEditableData];
	}
	
	[self.tableView reloadData];
	
	[self.view setNeedsLayout];
	
	if(_buttonStrategy)
	{
		_buttonStrategy(self);
	}
}

- (void) respondToBackButtonPress:(id) sender
{
	if(self.backButtonSavesChanges)
	{
		[self respondToSaveButton:nil];
	}
	else
	{
		[self respondToCancelButton:nil];
	}
}


- (BOOL) backButtonWillDismissViewController
{
	return NO;
}

- (void) viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	[self.tableView reloadData];
	[self updateModalState];

}

- (void) viewDidUnload
{
	[super viewDidUnload];
	[self cleanUpEditableObjectView];
}

- (void) onDoneLoadingEditableData
{
	if(self.requiresNetworkToEdit && _editFlags.loadingNetworkData)
	{
		_editFlags.loadingNetworkData = NO;
		_editFlags.loadedNetworkData = YES;
	}

	_editFlags.isLoadingEditableData = NO;
	_editFlags.initialLoadCompleted = YES;
	self.loaded = YES;
	[self setButtonsEnabled:YES];
	
	if(_buttonStrategy)
	{
		_buttonStrategy(self);
	}

	if(self.autoResizeFloatingView)
	{
        FLFloatingViewController* controller = self.floatingViewController;
        if(controller && [self.navigationController rootViewController] == self)
        {   
            [controller setContentViewSize:[self autoSizedTableViewFrame].size animated:NO];
        }
	}

	[self.tableView reloadData];
}

- (void) didBeginEditingText
{
	if(_buttonStrategy)
	{
		_buttonStrategy(self);
	}
}

- (void) didStopEditing
{
	if(_buttonStrategy)
	{
		_buttonStrategy(self);
	}
	[self setEditing:NO animated:YES];
}

- (void) onDoneEditing:(id) sender
{
	[self stopEditing];
	if(_buttonStrategy)
	{
		_buttonStrategy(self);
	}
	[self.tableView reloadData];
}

- (IBAction) startEditing:(id) sender
{
	[self setEditing:YES animated:YES];
	
	if(_buttonStrategy)
	{
		_buttonStrategy(self);
	}
			
	[self.tableView reloadData];
}

- (void) setButtonsEnabled:(BOOL) enabled
{
	if(_bottomToolbar)
	{
	   [_bottomToolbar setAllItemsEnabled:enabled];
	}
	
	if(self.cancelButton)
	{
		self.cancelButton.enabled = enabled;
	}
	if(self.saveButton)
	{
		self.saveButton.enabled = enabled;
	}
}

- (void) stopEditing
{	
	[super stopEditingText:NO];
}

- (void) onPrepareCancel
{
	[self stopEditing];
	[self onCancelComplete];
}

- (void) onCancelComplete
{
	FLAutorelease(FLRetain(self));
    [self dismissViewControllerAnimated:YES];
    
//	FLInvokeCallback(self.dismissEvent, self);
}

- (void) displayCancelAlert:(SEL) cancelAction
{
	FLAlert* alert = [FLAlert alertViewController:NSLocalizedString(@"Are you sure?", nil)
            message:NSLocalizedString(@"Your changes will not be saved.", nil)];
    
    [alert addButton:[FLDenyButton noButton]];
   
    __block FLEditObjectViewController* _self = self;
    
    [alert addButton:[FLConfirmButton yesButton:^(id sender){
        [_self performSelector:cancelAction withObject:nil];
    }]];
    	
	[alert presentViewControllerAnimated:YES];
}

- (void) confirmCancel
{	
	if(self.objectWasEdited && self.willConfirmCancelIfChanged)
	{
		[self displayCancelAlert:@selector(onPrepareCancel)];
	}
	else
	{
		[self onPrepareCancel];
	}
}

- (IBAction) respondToCancelButton:(id) sender
{
	[self confirmCancel];
}

- (void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
	FLEditObjectTableViewCell* row = [self.tableLayout.currentTab cellForIndexPath:indexPath];
	FLAssertIsNotNil_(row);
	if(row)
    {
        row.viewController = self;
        FLInvokeCallback(row.accessoryWasTappedCallback, row);
    }
}

- (id) tableViewCellGetCellData:(FLEditObjectTableViewCell*) cell
{
	return [self.dataSourceManager objectForKeyPath:cell.dataKeyPath];
}

- (void) tableViewCell:(FLEditObjectTableViewCell*) cell setCellData:(id) object
{
	[self.dataSourceManager setObject:object forKeyPath:cell.dataKeyPath fireDataChangedEvent:YES];
}

- (FLTextEditCell*) textEditCellGetNextEditableCell:(FLTextEditCell*) cell {
	return [[self.tableLayout rowForRowKey:cell.rowKey].parentSection findNextCellToEdit:cell];
}

- (FLTextEditCell*) textEditCellGetPreviousEditableCell:(FLTextEditCell*) cell {
	return [[self.tableLayout rowForRowKey:cell.rowKey].parentSection findPrevCellToEdit:cell];
}

- (void) updateCellStateForRow:(FLEditObjectTableViewCell*) row indexPath:(NSIndexPath*) indexPath
{
	FLAssertIsNotNil_(row);
	[row applyThemeIfNeeded];

	if([row isKindOfClass:[FLEditObjectTableViewCell class]])
	{
		FLEditObjectTableViewCell* tableViewCell = (FLEditObjectTableViewCell*) row;

        if(tableViewCell.hasDataKey)
        {
            tableViewCell.dataSource = self;
            tableViewCell.dataIsLoaded = self.loaded;
        }
        else
        {
            tableViewCell.dataIsLoaded = YES;
            tableViewCell.dataSource = nil;
        }
		
		[tableViewCell willShowInTable:self.tableView atIndexPath:indexPath];
		
		[tableViewCell updateCellState];
		[tableViewCell calculateCellHeightInTable:self.tableView];
	}
	else
	{
		FLLog(@"%@ unknown cell", NSStringFromClass([row class]));
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	FLAssertIsNotNil_(_layout);

	FLEditObjectTableViewCell* cell = [self.tableLayout.currentTab cellForIndexPath:indexPath];
	FLAssertIsNotNil_(cell);

    if(cell)
    {
        cell.viewController = self;
        cell.shouldIndentWhileEditing = NO;

        [self setDelegateForCellIfTextEditCell:cell];
	
        FLInvokeCallback(cell.willReloadCallback, cell);
        [self updateCellStateForRow:cell indexPath:indexPath];
	}

	return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellEditingStyleNone; 
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
	NSInteger count = MAX(1, (int) (_layout == nil ? 1 : [self.tableLayout.currentTab sectionCount]));
	return count;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	if(!_layout)
	{
		return 0;
	}

	FLTableViewSection* group = [[self.tableLayout currentTab] sectionAtIndex:section];
	FLAssertIsNotNil_(group);
	return [group cellCount];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(!self.loaded)
	{
		return nil;
	}
    
    return indexPath;
}

- (void) tableViewWillReloadData:(UITableView *)tableView
{
	[super tableViewWillReloadData:tableView];
	[self doUpdateDataSourceManager:self.dataSourceManager];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	FLAssertIsNotNil_(_layout);

	FLEditObjectTableViewCell* row = [self.tableLayout.currentTab cellForIndexPath:indexPath];
	FLAssertIsNotNil_(row);
	FLAssertIsNotNil_(row);	
	[self updateCellStateForRow:row indexPath:indexPath];
	
	CGFloat height = 0;
	if([row respondsToSelector:@selector(cellHeight)])
	{
		height = [row cellHeight];
	}
	
	return height == 0.0f ? self.tableView.rowHeight : height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
	FLTableViewSection* section = [[self.tableLayout currentTab] sectionAtIndex:sectionIndex];
	UIView* headerView = section.headerView;
	if(section.headerHeight)
	{
		headerView.frameOptimizedForSize = FLRectSetHeight(headerView.frame, MAX(section.headerHeight, section.headerView.minHeight));
	}
	else
	{
		headerView.frameOptimizedForSize = FLRectSetHeight(headerView.frame, MAX(tableView.sectionHeaderHeight, section.headerView.minHeight));
	}

	return headerView.frame.size.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	return [[self.tableLayout currentTab] sectionAtIndex:section].headerView;
}

#if DEBUG
//#warning reenabled truncating data that's too long   
#endif
- (void) truncateEditedTextForDataRow:(FLEditObjectTableViewCell*) dataRow 
	forIndexPath:(NSIndexPath*) path
{
	id data = [self.dataSourceManager objectForKeyPath:[dataRow dataKeyPath]];
	
	if(data && [data isKindOfClass:[NSString class]])
	{
		NSString* string = data;
		
		if( dataRow.maxDataSize > 0 && 
			string.length > dataRow.maxDataSize)
		{
			[self.dataSourceManager setObject:[string substringToIndex:dataRow.maxDataSize] forKeyPath:[dataRow dataKeyPath] fireDataChangedEvent:NO];
		}
	}
}

- (void) doFinalizeDataInDataRow:(FLEditObjectTableViewCell*) dataRow
{
}

- (void) finalizeDataBeforeCommit
{
    

//	  NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
//
//	  @try
//	  {
//		  for(NSUInteger i = 0; i < self.tableLayout.tabCount; i++)
//		  {
//			  FLTableViewTab* tab = [self.tableLayout tabWithIndex:i];
//			  for(NSUInteger j = 0; j < tab.sectionCount; j++)
//			  {
//				  FLTableViewSection* group = [tab sectionAtIndex:j];
//				  
//				  for(NSUInteger y = 0; y < group.rowCount; y++)
//				  {
//					  FLEditObjectTableViewCell* row = [group rowAtIndex:y];
//					  
//					  if(row.isEditable)
//					  {
//						  NSIndexPath* path = [NSIndexPath indexPathForRow:y inSection:i];
//					  
//						  if(![self shouldCommitDisplayDataRow:row 
//							  forIndexPath:path])
//						  {
//							  return NO; // ABORT!!
//						  }
//					  
//						  [self truncateEditedTextForDataRow:row
//							  forIndexPath:path];
//					  }
//				  }
//			  }
//		  }
//	  }
//	  @catch(NSException* ex)
//	  {
//		  FLDrainPoolAndRethrow(&pool, ex);
//	  }
//	  @finally
//	  {
//		  FLDrainPool(&pool);
//	  }
//	  
}

- (void) _beginEditingTextWithRowKey:(NSString*) rowKey
{
	[self beginEditingTextInCell:(FLTextEditCell*) [self cellForRowKey:rowKey]];
}

- (void) beginEditingTextWithRowKey:(NSString*) rowKey
{
	[self performSelectorOnMainThread:@selector(_beginEditingTextWithRowKey:) withObject:rowKey waitUntilDone:NO];
}

- (BOOL) willBeginSavingChanges
{
	return YES;
}

- (void) doBeginSavingChanges
{
	[self didFinishSavingChanges:YES];
}

- (IBAction) respondToSaveButton:(id) sender
{
	if(self.requiresNetworkToEdit && ![FLReachableNetwork instance].isReachable)
	{

// TODO: Fix this

//		FLOldUserNotificationView* view = [[FLOldUserNotificationView alloc] initAsErrorNotification];;
//		view.title = NSLocalizedString(@"Unable to save changes.", nil);
//		view.text = NSLocalizedString(@"Please try again when you have a network connection.", nil);
//		[view showNotification];
//		FLReleaseWithNil(view);
	}
	else if([self willBeginSavingChanges])
	{
		[self stopEditing];
	
		[self finalizeDataBeforeCommit];
	
		_editFlags.isSavingEditableData = YES;
		[self setButtonsEnabled:NO];
		
		if(!FLInvokeCallback(_beginSaveCallback, self))
		{
			[self doBeginSavingChanges];
		}
	}
}

- (void) didFinishSavingChanges:(BOOL) dismissViewControllerAnimated
{
	_editFlags.isSavingEditableData = NO;
	
	if(dismissViewControllerAnimated)
	{
        [self dismissViewControllerAnimated:YES];
    
//		FLInvokeCallback(self.dismissEvent, self);
	}
	else
	{
		[self setButtonsEnabled:YES];
	}
}

- (void) _showOfflineEditingAlert
{
// TODO: fix this

//	FLOldUserNotificationView* view = [[FLOldUserNotificationView alloc] initAsWarningNotification];
//	view.title = NSLocalizedString(@"A network connection is required for editing.", nil);
//	view.shouldAutoCloseAfterDelay = YES;
//	
//	[view showNotification];
//	FLReleaseWithNil(view);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	if(self.requiresNetworkToEdit && !_editFlags.loadedNetworkData)
	{
		FLEditObjectTableViewCell* row = [self.tableLayout.currentTab cellForIndexPath:indexPath];
		FLAssertIsNotNil_(row);
		
        if(row)
        {
            BOOL canEdit = NO;
            
            FLInvokeCallback(row.wasSelectedCallback, row);
            
            if([row isKindOfClass:[FLTextEditCell class]])
            {
                canEdit = YES;
            }
            
            if(canEdit)
            {
                [self _showOfflineEditingAlert];
            }
        }
	}
	else if(self.loaded) 
	{
		FLEditObjectTableViewCell* row = [self.tableLayout.currentTab cellForIndexPath:indexPath];
		FLAssertIsNotNil_(row);
		
        if(row && ![row disabled])
		{
            FLInvokeCallback(row.wasSelectedCallback, row);
        	
			if(![self beginEditingTextInCell:row atIndexPath:indexPath])
			{
				[self.tableView reloadData];
			}
		}

	}
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) willShowInTab:(NSUInteger) tab
{
	[self stopEditing];
	self.tableLayout.currentTabIndex = tab;
	[self.tableView reloadData];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)selectedItem
{
	[self stopEditing];
	NSArray* items = tabBar.items;
	NSUInteger tab = 0;
	for(UITabBarItem* item in items)
	{	
		if(selectedItem == item)
		{
			self.tableLayout.currentTabIndex = tab;
			break;
		}
		++tab;
	}
	[self.tableView reloadData];
}

//- (NSIndexPath*) indexPathForCell:(FLEditObjectTableViewCell*) cell
//{
//	return [self.tableLayout.currentTab indexPathForCell:cell];
//}

- (FLEditObjectTableViewCell*) tableViewCell:(UITableViewCell*) cell rowInfoForKey:(id) key
{
	return [_layout.currentTab rowForRowKey:key];
}

//- (id) dataToEdit
//{
//	  return [self.dataSourceManager dataSourceForDataSourceKey:self.dataToEditKey];
//}

//- (id) dataToEditKey
//{
//	  return _saveKey;
//}

//- (void) setDataToEdit:(id) data 
//	  forKey:(id) key 
//	  saveToDataSource:(FLLegacyDataSource*) saveToDataSourceManager
//{
//	  FLAssignObjectWithRetain(_saveKey, key);
//	  FLAssignObjectWithRetain(_saveToDataSourceManager, saveToDataSourceManager);
//	  
//	  if([data conformsToProtocol:@protocol(NSMutableCopying)])
//	  {
//		  [self.dataSourceManager setDataSource:FLAutorelease([data mutableCopy]) forKey:key];
//	  }
//	  else if([data conformsToProtocol:@protocol(NSCopying)])
//	  {
//		  [self.dataSourceManager setDataSource:FLAutorelease([data copy]) forKey:key];
//	  }
//	  else
//	  {
//		  [self.dataSourceManager setDataSource:FLAutorelease([data copy]) forKey:key];
//	  }
//}

- (void) networkDidBecomeUnavailable
{
	if(self.requiresNetworkToEdit)
	{
		FLOldUserNotificationView* view = [[FLOldUserNotificationView alloc] initAsInfoNotification];;
		view.title = NSLocalizedString(@"Network connection is unavailable.", nil);
		view.text = NSLocalizedString(@"A network connection is required to save changes.", nil);
#if VIEW_AUTOLAYOUT
		view.autoLayoutMode = FLRectLayoutMake(FLRectLayoutHorizontalCentered, FLRectLayoutVerticalTop);
#endif        
		[view showNotification];
		FLReleaseWithNil(view);
	}
	
	[super networkDidBecomeUnavailable];
}

- (void) networkDidBecomeAvailable
{
	[super networkDidBecomeAvailable];
	
	if(self.requiresNetworkToEdit && !_editFlags.loadedNetworkData)
	{
		_editFlags.loadingNetworkData = YES;
		[self beginLoadingEditableData];
	}
}

- (BOOL)textEditCellDoStartEditing:(FLTextEditCell *)cell
{
	if(self.requiresNetworkToEdit)
	{	
		if(_editFlags.loadedNetworkData)
		{
			return [super textEditCellDoStartEditing:cell];
		}
		
		[self _showOfflineEditingAlert];
		return NO;
	}
	
	return [super textEditCellDoStartEditing:cell];
}
   
- (UITableViewCell*) cellForRowKey:(NSString*) rowKey
{
	return [self.tableLayout rowForRowKey:rowKey];
}	

- (FLLegacyButton*) cancelButton
{
	return (FLLegacyButton*) [self.buttonbar viewForKey:@"cancel"];
}

- (FLLegacyButton*) saveButton
{
	return (FLLegacyButton*) [self.buttonbar viewForKey:@"save"];
}


@end

#import "FLGradientButton.h"
#import "FLNavigationController.h"

void FLEditObjectViewControllerShowCancelButtonOnly(FLEditObjectViewController* controller)
{
	if(controller.view.superview)
	{
		controller.willConfirmCancelIfChanged = NO;

		if(!controller.buttonbar.backButtonHidden)
		{
			[controller.buttonbar setBackButtonHidden:YES animated:NO];
		}

		if(!controller.cancelButton)
		{
			[controller.buttonbar addButtonToLeftSide:[FLToolbarButtonDeprecated toolbarButton:NSLocalizedString(@"Cancel", nil)
			 target:controller action:@selector(respondToCancelButton:)] forKey:@"cancel" animated:NO];
		}
	}
}

void FLEditObjectViewControllerShowBackButtonOnly(FLEditObjectViewController* controller)
{
	if(controller.view.superview)
	{
		controller.willConfirmCancelIfChanged = NO;

		if(controller.navigationController.rootViewController == controller)
		{
			controller.buttonbar.backButtonHidden = YES;
		
			if(!controller.cancelButton)
			{
				[controller.buttonbar addButtonToLeftSide:[FLToolbarButtonDeprecated toolbarButton:NSLocalizedString(@"Cancel", nil)
				 target:controller action:@selector(respondToCancelButton:)] forKey:@"cancel" animated:NO];
			}
		}
	}
}

void FLEditObjectViewControllerShowNoButtons(FLEditObjectViewController* controller)
{
	if(controller.view.superview)
	{
		[controller.buttonbar setBackButtonHidden:YES animated:NO];
	}
}

void FLEditObjectViewControllerShowButtonsWhenEdited(FLEditObjectViewController* controller)
{
	if(controller.view.superview)
	{
		if(controller.objectWasEdited)
		{
			if(!controller.buttonbar.backButtonHidden)
			{
				[controller.buttonbar setBackButtonHidden:YES animated:NO];
			}
			
			controller.isModal = YES;
			
			if(!controller.cancelButton)
			{
				if(controller.navigationController.rootViewController == controller)
				{
					[controller.buttonbar addButtonToLeftSide:[FLToolbarButtonDeprecated toolbarButton:controller.cancelButtonTitle
					 target:controller action:@selector(respondToCancelButton:)] forKey:@"cancel" animated:YES];
				}
				else
				{
					[controller.buttonbar addButtonToLeftSide:[FLBackButtonDeprecated backButton:controller.cancelButtonTitle
					 target:controller action:@selector(respondToCancelButton:)] forKey:@"cancel" animated:YES];
				}
			}

			if(!controller.saveButton)
			{
				[controller.buttonbar addButtonToRightSide:[FLToolbarButtonDeprecated toolbarButton:FLGradientButtonColorBrightBlue title:controller.saveButtonTitle
				 target:controller action:@selector(respondToSaveButton:)] forKey:@"save" animated:YES];
			}
		}
		else 
		{
			if(controller.navigationController.rootViewController == controller)
			{
				if(!controller.cancelButton)
				{
					[controller.buttonbar addButtonToLeftSide:[FLToolbarButtonDeprecated toolbarButton:NSLocalizedString(@"Cancel", nil)
						target:controller action:@selector(respondToCancelButton:)] forKey:@"cancel" animated:NO];
				
				}
			}
		}
	}
}

void FLEditObjectViewControllerShowButtonsImmediately(FLEditObjectViewController* controller)
{
	if(controller.view.superview)
	{
		controller.buttonbar.backButtonHidden = YES;
		if(controller.objectWasEdited)
		{
			controller.isModal = YES;
		} 

		if(!controller.cancelButton)
		{
			if(controller.navigationController.rootViewController == controller)
			{
				[controller.buttonbar addButtonToLeftSide:[FLToolbarButtonDeprecated toolbarButton:controller.cancelButtonTitle
				 target:controller action:@selector(respondToCancelButton:)] forKey:@"cancel" animated:NO];
			}
			else
			{
				[controller.buttonbar addButtonToLeftSide:[FLBackButtonDeprecated backButton:controller.cancelButtonTitle
				 target:controller action:@selector(respondToCancelButton:)] forKey:@"cancel" animated:NO];
			}
		}
		
		if(!controller.saveButton)
		{
			[controller.buttonbar addButtonToRightSide:[FLToolbarButtonDeprecated toolbarButton:FLGradientButtonColorBrightBlue title:controller.saveButtonTitle
			 target:controller action:@selector(respondToSaveButton:)] forKey:@"save" animated:NO];
		}
	}
}

