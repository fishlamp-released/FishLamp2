//
//  EditableItemsBaseViewController.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/4/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#if IPHONE

#import "GtEditableObjectView.h"
#import "GtObjectEditHandler.h"


#import "GtEditPanel.h"
#import "GtDisplayDataGroup.h"
#import "GtAlertDelegate.h"
#import "GtDisplayDataBinding.h"
#import "GtColors.h"
#import "GtGeometry.h"
#import "GtViewFader.h"
#import "GtAscendingTabView.h"
#import "GtImageView.h"

@implementation GtEditableObjectView

GtSynthesizeStructProperty(editingMode, setEditingMode, GtEditingMode, m_editFlags);
GtSynthesizeStructProperty(loaded, setLoaded, BOOL, m_editFlags);
GtSynthesizeStructProperty(updated, setUpdated, BOOL, m_editFlags);
GtSynthesizeStructProperty(transparent, setTransparent, BOOL, m_editFlags);
GtSynthesizeStructProperty(wantsSaveButton, setWantsSaveButton, BOOL, m_editFlags);
GtSynthesizeStructProperty(wantsEditButton, setWantsEditButton, BOOL, m_editFlags);
GtSynthesizeStructProperty(saveButtonState, setSaveButtonState, GtSaveButtonState, m_editFlags);

@synthesize backgroundImage = m_backgroundImage;
@synthesize editableObjectViewDelegate = m_editableObjectViewDelegate;

@synthesize tableView = m_tableView;
@synthesize tabBar = m_tabBar;
@synthesize tableOpacity = m_tableOpacity;
@synthesize cellOpacity = m_cellOpacity;

@synthesize rootNavigationController = m_rootNavigationController;

GtSynthesize(editHandler, setEditHandler, GtObjectEditHandler, m_handler)
GtSynthesizeID(editableData, setEditableData);
GtSynthesizeIDWithProtocol(viewAnimator, setViewAnimator, GtViewAnimatorProtocol);

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
//	[[UIApplication sharedApplication] setStatusBarHidden:YES animated:NO];
	if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
	{
		m_handler = [GtAlloc(GtObjectEditHandler) init];
		
        self.wantsEditButton = NO;
        self.wantsSaveButton = YES;
		
		self.wantsFullScreenLayout = YES;
        
        self.viewAnimator = [GtDefaultViewAnimator defaultViewAnimator];
        
        self.tableOpacity = .85;
        self.cellOpacity = 1;
    }
	
	return self;
}

- (void) createRootNavigationController:(UIBarStyle) style
{
   [self releaseRootNavigationController];
    
    m_rootNavigationController = [GtAlloc(UINavigationController) initWithRootViewController:self];
    m_rootNavigationController.navigationBar.barStyle = style;
}

- (void) releaseRootNavigationController
{
    if(m_rootNavigationController)
    {
        [m_rootNavigationController autorelease];
        m_rootNavigationController = nil; 
    }
}

- (void) onAddRowsToEditHandler:(GtObjectEditHandler*) handler
{
}

- (void) cleanUpEditableObjectView
{
	[m_handler releaseCachedCells];

	GtReleaseWithNil(m_leftButton);
	GtReleaseWithNil(m_rightButton);
	GtReleaseWithNil(m_tableView);
	GtReleaseWithNil(m_tabBar);
	GtReleaseWithNil(m_bottomToolbar);
	GtReleaseWithNil(m_textEditCellManager);
	GtReleaseWithNil(m_topToolbar);
	GtReleaseWithNil(m_imageView);
}

- (void) shutDown
{
/*  this destroys stuff in a way that prevents delegates
    and views from calling back into us and crashing us 
    after we're gone */
    
    m_tableView.delegate = nil;
	m_tableView.dataSource = nil;

	[m_textEditCellManager cancelEditing];
    GtReleaseWithNil(m_textEditCellManager);
    
    GtReleaseWithNil(m_handler);
    [m_tableView reloadData]; // clears out the table

    [self cleanUpEditableObjectView];
    
    [self releaseRootNavigationController];
}

