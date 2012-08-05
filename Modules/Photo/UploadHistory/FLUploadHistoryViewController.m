//
//  FLUploadHistoryViewController.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/6/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLUploadHistoryViewController.h"
#import "FLUploadHistoryListWidget.h"
#import "FLGradientButton.h"
#import "FLTableViewCell.h"

@implementation FLUploadHistoryViewController

- (id) initWithAssetQueue:(FLAssetQueue*) queue inDatabase:(FLObjectDatabase*) database doneBlock:(FLEventCallback) doneBlock
{
	if((self = [super init]))
	{
		m_assetQueue = FLReturnRetained(queue);
		m_database = FLReturnRetained(database);
		m_doneBlock = [doneBlock copy];
		
		self.title = NSLocalizedString(@"Upload History", nil);
	}
	return self;
}

+ (FLUploadHistoryViewController*) uploadHistoryViewController:(FLAssetQueue*) queue inDatabase:(FLObjectDatabase*) database doneBlock:(FLEventCallback) doneBlock
{
	return FLReturnAutoreleased([[FLUploadHistoryViewController alloc] initWithAssetQueue:queue inDatabase:database doneBlock:doneBlock]);
}

- (void) dealloc
{
	FLRelease(m_doneBlock);
	FLRelease(m_database);
	FLRelease(m_uploadedAssets);
	FLRelease(m_assetQueue);
	FLSuperDealloc();
}

- (void) _done:(id) sender
{
	if(m_doneBlock)
	{
		m_doneBlock();
		FLReleaseBlockWithNil(m_doneBlock);
	}
}

- (void) viewDidLoad
{
	self.tableView.rowHeight = 60.0f;
	
	[self.buttonbar addButtonToRightSide:[FLToolbarButtonDeprecated toolbarButton:FLGradientButtonColorBrightBlue title:@"Done" target:self action:@selector(_done:)]
		forKey:@"done" animated:NO];
	
	[super viewDidLoad];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return m_uploadedAssets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	static NSString* s_id = @"cell";

	FLTableViewCell* cell = (FLTableViewCell*) [tableView dequeueReusableCellWithIdentifier:s_id];
	FLUploadHistoryListWidget* widget = nil;
	
	if(!cell)
	{
		cell = FLReturnAutoreleased([[FLTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:s_id]);
		widget = [FLUploadHistoryListWidget widgetWithFrame:CGRectZero];
		cell.widget = widget;
	}
	else
	{
		widget = (FLUploadHistoryListWidget*) cell.widget;
	}
	
	[widget setUploadedAsset:[m_uploadedAssets objectAtIndex:indexPath.row] count:m_uploadedAssets.count - indexPath.row total:m_uploadedAssets.count];
	
	return cell;
}

- (void) beginRefreshing:(BOOL) userRequestedRefresh
{
	FLReleaseWithNil(m_uploadedAssets);
	
	NSArray* assets = nil;
	[m_database loadAllObjectsForTypeWithClass:[FLUploadedAsset class] outObjects:&assets];
	
	m_uploadedAssets = [assets mutableCopy];
	FLRelease(assets);
	
	[m_uploadedAssets sortUsingComparator:^(id lhs, id rhs) { return [[rhs uploadedAssetUID] compare:[lhs uploadedAssetUID]]; }];
	
	[self.tableView reloadData];
}

- (void) viewWillAppear:(BOOL) animated
{
	[super viewWillAppear:animated];
	
	[self beginRefreshing:NO];
}

@end
