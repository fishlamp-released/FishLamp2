//
//  FLFacebookStatusListController.m
//  fBee
//
//  Created by Mike Fullerton on 5/21/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#if 0
#import "FLFacebookStatusListViewController.h"
#import "FLAction.h"
#import "FLLegacyProgressView.h"
#import "FLFacebookHttpRequest.h"
#import "FLFacebookFetchStatusListResponse.h"
#import "FLFacebookPost.h"
#import "FLFacebookMgr.h"
#import "FLTableViewCell.h"
#import "FLFacebookStatusTableCellWidget.h"
#import "FLFacebookFetchStatusListOperation.h"
#import "FLFacebookAuthenticator.h"

@implementation FLFacebookStatusListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
	{
        self.wantsPullToRefresh = YES;
		_posts = [[NSMutableArray alloc] init];
		
		self.rowHeightCalculator = [FLFacebookStatusTableCellWidget widgetWithFrame:CGRectZero];
		[((NSObject*)self.rowHeightCalculator) applyTheme];
	}
	return self;
}

- (void) dealloc
{
	FLRelease(_posts);
	super_dealloc_();
}

- (void) viewDidLoad
{
	[super viewDidLoad];
}

- (void) _didFinishLoading:(FLAction*) action
{
	if(action.didSucceed)
	{
		FLFacebookFetchStatusListResponse* response = [[action lastOperation] operationOutput];
		
		[_posts removeAllObjects];
		[_posts addObjectsFromArray:response.data];
	}
	
	[self setFinishedRefreshing];
	[self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return _posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	static NSString* s_id = @"cell";

	FLTableViewCell* cell = (FLTableViewCell*) [tableView dequeueReusableCellWithIdentifier:s_id];
	
	if(!cell)
	{
		cell = FLAutorelease([[FLTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:s_id]);
		FLFacebookStatusTableCellWidget* widget = [FLFacebookStatusTableCellWidget widgetWithFrame:CGRectZero];
		cell.widget = widget;
		
//		  cell.themeAction = @selector(applyThemeToStringChooserViewControllerCell:);
//		  [cell applyTheme];
	}
	
	FLFacebookStatusTableCellWidget* widget = (FLFacebookStatusTableCellWidget*) cell.widget;
	widget.post = [_posts objectAtIndex:indexPath.row];
	
	return cell;
}

- (id) dataForRowHeightCalculationAtIndexPath:(NSIndexPath*) indexPath
{
	return [_posts objectAtIndex:indexPath.row];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	FLLog(@"height for row at indexPath: %@", indexPath);
//
//	return [FLFacebookStatusTableCellWidget heightForRowWithWidth:self.view.bounds.size.width andString:[[_posts objectAtIndex:indexPath.row] message]];
//}

- (void) beginRefreshing:(BOOL) userRequestedRefresh
{
//    [[FLFacebookMgr instance] beginAuthenticatingInViewController:self callback:^(NSError* error)
//    {
//		if(!error)
//		{
//			FLAction* action = [FLAction action];
//			[self.actionContext startAction:action configureAction:^(id inAction) {
//				action.progressController = [FLLegacyProgressView defaultProgressView];
//				action.actionDescription.actionType = FLActionDescriptionTypeLoad;
//				[action addOperation:[FLFacebookFetchStatusListOperation facebookOperation] 
//					configureOperation:^(id operation) {
//					}];
//				action.willFinishBlock = ^(id theAction) { [self _didFinishLoading:theAction]; };
//			}];
//	
//			// load status list!
//	
//		}    
//    
//    }];

//	[self facebook_beginAuthenticatingApp:^(NSError* error)
//	{
//		if(!error)
//		{
//			FLAction* action = [FLAction action];
//			[self.actionContext startAction:action configureAction:^(id inAction) {
//				action.progressController = [FLLegacyProgressView defaultProgressView];
//				action.actionDescription.actionType = FLActionDescriptionTypeLoad;
//				[action addOperation:[FLFacebookFetchStatusListOperation facebookFetchStatusListOperation:[FLFacebookMgr instance].encodedToken userId:@"me"]];
//				action.willFinishBlock = ^(id theAction) { [self _didFinishLoading:theAction]; };
//			}];
//	
//			// load status list!
//	
//		}
//	}];

	[self.tableView reloadData];
}

- (void) viewWillAppear:(BOOL) animated
{
	[super viewWillAppear:animated];
	
	[self beginRefreshing:NO];
}

- (void) viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
}


@end
#endif