- (void)dealloc 
{	
    GtRelease(m_editableData);
    GtReleaseWithNil(m_viewAnimator);

	[self shutDown];
    GtRelease(m_backgroundImage);
	[super dealloc];
}

- (void) displayBackgroundImage:(BOOL) fadeIn
{
	CATransition* anim = nil;
		
	if(fadeIn)
	{
		anim = [CATransition animation];
		anim.timingFunction = UIViewAnimationCurveEaseInOut;
		anim.type = kCATransitionFade; 
		anim.duration = GtFadeDuration;
		[self.view.layer addAnimation:anim forKey:@"myAnim"];
	}

	if(m_backgroundImage)
	{
		self.view.backgroundColor = [UIColor almostBlackGrayColor];
		
		if(!m_imageView)
		{
			m_imageView = [GtAlloc(GtImageView) initWithFrame:self.view.frame];
			[self.view insertSubview:m_imageView atIndex:0];
		}
		
		m_imageView.image = m_backgroundImage;
		m_tableView.alpha = self.tableOpacity;
		m_tableView.opaque = NO;
	}
	else
	{
		[m_imageView removeFromSuperview];
		GtReleaseWithNil(m_imageView);
	
		self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	
		m_tableView.alpha = 1.0;
		m_tableView.opaque = YES;
	}
	
	if(fadeIn)
	{
		[self.view.layer removeAnimationForKey:@"myAnim"];
	}

}

- (void) setBackgroundImage:(UIImage*) image  fadeIn:(BOOL) fadeIn
{
	if(m_backgroundImage != image)
	{
		GtRelease(m_backgroundImage);
		m_backgroundImage = [image retain];
	}	
	
	[self displayBackgroundImage: fadeIn];
}

- (void) loadView
{
	[self onAddRowsToEditHandler:m_handler];
	[super loadView];
}

- (BOOL) textEditCellManager:(GtTextEditCellManager*) manager doScrollCellIntoViewOnEdit:(UITableViewCell*) cell
{
	return YES;
}

- (NSIndexPath*) textEditCellManager:(GtTextEditCellManager*) manager indexPathForRowId:(id) rowId;
{
	return [m_handler indexPathForRowId:rowId];
}

- (id) textEditCellManager:(GtTextEditCellManager*) manager cellForIndexPath:(NSIndexPath*) indexPath
{
	return [m_handler cellForRowAtIndexPath:indexPath];
}

- (void) textEditCellManager:(GtTextEditCellManager*) manager didBeginEditingCell:(GtTextEditCell *)cell
{
	self.updated = YES;
}

- (void) textEditCellManager:(GtTextEditCellManager*) manager didEndEditingCell:(GtTextEditCell *)cell
{
}

- (void) configureTransparentCell:(GtTableViewCell*) cell 
{
	if(self.transparent)
	{
		cell.alpha = self.cellOpacity; 
		cell.opaque = NO;
	}
}

- (void) setTableViewFrame
{
	CGRect tableViewFrame = self.view.bounds;
	
    tableViewFrame.origin.y = GtStatusBarHeight;
    tableViewFrame.size.height -= GtStatusBarHeight;
    
	if(self.navigationController)
	{
        int delta = (GtNavigationBarHeight + GtStatusBarHeight)  - tableViewFrame.origin.y;
        if(delta != 0)
        {
            tableViewFrame.origin.y += delta;
            tableViewFrame.size.height -= delta;
        }
    }
	
	if(m_topToolbar)
	{
        int delta = (GtToolBarHeight + GtStatusBarHeight)  - tableViewFrame.origin.y;
        if(delta != 0)
        {
            tableViewFrame.origin.y += delta;
            tableViewFrame.size.height -= delta;
        }
    
		tableViewFrame.origin.y += delta;
		tableViewFrame.size.height -= delta;
		m_topToolbar.alpha = 1.0;
	}
	
	if(m_tabBar)
	{
		m_tabBar.alpha = 1.0;
		tableViewFrame.size.height -= GtTabBarHeight;
	}
	
	if(m_bottomToolbar)
	{
		tableViewFrame.size.height -= GtToolBarHeight;
		m_bottomToolbar.alpha = 1.0;
	}
	
	m_tableView.frame = tableViewFrame;
}

