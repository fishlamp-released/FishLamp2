//
//	EditableItemsBaseViewController.m
//	FishLamp
//
//	Created by Mike Fullerton on 6/4/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtEditObjectViewController.h"
#import "GtAlertView.h"
#import "GtGeometry.h"

#import "GtViewAnimator.h"
#
#import "GtHtmlHelpViewController.h"
#import "GtDataSource.h"
#import "GtTableView.h"
#import "GtNetworkStatusMonitor.h"
#import "GtUserNotificationView.h"

#import "GtEditObjectViewControllerButtonStrategy.h"

#import "GtGradientView.h"
#import "GtHoverViewController.h"


@implementation GtEditObjectViewController

GtSynthesizeStructProperty(loaded, setLoaded, BOOL, m_editFlags);
GtSynthesizeStructProperty(autoResizeHoverView, setAutoResizeHoverView, BOOL, m_editFlags);
GtSynthesizeStructProperty(isLoadingEditableData, setIsLoadingEditableData, BOOL, m_editFlags);
GtSynthesizeStructProperty(initialLoadCompleted, setInitialLoadCompleted, BOOL, m_editFlags);
GtSynthesizeStructProperty(isSavingEditableData, setIsSavingEditableData, BOOL, m_editFlags);
GtSynthesizeStructProperty(requiresNetworkToEdit, setRequiresNetworkToEdit, BOOL, m_editFlags);
GtSynthesizeStructProperty(backButtonSavesChanges, setBackButtonSavesChanges, BOOL, m_editFlags);
GtSynthesizeStructProperty(saveChangesImmediately, setSaveChangesImmediately, BOOL, m_editFlags);

@synthesize dataChangedEvent = m_dataChangedEvent;
@synthesize beginSaveCallback = m_beginSaveCallback;
@synthesize backgroundImage = m_backgroundImage; // setter is below
@synthesize tabBar = m_tabBar;
@synthesize dataSourceManager = m_dataSourceManager;
@synthesize tableLayout = m_layout;
@synthesize buttonStrategy = m_buttonStrategy;
@synthesize saveButtonTitle = m_saveButtonTitle;
@synthesize cancelButtonTitle = m_cancelButtonTitle;

- (BOOL) willConfirmCancelIfChanged
{
	return m_editFlags.willConfirmCancelIfChanged;
}

- (void) setWillConfirmCancelIfChanged:(BOOL) confirm
{
	m_editFlags.willConfirmCancelIfChanged = confirm;
}

