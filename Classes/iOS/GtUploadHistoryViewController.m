//
//  GtUploadHistoryViewController.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/6/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtUploadHistoryViewController.h"
#import "GtUploadHistoryListWidget.h"
#import "GtGradientButton.h"
#import "GtTableViewCell.h"

@implementation GtUploadHistoryViewController

- (id) initWithAssetQueue:(GtAssetQueue*) queue inDatabase:(GtObjectDatabase*) database doneBlock:(GtBlock) doneBlock
{
	if((self = [super init]))
	{
		m_assetQueue = GtRetain(queue);
		m_database = GtRetain(database);
		m_doneBlock = [doneBlock copy];
		
		self.title = NSLocalizedString(@"Upload History", nil);
	}
	return self;
}

+ (GtUploadHistoryViewController*) uploadHistoryViewController:(GtAssetQueue*) queue inDatabase:(GtObjectDatabase*) database doneBlock:(GtBlock) doneBlock
{
	return GtReturnAutoreleased([[GtUploadHistoryViewController alloc] initWithAssetQueue:queue inDatabase:database doneBlock:doneBlock]);
}

- (void) dealloc
{
	GtRelease(m_doneBlock);
	GtRelease(m_database);
	GtRelease(m_uploadedAssets);
	GtRelease(m_assetQueue);
	GtSuperDealloc();
}

- (void) _done:(id) sender
{
	if(m_doneBlock)
	{
		m_doneBlock();
		GtReleaseBlockWithNil(m_doneBlock);
	}
}

- (void) viewDidLoad
{
	self.tableView.rowHeight = 60.0f;
	
	[self.buttonbar addButtonToRightSide:[GtToolbarButton toolbarButton:GtButtonColorBrightBlue title:@"Done" target:self action:@selector(_done:)]
		forKey:@"done" animated:NO];
	
	[super viewDidLoad];
}

- (GtViewContentsDescriptor) describeViewContents
{
	return GtViewContentsDescriptorMake(GtViewContentItemNavigationBarAndStatusBar, GtViewContentItemNone);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return m_uploadedAssets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	static NSString* s_id = @"cell";

	GtTableViewCell* cell = (GtTableViewCell*) [tableView dequeueReusableCellWithIdentifier:s_id];
	GtUploadHistoryListWidget* widget = nil;
	
	if(!cell)
	{
		cell = GtReturnAutoreleased([[GtTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:s_id]);
		widget = [GtUploadHistoryListWidget widgetWithFrame:CGRectZero];
		cell.widget = widget;
	}
	else
	{
		widget = (GtUploadHistoryListWidget*) cell.widget;
	}
	
	[widget setUploadedAsset:[m_uploadedAssets objectAtIndex:indexPath.row] count:m_uploadedAssets.count - indexPath.row total:m_uploadedAssets.count];
	
	return cell;
}

- (void) beginRefreshing:(BOOL) userRequestedRefresh
{
	GtReleaseWithNil(m_uploadedAssets);
	
	NSArray* assets = nil;
	[m_database loadAllObjectsForTypeWithClass:[GtUploadedAsset class] outObjects:&assets];
	
	m_uploadedAssets = [assets mutableCopy];
	GtRelease(assets);
	
	[m_uploadedAssets sortUsingComparator:^(id lhs, id rhs) { return [[rhs uploadedAssetUID] compare:[lhs uploadedAssetUID]]; }];
	
	[self.tableView reloadData];
}

- (void) viewWillAppear:(BOOL) animated
{
	[super viewWillAppear:animated];
	
	[self beginRefreshing:NO];
}

@end
