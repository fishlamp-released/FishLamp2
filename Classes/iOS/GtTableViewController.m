//
//	GtTableViewController.m
//	FishLampFishLamp
//
//	Created by Mike Fullerton on 2/1/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTableViewController.h"

#import "GtAction.h"
#import "GtActionContextManager.h"
#import "GtPullToRefreshHeaderView.h"
#import "GtHoverViewController.h"
#import "GtTableViewCell.h"

@implementation GtTableViewController

@synthesize rowHeightCalculator = m_rowHeightCalculator;
@synthesize tableView = m_tableView;

//- (UITableView*) tableView
//{
//    return (UITableView*) self.scrollView;
//}


- (void) cleanupTableViewController
{
	self.tableView.delegate = nil;
	self.tableView.dataSource = nil;
    self.tableView = nil;
}

- (id) dataForRowHeightCalculationAtIndexPath:(NSIndexPath*) path
{
	return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(self.rowHeightCalculator)
	{
		return [self.rowHeightCalculator calculateRowHeightInTableView:self.tableView withData:[self dataForRowHeightCalculationAtIndexPath:indexPath]];
	}

	return [self.tableView rowHeight];
}

- (UIScrollView*) createScrollView
{
	GtTableView* tableView = GtReturnAutoreleased([[GtTableView alloc] initWithFrame:self.view.bounds]);
	tableView.backgroundColor = self.view.backgroundColor;
	tableView.autoresizingMask = UIViewAutoresizingFlexibleEverything;
	tableView.autoresizesSubviews = YES;
	tableView.delegate = self;
	tableView.dataSource = self;
    return tableView;
}

- (void) dealloc
{
	[self cleanupTableViewController];

	GtSuperDealloc();
}

- (BOOL) isLastRow:(NSIndexPath *)indexPath
{
	return (indexPath.row + 1) == (NSIndexPathRowType) [self tableView:self.tableView numberOfRowsInSection:indexPath.section];
}

- (BOOL) isLastRow:(NSUInteger) row inSection:(NSInteger) inSection
{
	return (row + 1) == (NSUInteger) [self tableView:self.tableView numberOfRowsInSection:inSection];
}

- (void) setPopoverSizeToTableSize:(BOOL) animated
{
    GtHoverViewController* popover = self.hoverViewController;
    if(popover)
    {
        CGRect lastSectionRect = [self.view convertRect:[self.tableView rectForSection:self.tableView.numberOfSections - 1] fromView:self.tableView];
        CGSize size =  self.view.frame.size;
        
        size.height = GtRectGetBottom(lastSectionRect);

        GtViewContentsDescriptor contents = self.viewContentsDescriptor;
        
        if(contents.bottom == GtViewContentItemTabBar)
        {
            size.height += [UIDevice currentDevice].tabBarHeight;
        }
        else
        {
            size.height += 10.0f;
        }

        [self.hoverViewController setContentViewSize:self.view.frame.size animated:animated];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	return nil;
}
	
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1; 
}

- (void) tableViewDidLayoutSubviews:(UITableView*) tableView
{
	[self updateContentInsets];
}

- (void) tableViewWillReloadData:(UITableView*) tableView
{
	[self updateContentInsets];
}

- (void) loadView {
    [super loadView];
    
    GtAssertIsExpectedType(self.scrollView, GtTableView);
    
    self.tableView = (GtTableView*) self.scrollView;
}

- (void) viewDidLoad
{
	[super viewDidLoad];
	
	GtAssertNotNil(self.tableView);

//	self.view.backgroundColor = [self defaultBackgroundColor];
//	  self.tableView.backgroundColor = [self defaultTableBackgroundColor];
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	self.tableView.scrollsToTop = YES;
	self.tableView.allowsSelectionDuringEditing = NO;

}

- (void) viewDidUnload
{
	[self cleanupTableViewController];
	
	[super viewDidUnload];
}

- (void) beginRefreshing:(BOOL) userRequestedRefresh
{
	[self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 0;
}


@end