- (void) _initEditObjectViewController
{
	self.autoResizeHoverView = YES;
	self.wantsFullScreenLayout = YES;
	self.showTextEditingBar = YES;
	self.willConfirmCancelIfChanged = YES;
	
	m_dataSourceManager = [[GtDataSourceManager alloc] init];
	m_dataSourceManager.delegate = self;
	
	self.cancelButtonTitle = NSLocalizedString(@"Cancel", nil);
	self.saveButtonTitle = NSLocalizedString(@"Save", nil);
	
	self.buttonStrategy = GtEditObjectViewControllerShowBackButtonOnly;
    
    self.contentSizeForViewInHoverView = DeviceIsPad() ? CGSizeMake(500, 600) : CGSizeMake(320, 480);
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
    GtTableView* tableView = GtReturnAutoreleased([[GtTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain]);
    tableView.autoresizingMask = UIViewAutoresizingFlexibleEverything;
    tableView.autoresizesSubviews = YES;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    return tableView;
}

//- (void)loadView
//{
//	if(GtStringIsNotEmpty(self.nibName))
//	{
//		[super loadView];
//	}
//	else
//	{
//		GtGradientView* view = [[[GtGradientView alloc] initWithFrame:CGRectMake(0,0,320,480)] autorelease];		
//		view.autoresizingMask = UIViewAutoresizingFlexibleEverything;
//		view.autoresizesSubviews = YES;
//		self.view = view;
//	}
//}

- (void) _createTableLayout
{
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];

	GtReleaseWithNil(m_layout);
	
	m_layout = [[GtTableViewLayout alloc] initWithCellDataSouce:self];
	
	[self doUpdateDataSourceManager:self.dataSourceManager];
	[self willConstructWithTableLayoutBuilder:[GtTableViewLayoutBuilder tableViewLayoutBuilder:m_layout]];
	GtDrainPool(&pool);
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

//- (void) willShowInHoverViewController:(GtHoverViewController*) controller
//{
//    controller.contentViewSize = self.contentSizeForViewInHoverView;
//
//    if(self.autoResizeHoverView)
//    {
//        controller.contentViewSize = [self autoSizedTableViewFrame].size;
//    }
//    else
//    {
//        controller.contentViewSize = CGSizeMake( 500, MIN(600, self.view.frame.size.height));
//    }
//}

- (void) viewDidLoad
{
    [super viewDidLoad];
	
    GtAssertNotNil(self.tableView);

	GtAssert(self.tableView.style == UITableViewStylePlain, @"TableView must be UITableViewStylePlain");
	GtAssert(self.tableView.separatorStyle == UITableViewCellSeparatorStyleNone, @"TableView.seperatorStyle must be UITableViewCellSeparatorStyleNone");
	
	self.tableView.backgroundColor = [UIColor clearColor];
	self.tableView.cellSeparatorLine = GtTableViewCellSeparatorLineSingleLineEtched;
	self.tableView.drawSectionBorders = YES;
	self.tableView.sectionMargins = DeviceIsPad() ? UIEdgeInsetsMake(0,10.0f,0,10.0f):UIEdgeInsetsMake(0,5.0f,0,5.0f);
	self.tableView.sectionPadding = UIEdgeInsetsMake(10.0f,10.0f,10.0f,10.0f);

	[self _createTableLayout];

//    if(self.autoResizeHoverView)
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
	
	if(m_tabBar)
	{
		m_tabBar.selectedItem = [m_tabBar.items objectAtIndex:0];
	}
	
	GtAssert([self.tableView isKindOfClass:[GtTableView class]], @"TableView needs to be a GtTableView");

    self.contentSizeForViewInHoverView = CGSizeMake( 500, MIN(600, self.view.frame.size.height));
}

- (BOOL) objectWasEdited
{
	return m_editFlags.objectWasEdited;
}

- (void) setObjectWasEdited:(BOOL) wasEdited
{
    m_editFlags.objectWasEdited = YES;

    GtInvokeCallback(m_dataChangedEvent, self);

    if(m_buttonStrategy)
    {
        m_buttonStrategy(self);
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
	GtHoverViewController* popover = self.hoverViewController;
	if(popover)
	{
		popover.contentViewIsModal = self.isModal;
	}
	
}

- (BOOL) isModal
{
	return m_editFlags.isModal;
}

- (void) setIsModal:(BOOL) isModal
{
	m_editFlags.isModal = isModal;
	
	[self updateModalState];
}

- (void) dataSourceManager:(GtDataSourceManager*) dataSource 
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

- (void) dataSourceManager:(GtDataSourceManager*) dataSource 
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
	GtReleaseWithNil(m_tabBar);
	GtReleaseWithNil(m_bottomToolbar);
	GtReleaseWithNil(m_topToolbar);
	GtReleaseWithNil(m_imageView);

	GtTableViewLayout* layout = m_layout;
	m_layout = nil;
	[layout prepareForDestruction];
	GtRelease(layout);
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
	m_dataSourceManager.delegate = nil;
	[self stopEditing];

	[self cleanUpEditableObjectView];
}

- (void)dealloc 
{	
	[self shutDown];
	GtRelease(m_cancelButtonTitle);
	GtRelease(m_saveButtonTitle);
	GtRelease(m_dataSourceManager);
	GtRelease(m_backgroundImage);
	GtSuperDealloc();
}

- (void) showBackgroundImage:(BOOL) show animated:(BOOL) animated
{
	if(m_backgroundImage)
	{
		if(show)
		{
			if(m_imageView)
			{
				[m_imageView removeFromSuperview];
				GtRelease(m_imageView);
			}

			m_imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
			m_imageView.contentMode = UIViewContentModeScaleAspectFit;
			m_imageView.autoresizingMask = UIViewAutoresizingFlexibleEverything;
			m_imageView.backgroundColor = [UIColor clearColor];
			m_imageView.image = m_backgroundImage;
			[self.view insertSubview:m_imageView atIndex:0];
			if(animated)
			{
				[m_imageView animateOntoScreen:GtViewAnimationTypeFade duration:0.3 finishedBlock:nil];
			}
		}
		else
		{
			if(animated)
			{
				[m_imageView removeFromSuperviewWithAnimationType:GtViewAnimationTypeFade duration:0.3 finishedBlock:nil];
			}
			else
			{
				[m_imageView removeFromSuperview];
			}
			GtReleaseWithNil(m_imageView);
		}
	}
	else
	{
		[m_imageView removeFromSuperview];
		GtReleaseWithNil(m_imageView);
	}
}

- (void) hideNavigationController:(BOOL) animated
{
	[self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (GtViewContentsDescriptor) describeViewContents
{
	GtViewContentsDescriptor contents = GtViewContentsDescriptorNone;

	if(self.hoverViewController)
	{
		if(self.navigationController && !self.navigationController.navigationBarHidden)
		{
			contents.top = GtViewContentItemNavigationBar;
		}
		
		if(m_topToolbar && !m_topToolbar.hidden)
		{
			contents.top = GtViewContentItemToolbar;
		}
	}
	else
	{
		if(![UIApplication sharedApplication].statusBarHidden)
		{
			contents.top = GtViewContentItemStatusBar;
		}

		if(self.navigationController && !self.navigationController.navigationBarHidden)
		{
			contents.top = GtViewContentItemNavigationBarAndStatusBar;
		}
		
		if(m_topToolbar && !m_topToolbar.hidden)
		{
			contents.top = GtViewContentItemToolbarAndStatusBar;
		}
	}
	
	if(m_tabBar && !m_tabBar.hidden)
	{
		contents.bottom = GtViewContentItemTabBar;
	}
	
	if(m_bottomToolbar && !m_bottomToolbar.hidden)
	{
		contents.bottom = GtViewContentItemToolbar;
	}
	
	return contents;
}

- (void) willConstructWithTableLayoutBuilder:(GtTableViewLayoutBuilder*) builder
{

}

- (void) doUpdateDataSourceManager:(GtDataSourceManager*) dataSourceManager
{

}

- (void) doBeginLoadingObject
{
	[self onDoneLoadingEditableData];
}

- (void) beginLoadingEditableData
{
	self.loaded = NO;
	m_editFlags.isLoadingEditableData = YES;
	m_editFlags.initialLoadCompleted = NO;
	
	if(self.requiresNetworkToEdit)
	{
		m_editFlags.loadingNetworkData = [GtNetworkStatusMonitor instance].networkIsReachable;
	}
	
	[self setButtonsEnabled:NO];
	if(m_buttonStrategy)
	{
		m_buttonStrategy(self);
	}

	[self doBeginLoadingObject];
}

- (void) buttonClickForHelpButton:(id) sender
{
	GtHtmlHelpViewController* helpView = [[GtHtmlHelpViewController alloc] initWithButtonMode:GtWebViewControllerButtonModeNone];
	helpView.fileName = self.helpFileName;
	[self.navigationController pushViewController:helpView animated:YES];
	GtReleaseWithNil(helpView);
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
	
	if(GtStringIsNotEmpty(self.helpFileName) && self.buttonbar)
	{	
		[self.buttonbar addViewToRightSide:
			[GtButtonbarView createImageButtonByName:@"help-white.png" target:self action:@selector(buttonClickForHelpButton:)] forKey:@"help" animated:NO];
	}
	
	if(!self.loaded)
	{
		[self beginLoadingEditableData];
	}
	
	[self.tableView reloadData];
	
	[self.view setNeedsLayout];
	
	if(m_buttonStrategy)
	{
		m_buttonStrategy(self);
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
	if(self.requiresNetworkToEdit && m_editFlags.loadingNetworkData)
	{
		m_editFlags.loadingNetworkData = NO;
		m_editFlags.loadedNetworkData = YES;
	}

	m_editFlags.isLoadingEditableData = NO;
	m_editFlags.initialLoadCompleted = YES;
	self.loaded = YES;
	[self setButtonsEnabled:YES];
	
	if(m_buttonStrategy)
	{
		m_buttonStrategy(self);
	}

	if(self.autoResizeHoverView)
	{
        GtHoverViewController* controller = self.hoverViewController;
        if(controller && [self.navigationController rootViewController] == self)
        {   
            [controller setContentViewSize:[self autoSizedTableViewFrame].size animated:NO];
        }
	}

	[self.tableView reloadData];
}

- (void) didBeginEditingText
{
	if(m_buttonStrategy)
	{
		m_buttonStrategy(self);
	}
}

- (void) didStopEditing
{
	if(m_buttonStrategy)
	{
		m_buttonStrategy(self);
	}
	[self setEditing:NO animated:YES];
}

- (void) onDoneEditing:(id) sender
{
	[self stopEditing];
	if(m_buttonStrategy)
	{
		m_buttonStrategy(self);
	}
	[self.tableView reloadData];
}

- (IBAction) startEditing:(id) sender
{
	[self setEditing:YES animated:YES];
	
	if(m_buttonStrategy)
	{
		m_buttonStrategy(self);
	}
			
	[self.tableView reloadData];
}

- (void) setButtonsEnabled:(BOOL) enabled
{
	if(m_bottomToolbar)
	{
	   [m_bottomToolbar setAllItemsEnabled:enabled];
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

- (void) onBeginCancel
{
	[self stopEditing];
	[self onCancelComplete];
}

- (void) onCancelComplete
{
	GtReturnAutoreleased(GtRetain(self));
    [self dismissViewControllerAnimated:YES];
    
//	GtInvokeCallback(self.dismissEvent, self);
}

- (void) displayCancelAlert:(SEL) cancelAction
{
	GtAlertView* alert = [[GtAlertView alloc] initWithTitle:NSLocalizedString(@"Are you sure?", nil)
			message:NSLocalizedString(@"Your changes will not be saved.", nil)
			cancelButtonCallback:[GtAlertButtonCallback alertButtonCallback:NSLocalizedString(@"No", nil)]
			otherButtonCallbacks:[GtAlertButtonCallback alertButtonCallback:NSLocalizedString(@"Yes", nil) target:self action:cancelAction], nil];
	
	[alert show];
	
	GtReleaseWithNil(alert);
}

- (void) confirmCancel
{	
	if(self.objectWasEdited && self.willConfirmCancelIfChanged)
	{
		[self displayCancelAlert:@selector(onBeginCancel)];
	}
	else
	{
		[self onBeginCancel];
	}
}

- (IBAction) respondToCancelButton:(id) sender
{
	[self confirmCancel];
}

- (void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
	GtEditObjectTableViewCell* row = [self.tableLayout.currentTab cellForIndexPath:indexPath];
	GtAssertNotNil(row);
	if(row)
    {
        row.viewController = self;
        GtInvokeCallback(row.accessoryWasTappedCallback, row);
    }
}

- (id) tableViewCellGetCellData:(GtEditObjectTableViewCell*) cell
{
	return [self.dataSourceManager objectForKeyPath:cell.dataKeyPath];
}

- (void) tableViewCell:(GtEditObjectTableViewCell*) cell setCellData:(id) object
{
	[self.dataSourceManager setObject:object forKeyPath:cell.dataKeyPath fireDataChangedEvent:YES];
}

- (GtTextEditCell*) textEditCellGetNextEditableCell:(GtTextEditCell*) cell;
{
	return [[self.tableLayout rowForRowKey:cell.rowKey].parentSection findNextCellToEdit:cell];
}

- (GtTextEditCell*) textEditCellGetPreviousEditableCell:(GtTextEditCell*) cell;
{
	return [[self.tableLayout rowForRowKey:cell.rowKey].parentSection findPrevCellToEdit:cell];
}

- (void) updateCellStateForRow:(GtEditObjectTableViewCell*) row indexPath:(NSIndexPath*) indexPath
{
	GtAssertNotNil(row);
	[row applyTheme];

	if([row isKindOfClass:[GtEditObjectTableViewCell class]])
	{
		GtEditObjectTableViewCell* tableViewCell = (GtEditObjectTableViewCell*) row;

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
		GtLog(@"%@ unknown cell", NSStringFromClass([row class]));
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	GtAssertNotNil(m_layout);

	GtEditObjectTableViewCell* cell = [self.tableLayout.currentTab cellForIndexPath:indexPath];
	GtAssertNotNil(cell);

    if(cell)
    {
        cell.viewController = self;
        cell.shouldIndentWhileEditing = NO;

        [self setDelegateForCellIfTextEditCell:cell];
	
        GtInvokeCallback(cell.willReloadCallback, cell);
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
	NSInteger count = MAX(1, (int) (m_layout == nil ? 1 : [self.tableLayout.currentTab sectionCount]));
	return count;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	if(!m_layout)
	{
		return 0;
	}

	GtTableViewSection* group = [[self.tableLayout currentTab] sectionAtIndex:section];
	GtAssertNotNil(group);
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
	GtAssertNotNil(m_layout);

	GtEditObjectTableViewCell* row = [self.tableLayout.currentTab cellForIndexPath:indexPath];
	GtAssertNotNil(row);
	GtAssertNotNil(row);	
	[self updateCellStateForRow:row indexPath:indexPath];
	
	CGFloat height = 0;
	if([row respondsToSelector:@selector(cellHeight)])
	{
		height = [row cellHeight];
	}
	
	return height == 0 ? self.tableView.rowHeight : height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
	GtTableViewSection* section = [[self.tableLayout currentTab] sectionAtIndex:sectionIndex];
	UIView* headerView = section.headerView;
	if(section.headerHeight)
	{
		headerView.frameOptimizedForSize = GtRectSetHeight(headerView.frame, MAX(section.headerHeight, section.headerView.minHeight));
	}
	else
	{
		headerView.frameOptimizedForSize = GtRectSetHeight(headerView.frame, MAX(tableView.sectionHeaderHeight, section.headerView.minHeight));
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
- (void) truncateEditedTextForDataRow:(GtEditObjectTableViewCell*) dataRow 
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

- (void) doFinalizeDataInDataRow:(GtEditObjectTableViewCell*) dataRow
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
//			  GtTableViewTab* tab = [self.tableLayout tabWithIndex:i];
//			  for(NSUInteger j = 0; j < tab.sectionCount; j++)
//			  {
//				  GtTableViewSection* group = [tab sectionAtIndex:j];
//				  
//				  for(NSUInteger y = 0; y < group.rowCount; y++)
//				  {
//					  GtEditObjectTableViewCell* row = [group rowAtIndex:y];
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
//		  GtDrainPoolAndRethrow(&pool, ex);
//	  }
//	  @finally
//	  {
//		  GtDrainPool(&pool);
//	  }
//	  
}

- (void) _beginEditingTextWithRowKey:(NSString*) rowKey
{
	[self beginEditingTextInCell:(GtTextEditCell*) [self cellForRowKey:rowKey]];
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
	if(self.requiresNetworkToEdit && ![GtNetworkStatusMonitor instance].networkIsReachable)
	{
		GtUserNotificationView* view = [[GtUserNotificationView alloc] initAsErrorNotification];;
		view.title = NSLocalizedString(@"Unable to save changes.", nil);
		view.text = NSLocalizedString(@"Please try again when you have a network connection.", nil);
		[view showNotification];
		GtReleaseWithNil(view);
	}
	else if([self willBeginSavingChanges])
	{
		[self stopEditing];
	
		[self finalizeDataBeforeCommit];
	
		m_editFlags.isSavingEditableData = YES;
		[self setButtonsEnabled:NO];
		
		if(!GtInvokeCallback(m_beginSaveCallback, self))
		{
			[self doBeginSavingChanges];
		}
	}
}

- (void) didFinishSavingChanges:(BOOL) dismissViewController
{
	m_editFlags.isSavingEditableData = NO;
	
	if(dismissViewController)
	{
        [self dismissViewControllerAnimated:YES];
    
//		GtInvokeCallback(self.dismissEvent, self);
	}
	else
	{
		[self setButtonsEnabled:YES];
	}
}

- (void) _showOfflineEditingAlert
{
	GtUserNotificationView* view = [[GtUserNotificationView alloc] initAsWarningNotification];
	view.title = NSLocalizedString(@"A network connection is required for editing.", nil);
	view.shouldAutoCloseAfterDelay = YES;
	
	[view showNotification];
	GtReleaseWithNil(view);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	if(self.requiresNetworkToEdit && !m_editFlags.loadedNetworkData)
	{
		GtEditObjectTableViewCell* row = [self.tableLayout.currentTab cellForIndexPath:indexPath];
		GtAssertNotNil(row);
		
        if(row)
        {
            BOOL canEdit = NO;
            
            GtInvokeCallback(row.wasSelectedCallback, row);
            
            if([row isKindOfClass:[GtTextEditCell class]])
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
		GtEditObjectTableViewCell* row = [self.tableLayout.currentTab cellForIndexPath:indexPath];
		GtAssertNotNil(row);
		
        if(row && ![row disabled])
		{
            GtInvokeCallback(row.wasSelectedCallback, row);
        	
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

//- (NSIndexPath*) indexPathForCell:(GtEditObjectTableViewCell*) cell
//{
//	return [self.tableLayout.currentTab indexPathForCell:cell];
//}

- (GtEditObjectTableViewCell*) tableViewCell:(UITableViewCell*) cell rowInfoForKey:(id) key
{
	return [m_layout.currentTab rowForRowKey:key];
}

//- (id) dataToEdit
//{
//	  return [self.dataSourceManager dataSourceForDataSourceKey:self.dataToEditKey];
//}

//- (id) dataToEditKey
//{
//	  return m_saveKey;
//}

//- (void) setDataToEdit:(id) data 
//	  forKey:(id) key 
//	  saveToDataSource:(GtDataSourceManager*) saveToDataSourceManager
//{
//	  GtAssignObject(m_saveKey, key);
//	  GtAssignObject(m_saveToDataSourceManager, saveToDataSourceManager);
//	  
//	  if([data conformsToProtocol:@protocol(NSMutableCopying)])
//	  {
//		  [self.dataSourceManager setDataSource:GtReturnAutoreleased([data mutableCopy]) forKey:key];
//	  }
//	  else if([data conformsToProtocol:@protocol(NSCopying)])
//	  {
//		  [self.dataSourceManager setDataSource:GtReturnAutoreleased([data copy]) forKey:key];
//	  }
//	  else
//	  {
//		  [self.dataSourceManager setDataSource:GtReturnAutoreleased([data copy]) forKey:key];
//	  }
//}

- (void) networkDidBecomeUnavailable
{
	if(self.requiresNetworkToEdit)
	{
		GtUserNotificationViewController* view = [GtUserNotificationViewController userNotificationViewController:[[[GtUserNotificationView alloc] initAsInfoNotification] autorelease]];
        
		view.userNotificationView.title = NSLocalizedString(@"Network connection is unavailable.", nil);
		view.userNotificationView.text = NSLocalizedString(@"A network connection is required to save changes.", nil);
		view.autoLayoutMode = GtRectLayoutMake(GtRectLayoutHorizontalCentered, GtRectLayoutVerticalTop);
		[view showNotification];
	}
	
	[super networkDidBecomeUnavailable];
}

- (void) networkDidBecomeAvailable
{
	[super networkDidBecomeAvailable];
	
	if(self.requiresNetworkToEdit && !m_editFlags.loadedNetworkData)
	{
		m_editFlags.loadingNetworkData = YES;
		[self beginLoadingEditableData];
	}
}

- (BOOL)textEditCellDoStartEditing:(GtTextEditCell *)cell
{
	if(self.requiresNetworkToEdit)
	{	
		if(m_editFlags.loadedNetworkData)
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

- (GtButton*) cancelButton
{
	return (GtButton*) [self.buttonbar viewForKey:@"cancel"];
}

- (GtButton*) saveButton
{
	return (GtButton*) [self.buttonbar viewForKey:@"save"];
}


@end

#import "GtGradientButton.h"
#import "GtNavigationController.h"

void GtEditObjectViewControllerShowCancelButtonOnly(GtEditObjectViewController* controller)
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
			[controller.buttonbar addButtonToLeftSide:[GtToolbarButton toolbarButton:NSLocalizedString(@"Cancel", nil)
			 target:controller action:@selector(respondToCancelButton:)] forKey:@"cancel" animated:NO];
		}
	}
}

void GtEditObjectViewControllerShowBackButtonOnly(GtEditObjectViewController* controller)
{
	if(controller.view.superview)
	{
		controller.willConfirmCancelIfChanged = NO;

		if(controller.navigationController.rootViewController == controller)
		{
			controller.buttonbar.backButtonHidden = YES;
		
			if(!controller.cancelButton)
			{
				[controller.buttonbar addButtonToLeftSide:[GtToolbarButton toolbarButton:NSLocalizedString(@"Cancel", nil)
				 target:controller action:@selector(respondToCancelButton:)] forKey:@"cancel" animated:NO];
			}
		}
	}
}

void GtEditObjectViewControllerShowNoButtons(GtEditObjectViewController* controller)
{
	if(controller.view.superview)
	{
		[controller.buttonbar setBackButtonHidden:YES animated:NO];
	}
}

void GtEditObjectViewControllerShowButtonsWhenEdited(GtEditObjectViewController* controller)
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
					[controller.buttonbar addButtonToLeftSide:[GtToolbarButton toolbarButton:controller.cancelButtonTitle
					 target:controller action:@selector(respondToCancelButton:)] forKey:@"cancel" animated:YES];
				}
				else
				{
					[controller.buttonbar addButtonToLeftSide:[GtBackButton backButton:controller.cancelButtonTitle
					 target:controller action:@selector(respondToCancelButton:)] forKey:@"cancel" animated:YES];
				}
			}

			if(!controller.saveButton)
			{
				[controller.buttonbar addButtonToRightSide:[GtToolbarButton toolbarButton:GtButtonColorBrightBlue title:controller.saveButtonTitle
				 target:controller action:@selector(respondToSaveButton:)] forKey:@"save" animated:YES];
			}
		}
		else 
		{
			if(controller.navigationController.rootViewController == controller)
			{
				if(!controller.cancelButton)
				{
					[controller.buttonbar addButtonToLeftSide:[GtToolbarButton toolbarButton:NSLocalizedString(@"Cancel", nil)
						target:controller action:@selector(respondToCancelButton:)] forKey:@"cancel" animated:NO];
				
				}
			}
		}
	}
}

void GtEditObjectViewControllerShowButtonsImmediately(GtEditObjectViewController* controller)
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
				[controller.buttonbar addButtonToLeftSide:[GtToolbarButton toolbarButton:controller.cancelButtonTitle
				 target:controller action:@selector(respondToCancelButton:)] forKey:@"cancel" animated:NO];
			}
			else
			{
				[controller.buttonbar addButtonToLeftSide:[GtBackButton backButton:controller.cancelButtonTitle
				 target:controller action:@selector(respondToCancelButton:)] forKey:@"cancel" animated:NO];
			}
		}
		
		if(!controller.saveButton)
		{
			[controller.buttonbar addButtonToRightSide:[GtToolbarButton toolbarButton:GtButtonColorBrightBlue title:controller.saveButtonTitle
			 target:controller action:@selector(respondToSaveButton:)] forKey:@"save" animated:NO];
		}
	}
}