- (void) viewDidLoad
{
	GtAssert(m_tableView != nil, @"table view is nil - set in interface builder");
	
    m_tableView.dataSource = self;
    m_tableView.delegate = self;
    
    [super viewDidLoad];
	
	if(m_tabBar)
	{
		m_tabBar.selectedItem = [m_tabBar.items objectAtIndex:0];
	}
	
	m_tableView.backgroundColor = [UIColor clearColor];

	m_textEditCellManager = [GtAlloc(GtTextEditCellManager) initWithTableView:m_tableView];
	m_textEditCellManager.delegate = self;
	
	[self setTableViewFrame];

	[self displayBackgroundImage:YES];
			
	self.editingMode = GtEditingModeLoading;
	[m_tableView reloadData];

	[self updateButtons:NO];
	[self beginLoadingEditableData];
}

- (void) viewDidUnload
{
	[super viewDidUnload];
	[self cleanUpEditableObjectView];
}

- (void) beginLoadingEditableData
{
	[self onDoneLoadingEditableData];
}

- (void) onDoneLoadingEditableData
{
	self.loaded = YES;
	[self setEditing:YES animated:YES];
	[self updateButtons:YES];
	[m_tableView reloadData];
}

- (void) setCancelButton:(BOOL) animate
{
	UINavigationItem* item = self.navigationItem;
	if([self isEditing])
	{
		/*
		if(item.leftBarButtonItem.style != UIBarButtonSystemItemCancel)
		{
			[item setLeftBarButtonItem:
				[[GtAlloc(UIBarButtonItem) initWithBarButtonSystemItem:UIBarButtonSystemItemCancel 
					target:self action:@selector(shouldWeCancel:)] autorelease]
					animated:animate];
		}
		*/
	}
	else if(!self.loaded && (self.wantsEditButton || self.wantsSaveButton))
	{
		[item setLeftBarButtonItem:
			[[GtAlloc(UIBarButtonItem) initWithBarButtonSystemItem:UIBarButtonSystemItemCancel 
				target:self action:@selector(leftButton:)] autorelease]
				animated:animate];
	}
	else
	{
		[item setLeftBarButtonItem:
			[[GtAlloc(UIBarButtonItem) initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
				target:self action:@selector(leftButton:)] autorelease]
				animated:animate];
	}
}

- (void) textEditCellManagerDidStartEditing:(GtTextEditCellManager*) manager
{
    [self updateButtons:YES];
}

- (void) textEditCellManagerDidEndEditing:(GtTextEditCellManager*) manager
{
    [self updateButtons:YES];
}

- (void) onDoneEditing:(id) sender
{
    [m_textEditCellManager stopEditing];
    [self updateButtons:YES];
}

- (void) getSaveButtonForState:(GtSaveButtonState) state 
                     outButton:(UIBarButtonItem**) outButton
                        action:(SEL) action
{
    switch(state)
    {
        case GtSaveButtonStateSave:
             *outButton = [GtAlloc(UIBarButtonItem) initWithBarButtonSystemItem:UIBarButtonSystemItemSave 
                            target:self action:action];
        break;
        
        
        case GtSaveButtonStateDoneEditingText:
            *outButton = [GtAlloc(UIBarButtonItem) initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
                            target:self action:action];
        break;
        
        
        case GtSaveButtonStateEdit:
        
            *outButton = [GtAlloc(UIBarButtonItem) initWithBarButtonSystemItem:UIBarButtonSystemItemEdit 
						target:self action:action];
        break;
    
    
    }
}


