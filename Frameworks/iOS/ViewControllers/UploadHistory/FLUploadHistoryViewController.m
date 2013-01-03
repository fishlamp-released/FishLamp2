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
#import "FLObjectDatabase.h"

@implementation FLUploadHistoryViewController

- (id) initWithAssetQueue:(FLAssetQueue*) queue inDatabase:(FLObjectDatabase*) database doneBlock:(dispatch_block_t) doneBlock
{
	if((self = [super init]))
	{
		_assetQueue = FLRetain(queue);
		_database = FLRetain(database);
		_doneBlock = [doneBlock copy];
		
		self.title = NSLocalizedString(@"Upload History", nil);
	}
	return self;
}

+ (FLUploadHistoryViewController*) uploadHistoryViewController:(FLAssetQueue*) queue inDatabase:(FLObjectDatabase*) database doneBlock:(dispatch_block_t) doneBlock
{
	return FLAutorelease([[FLUploadHistoryViewController alloc] initWithAssetQueue:queue inDatabase:database doneBlock:doneBlock]);
}

- (void) dealloc
{
	FLRelease(_doneBlock);
	FLRelease(_database);
	FLRelease(_uploadedAssets);
	FLRelease(_assetQueue);
	FLSuperDealloc();
}

- (void) _done:(id) sender
{
	if(_doneBlock)
	{
		_doneBlock();
		FLReleaseBlockWithNil(_doneBlock);
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
		cell = FLAutorelease([[FLTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:s_id]);
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
	FLReleaseWithNil(_uploadedAssets);
	
	NSArray* assets = nil;
	[_database loadAllObjectsForTypeWithClass:[FLUploadedAsset class] outObjects:&assets];
	
	_uploadedAssets = [assets mutableCopy];
	FLRelease(assets);
	
	[_uploadedAssets sortUsingComparator:^(id lhs, id rhs) { return [[rhs uploadedAssetUID] compare:[lhs uploadedAssetUID]]; }];
	
	[self.tableView reloadData];
}

- (void) viewWillAppear:(BOOL) animated
{
	[super viewWillAppear:animated];
	
	[self beginRefreshing:NO];
}

@end
