//
//  GtFacebookStatusListController.m
//  fBee
//
//  Created by Mike Fullerton on 5/21/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFacebookStatusListViewController.h"
#import "GtAction.h"
#import "GtOldProgressView.h"
#import "GtFacebookOperation.h"
#import "GtFacebookFetchStatusListResponse.h"
#import "GtFacebookPost.h"
#import "GtFacebookMgr.h"
#import "GtTableViewCell.h"
#import "GtFacebookStatusTableCellWidget.h"
#import "GtFacebookFetchStatusListOperation.h"
#import "GtFacebookAuthenticator.h"

@implementation GtFacebookStatusListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
	{
		self.wantsPullToRefresh = YES;
		m_posts = [[NSMutableArray alloc] init];
		
		self.rowHeightCalculator = [GtFacebookStatusTableCellWidget widgetWithFrame:CGRectZero];
		[((NSObject*)self.rowHeightCalculator) applyTheme];
	}
	return self;
}

- (void) dealloc
{
	GtRelease(m_posts);
	GtSuperDealloc();
}

- (void) viewDidLoad
{
	[super viewDidLoad];
}

- (GtViewContentsDescriptor) describeViewContents
{
	return GtViewContentsDescriptorMake(GtViewContentItemNavigationBarAndStatusBar, GtViewContentItemNone);
}

- (void) _didFinishLoading:(GtAction*) action
{
	if(action.didFinishWithoutError)
	{
		GtFacebookFetchStatusListResponse* response = [[action lastOperation] operationOutput];
		
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

	GtTableViewCell* cell = (GtTableViewCell*) [tableView dequeueReusableCellWithIdentifier:s_id];
	
	if(!cell)
	{
		cell = GtReturnAutoreleased([[GtTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:s_id]);
		GtFacebookStatusTableCellWidget* widget = [GtFacebookStatusTableCellWidget widgetWithFrame:CGRectZero];
		cell.widget = widget;
		
//		  cell.themeAction = @selector(applyThemeToStringChooserViewControllerCell:);
//		  [cell applyTheme];
	}
	
	GtFacebookStatusTableCellWidget* widget = (GtFacebookStatusTableCellWidget*) cell.widget;
	widget.post = [m_posts objectAtIndex:indexPath.row];
	
	return cell;
}

- (id) dataForRowHeightCalculationAtIndexPath:(NSIndexPath*) indexPath
{
	return [m_posts objectAtIndex:indexPath.row];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	GtLog(@"height for row at indexPath: %@", indexPath);
//
//	return [GtFacebookStatusTableCellWidget heightForRowWithWidth:self.view.bounds.size.width andString:[[m_posts objectAtIndex:indexPath.row] message]];
//}

- (void) beginRefreshing:(BOOL) userRequestedRefresh
{
//    [[GtFacebookMgr instance] beginAuthenticatingInViewController:self callback:^(NSError* error)
//    {
//		if(!error)
//		{
//			GtAction* action = [GtAction action];
//			[self.actionContext beginAction:action configureAction:^(id inAction) {
//				action.progressView = [GtOldProgressView defaultProgressView];
//				action.actionDescription.actionType = GtActionDescriptionTypeLoad;
//				[action queueOperation:[GtFacebookFetchStatusListOperation facebookOperation] 
//					configureOperation:^(id operation) {
//					}];
//				action.didCompleteCallback = ^{ [self _didFinishLoading:action]; };
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
//			GtAction* action = [GtAction action];
//			[self.actionContext beginAction:action configureAction:^(id inAction) {
//				action.progressView = [GtOldProgressView defaultProgressView];
//				action.actionDescription.actionType = GtActionDescriptionTypeLoad;
//				[action queueOperation:[GtFacebookFetchStatusListOperation facebookFetchStatusListOperation:[GtFacebookMgr instance].encodedToken userId:@"me"]];
//				action.didCompleteCallback = ^{ [self _didFinishLoading:action]; };
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