- (void) setSaveButton:(BOOL) animate
{
	UINavigationItem* item = self.navigationItem;
	UIBarButtonItem* button = nil;
    
    if([self isEditing] && self.wantsSaveButton)
    {
        if(m_editFlags.saveButtonState != GtSaveButtonStateSave)
        {
            [self getSaveButtonForState:GtSaveButtonStateSave 
                              outButton:&button
                                 action:@selector(beginCommit:)];
                                 
            [item setRightBarButtonItem:button animated:animate];
     
             m_editFlags.saveButtonState = GtSaveButtonStateSave;
        }
    
    }
    else if(![self isEditing] && self.wantsEditButton && m_handler && m_handler.hasEditableRows)
    {
        if(m_editFlags.saveButtonState != GtSaveButtonStateEdit)
        {
            [self getSaveButtonForState:GtSaveButtonStateEdit 
                              outButton:&button
                                 action:@selector(rightButton:)];
                                 
            [item setRightBarButtonItem:button animated:animate];
            m_editFlags.saveButtonState = GtSaveButtonStateEdit;
        }
    }
    else
	{
		[item setRightBarButtonItem:nil animated:animate];
        m_editFlags.saveButtonState = GtSaveButtonStateNone;
	}
	
    GtRelease(button);
}


- (void) updateButtons:(BOOL) animate
{
	[self setCancelButton:animate];
	[self setSaveButton:animate];
}

- (void) cancelEditing
{
	[m_textEditCellManager cancelEditing];
		
	if(	m_editableObjectViewDelegate && 
		[m_editableObjectViewDelegate respondsToSelector:@selector(editableObjectViewDataEditingCancelled:)])
	{
		[m_editableObjectViewDelegate editableObjectViewDataEditingCancelled:self];
	}
}

- (void) onShowSelf:(UIView*) superview
{
    UIView* viewToAdd = m_rootNavigationController ? m_rootNavigationController.view : self.view;

    [m_viewAnimator addSubview:viewToAdd superview:superview];
}

- (void) show:(UIView*) superview
{
    [self onShowSelf:superview];
}

- (void) hide
{
    @try
    {
        [self retain];
        [self onHideSelf];
        [self shutDown];
    }
    @finally
    {
        [self autorelease];
    }
}

- (void) onHideSelf
{
    UIView* viewToRemove = m_rootNavigationController ? m_rootNavigationController.view : self.view;
    [m_viewAnimator removeFromSuperview:viewToRemove]; 
} 

- (void) onBeginCancel
{
	[self cancelEditing];
	[self onCancelComplete];
}

- (void) onCancelComplete
{
	[self hide];
}

- (IBAction) leftButton:(id) sender
{
	[self onBeginCancel];
}

