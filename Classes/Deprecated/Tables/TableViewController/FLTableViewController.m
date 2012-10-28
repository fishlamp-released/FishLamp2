//
//	FLTableViewController.m
//	FishLampFishLamp
//
//	Created by Mike Fullerton on 2/1/10.
//	Copyright 2010 GreenTongue Software, LLC. All rights reserved.
//

#import "FLTableViewController.h"

#import "FLAction.h"
#import "FLPullToRefreshHeaderView.h"
#import "FLFloatingViewController.h"
#import "FLTableViewCell.h"

#import "UIViewController+FLExtras.h"
#import "UIView+FLViewGeometry.h"

@implementation FLTableViewController

@synthesize rowHeightCalculator = _rowHeightCalculator;


- (UITableView*) tableView
{
    return (UITableView*) self.scrollView;
}

- (void) setTableView:(UITableView*) tableView
{
    self.scrollView = tableView;
}

- (void) setScrollView:(UIScrollView*) scrollView
{
    if(self.tableView)
    {
        self.tableView.delegate = nil;
        self.tableView.dataSource = nil;
    }
    
    [super setScrollView:scrollView];
    
    if(self.tableView)
    {
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
}

- (void) cleanupTableViewController
{
	self.tableView.delegate = nil;
	self.tableView.dataSource = nil;
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
	FLTableView* tableView = FLReturnAutoreleased([[FLTableView alloc] initWithFrame:self.view.bounds]);
	tableView.backgroundColor = self.view.backgroundColor;
	tableView.autoresizingMask = UIViewAutoresizingFlexibleEverything;
	tableView.autoresizesSubviews = YES;
	return tableView;
}

- (void) dealloc
{
	[self cleanupTableViewController];
	FLSuperDealloc();
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
    FLFloatingViewController* popover = self.floatingViewController;
    if(popover)
    {
        FLRect lastSectionRect = [self.view convertRect:[self.tableView rectForSection:self.tableView.numberOfSections - 1] fromView:self.tableView];
        FLSize size =  self.view.frame.size;
        
        size.height = FLRectGetBottom(lastSectionRect);

        FLViewContentsDescriptor* contents = self.viewContentsDescriptor;
        
        if(contents.bottomItem == FLViewContentItemTabBar)
        {
            size.height += [UIDevice currentDevice].tabBarHeight;
        }
        else
        {
            size.height += 10.0f;
        }

        [self.floatingViewController setContentViewSize:self.view.frame.size animated:animated];
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

- (void) viewDidLoad
{
	[super viewDidLoad];
	
	FLAssertIsNotNil_(self.tableView);

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
