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

- (id) initWithAssetQueue:(FLAssetQueue*) queue inDatabase:(FLObjectDatabase*) database doneBlock:(dispatch_block_t) doneBlock
{
	if((self = [super init]))
	{
		_assetQueue = retain_(queue);
		_database = retain_(database);
		_doneBlock = [doneBlock copy];
		
		self.title = NSLocalizedString(@"Upload History", nil);
	}
	return self;
}

+ (FLUploadHistoryViewController*) uploadHistoryViewController:(FLAssetQueue*) queue inDatabase:(FLObjectDatabase*) database doneBlock:(dispatch_block_t) doneBlock
{
	return autorelease_([[FLUploadHistoryViewController alloc] initWithAssetQueue:queue inDatabase:database doneBlock:doneBlock]);
}

- (void) dealloc
{
	mrc_release_(_doneBlock);
	mrc_release_(_database);
	mrc_release_(_uploadedAssets);
	mrc_release_(_assetQueue);
	mrc_super_dealloc_();
}

- (void) _done:(id) sender
{
	if(_doneBlock)
	{
		_doneBlock();
		FLReleaseBlockWithNil_(_doneBlock);
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
	return _uploadedAssets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	static NSString* s_id = @"cell";

	FLTableViewCell* cell = (FLTableViewCell*) [tableView dequeueReusableCellWithIdentifier:s_id];
	FLUploadHistoryListWidget* widget = nil;
	
	if(!cell)
	{
		cell = autorelease_([[FLTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:s_id]);
		widget = [FLUploadHistoryListWidget widgetWithFrame:CGRectZero];
		cell.widget = widget;
	}
	else
	{
		widget = (FLUploadHistoryListWidget*) cell.widget;
	}
	
	[widget setUploadedAsset:[_uploadedAssets objectAtIndex:indexPath.row] count:_uploadedAssets.count - indexPath.row total:_uploadedAssets.count];
	
	return cell;
}

- (void) beginRefreshing:(BOOL) userRequestedRefresh
{
	FLReleaseWithNil_(_uploadedAssets);
	
	NSArray* assets = nil;
	[_database loadAllObjectsForTypeWithClass:[FLUploadedAsset class] outObjects:&assets];
	
	_uploadedAssets = [assets mutableCopy];
	mrc_release_(assets);
	
	[_uploadedAssets sortUsingComparator:^(id lhs, id rhs) { return [[rhs uploadedAssetUID] compare:[lhs uploadedAssetUID]]; }];
	
	[self.tableView reloadData];
}

- (void) viewWillAppear:(BOOL) animated
{
	[super viewWillAppear:animated];
	
	[self beginRefreshing:NO];
}

@end