- (IBAction) rightButton:(id) sender
{
	[self setEditing:YES animated:YES];
	
	[self updateButtons:YES];
			
	[m_tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	GtAssertNotNil(m_handler);

	GtDisplayDataRow* row = [m_handler rowForPath:indexPath];
	
	UITableViewCell* cell = row.cell;
	
	GtAssertNotNil(row);
	GtAssertNotNil(cell);

	BOOL hasPanel = self.loaded && ([self isEditing]  && row.panelClass != nil);

	cell.accessoryType = hasPanel ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
	cell.selectionStyle = hasPanel ? UITableViewCellSelectionStyleBlue: UITableViewCellSelectionStyleNone;
	cell.shouldIndentWhileEditing = NO;

	RunOnlyOnSdkVersion3
	{ 
		cell.accessoryType = hasPanel ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
	}

#if FISHLAMP_IPHONE_2_SDK
	DontRunOnSdkVersion3
	{ 
		cell.hidesAccessoryWhenEditing = NO;
	}
#endif
	
	[m_textEditCellManager setDelegateForCellIfTextEditCell:cell];
  	
	if([cell isKindOfClass:[GtTableViewCell class]])
	{		
		[((GtTableViewCell*) cell) setRowData:row isLoaded:self.loaded];
	}
	
	if(row.cellConfigureAction)
	{
		[self performSelector:row.cellConfigureAction withObject:cell];
	}
	
	return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellEditingStyleNone; 
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
	NSInteger count = m_handler == nil ? 1 : [m_handler groupCount];
    return count == 0 ? 1 : count;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	if(!m_handler)
	{
		return 0;
	}

	GtDisplayDataGroup* group = [m_handler groupAtIndex:section];
	return [group rowCount];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(!self.loaded)
	{
		return nil;
	}
	
	return indexPath;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	GtAssertNotNil(m_handler);

	GtDisplayDataRow* row = [m_handler rowForPath:indexPath];
	
    CGFloat outValue = 0;
	if([row.cell isKindOfClass:[GtTableViewCell class]])
	{
        [((GtTableViewCell*) row.cell) setRowData:row isLoaded:self.loaded];
	
        outValue = [((GtTableViewCell*) row.cell) cellHeight];
	}
	
	return outValue == 0 ? GT_DEFAULT_CELL_HEIGHT : outValue;
}

#define kHeaderHeight 20.0
#define kHeaderPadding 20.0
#define kHeaderViewHeight 20.0

#define kTopSection 10.0
#define kOtherSections 2.0

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	GtDisplayDataGroup* group = [m_handler groupAtIndex:section];
	if(group.title)
	{
		return kHeaderViewHeight;
	}
	else
	{
		return section == 0 ? kTopSection : kOtherSections;
	}
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	GtDisplayDataGroup* group = [m_handler groupAtIndex:section];
	if(group.title && group.title.length > 0)
	{//tableView.bounds.size.width
		CGRect headerViewFrame = CGRectMake(0,0, 320, kHeaderViewHeight);
	
		UIView* headerView = [[GtAlloc(UIView) initWithFrame:headerViewFrame] autorelease];
		headerView.autoresizingMask = UIViewAutoresizingNone;
		headerView.backgroundColor = [UIColor clearColor];
	
		GtAscendingTabView* tab = [GtAlloc(GtAscendingTabView) init];
		tab.line1.text = group.title;
		[headerView addSubview:tab];
		GtRelease(tab);
/*	
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectInset(headerViewFrame, 20, 0)];
		label.text = group.title;
		label.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
		label.textColor = [UIColor blueLabelColor];
		label.backgroundColor = [UIColor clearColor];
	//	label.shadowColor = [UIColor  whiteColor];
		
		[headerView addSubview:label];
		GtRelease(label);
*/
		return headerView;
	}
	else
	{
		CGRect headerViewFrame = CGRectMake(0,0,tableView.bounds.size.width, section == 0 ? kTopSection : kOtherSections);
	
		UIView* headerView = [[GtAlloc(UIView) initWithFrame:headerViewFrame] autorelease];
		headerView.backgroundColor = [UIColor clearColor];

		return headerView;
	}
	
	return nil;
}

- (NSString*) cancelMessage
{
	return @"Your changes will not be saved.";
}

#define OK_BUTTON 1

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex == OK_BUTTON)
	{
		[self onBeginCancel];
	}
}

- (IBAction) shouldWeCancel:(id) sender
{	
	if(self.updated)
	{
		UIAlertView* alert = [GtAlloc(UIAlertView) initWithTitle:NSLocalizedStringFromTable(@"GT_ARE_YOU_SURE_STR", @"FishLamp", nil)
				message:[self cancelMessage] 
				delegate:self 
				cancelButtonTitle:NSLocalizedStringFromTable(@"GT_NO_STR", @"FishLamp", nil) 
				otherButtonTitles:NSLocalizedStringFromTable(@"GT_YES_STR", @"FishLamp", nil), nil];
		
		[alert show];
		
		GtRelease(alert);
	}
	else
	{
		[self onBeginCancel];
	}
}

- (void) onRowWasEditedWithEditPanel:(id<GtEditPanelProtocol>) panel 
    row:(GtDisplayDataRow*) row
    newData:(id) newData
{
    row.data = newData;
}

- (void) editPanel:(id<GtEditPanelProtocol>) panel 
	itemUpdated:(GtDisplayDataRow*) row 
    newData:(id) newData
	atIndexPath:(NSIndexPath*) indexPath
{
    self.updated = YES;
	[self onRowWasEditedWithEditPanel:panel row:row newData:newData];
	[m_tableView reloadData];
}

- (void) editPanel:(id<GtEditPanelProtocol>) panel cancelledAtPath:(NSIndexPath*) indexPath
{
	[m_tableView deselectRowAtIndexPath:[m_tableView indexPathForSelectedRow] animated:NO];
}

