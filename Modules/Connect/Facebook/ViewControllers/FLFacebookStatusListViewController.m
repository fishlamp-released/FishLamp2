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
#import "FLFacebookOperation.h"
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
		m_posts = [[NSMutableArray alloc] init];
		
		self.rowHeightCalculator = [FLFacebookStatusTableCellWidget widgetWithFrame:CGRectZero];
		[((NSObject*)self.rowHeightCalculator) applyTheme];
	}
	return self;
}

- (void) dealloc
{
	FLRelease(m_posts);
	FLSuperDealloc();
}

- (void) viewDidLoad
{
	[super viewDidLoad];
}

- (void) _didFinishLoading:(FLAction*) action
{
	if(action.didFinishWithoutError)
	{
		FLFacebookFetchStatusListResponse* response = [[action lastOperation] operationOutput];
		
		[m_posts removeAllObjects];
		[m_posts addObjectsFromArray:response.data];
	}
	
	[self setFinishedRefreshing];
	[self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return m_posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	static NSString* s_id = @"cell";

	FLTableViewCell* cell = (FLTableViewCell*) [tableView dequeueReusableCellWithIdentifier:s_id];
	
	if(!cell)
	{
		cell = FLReturnAutoreleased([[FLTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:s_id]);
		FLFacebookStatusTableCellWidget* widget = [FLFacebookStatusTableCellWidget widgetWithFrame:CGRectZero];
		cell.widget = widget;
		
//		  cell.themeAction = @selector(applyThemeToStringChooserViewControllerCell:);
//		  [cell applyTheme];
	}
	
	FLFacebookStatusTableCellWidget* widget = (FLFacebookStatusTableCellWidget*) cell.widget;
	widget.post = [m_posts objectAtIndex:indexPath.row];
	
	return cell;
}

- (id) dataForRowHeightCalculationAtIndexPath:(NSIndexPath*) indexPath
{
	return [m_posts objectAtIndex:indexPath.row];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	FLLog(@"height for row at indexPath: %@", indexPath);
//
//	return [FLFacebookStatusTableCellWidget heightForRowWithWidth:self.view.bounds.size.width andString:[[m_posts objectAtIndex:indexPath.row] message]];
//}

- (void) beginRefreshing:(BOOL) userRequestedRefresh
{
//    [[FLFacebookMgr instance] beginAuthenticatingInViewController:self callback:^(NSError* error)
//    {
//		if(!error)
//		{
//			FLAction* action = [FLAction action];
//			[self.actionContext beginAction:action configureAction:^(id inAction) {
//				action.progressController = [FLLegacyProgressView defaultProgressView];
//				action.actionDescription.actionType = FLActionDescriptionTypeLoad;
//				[action queueOperation:[FLFacebookFetchStatusListOperation facebookOperation] 
//					configureOperation:^(id operation) {
//					}];
//				action.onFinished = ^(id theAction) { [self _didFinishLoading:theAction]; };
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
//			[self.actionContext beginAction:action configureAction:^(id inAction) {
//				action.progressController = [FLLegacyProgressView defaultProgressView];
//				action.actionDescription.actionType = FLActionDescriptionTypeLoad;
//				[action queueOperation:[FLFacebookFetchStatusListOperation facebookFetchStatusListOperation:[FLFacebookMgr instance].encodedToken userId:@"me"]];
//				action.onFinished = ^(id theAction) { [self _didFinishLoading:theAction]; };
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