- (BOOL) shouldCommitDisplayDataRow:(GtDisplayDataRow*) dataRow
    forIndexPath:(NSIndexPath*) path
{
    return YES;
}
    
- (void) truncateEditedTextForDataRow:(GtDisplayDataRow*) dataRow 
    forIndexPath:(NSIndexPath*) path
{
    id data = dataRow.data;
    
    if(data && [data isKindOfClass:[NSString class]])
    {
        NSString* string = data;
        
        if( dataRow.maxDataSize > 0 && 
            string.length > dataRow.maxDataSize)
        {
            dataRow.data = [string substringToIndex:dataRow.maxDataSize];
        }
    }
}

- (BOOL) finalizeDataBeforeCommit
{
    NSAutoreleasePool* pool = [GtAlloc(NSAutoreleasePool) init];

    @try
    {
        for(int i = 0; i < m_handler.groupCount; i++)
        {
            GtDisplayDataGroup* group = [m_handler groupAtIndex:i];
        
            for(int y = 0; y < group.rowCount; y++)
            {
                GtDisplayDataRow* row = [group rowAtIndex:y];
                
                if(row.isEditable)
                {
                    NSIndexPath* path = [NSIndexPath indexPathForRow:y inSection:i];
                
                    if(![self shouldCommitDisplayDataRow:row 
                        forIndexPath:path])
                    {
                        return NO; // ABORT!!
                    }
                
                    [self truncateEditedTextForDataRow:row
                        forIndexPath:path];
                }
            }
        }
    }
    @finally
    {
        GtRelease(pool);
    }
    
    return YES;
}


- (IBAction) beginCommit:(id) sender
{
    [m_textEditCellManager stopEditing];
	
    if([self finalizeDataBeforeCommit])
    {
        self.editingMode = GtEditingModeSaving;
        [self onBeginCommitChanges];
    }
}

- (void) onBeginCommitChanges
{
}

- (void) onChangesCommitted
{
    if(	m_editableObjectViewDelegate && 
		[m_editableObjectViewDelegate respondsToSelector:@selector(editableObjectViewDataEditingCompleted:)])
	{
		[m_editableObjectViewDelegate editableObjectViewDataEditingCompleted:self];
	}
	
	[self hide];
}

- (void) onCommitFailed
{
	[self setEditing:YES animated:NO];
		
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	if(self.loaded) 
	{
		GtDisplayDataRow* row = [m_handler rowForPath:indexPath];
		
		if(row.panelClass)
		{
			
			[m_textEditCellManager stopEditing];
		
			GtEditPanel* panel = [GtAlloc(row.panelClass) initWithDisplayDataRow:row];
			panel.indexPath = indexPath;
			panel.delegate = self;
			if(row.panelConfigureAction)
			{
				[self performSelector:row.panelConfigureAction withObject:panel];
			}

			[self.navigationController pushViewController:panel animated:YES];
			[m_tableView deselectRowAtIndexPath:indexPath animated:NO];
			
			GtRelease(panel);
		}
		else
		{
			id cell = [m_handler cellForRowAtIndexPath:indexPath];
			
			if(![m_textEditCellManager startEditingForRowIfTextEditCell:cell atIndexPath:indexPath])
			{
				[m_tableView reloadData];
			}
		}
	}
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
	m_handler.tab = item.tag;
	[m_handler releaseCachedCells];
	[m_tableView reloadData];
}

- (NSIndexPath*) textEditCellManager:(GtTextEditCellManager*) manager indexPathForCell:(UITableViewCell*) cell
{
	return [m_handler indexPathForCell:cell];
}

- (id) displayDataRow:(GtDisplayDataRow*) row 
		getDataForRow:(id) key
{
    GtAssert(m_editableData != nil, @"No data to edit, set editableData or override this method");

	return [m_editableData objectForKey:key];
}

- (void) displayDataRow:(GtDisplayDataRow*) row 
		  setDataForRow:(id) key 
				   data:(id) data
{
    GtAssert(m_editableData != nil, @"No data to edit, set editableData or override this method");

    [m_editableData setObject:data forKey:key];
}


@end

#endif
