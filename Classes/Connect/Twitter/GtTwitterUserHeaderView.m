//
//  GtTwitterUserHeaderView.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/8/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTwitterUserHeaderView.h"
#import "GtOAuthSession.h"
#import "GtTwitterMgr.h"
#import "GtTwitterLoadProfileImageOperation.h"
#import "GtCachedImage.h"

@implementation GtTwitterUserHeaderView

@synthesize userGuid = m_userGuid;

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.logoView.image = [UIImage imageNamed:@"bird_48_gray.png"];
	}
	return self;
}

- (void) dealloc
{
	GtRelease(m_userGuid);
	GtSuperDealloc();
}

- (void) _didCompleteLoad:(GtAction*) action
{
	if(action.didFinishWithoutError)
	{
		GtCachedImage* photo = [[action lastOperation] operationOutput];
		self.thumbnail = photo.imageFile.image;
	}

	[self stopSpinner];
}

- (void) beginLoadingInActionContext:(GtActionContext*) actionContext userGuid:(NSString*) userGuid
{
	[self startSpinner];
	
	GtOAuthSession* session = [[GtTwitterMgr instance] sessionForUserGuid:userGuid];
	
	self.name = [NSString stringWithFormat:@"@%@", session.screen_name];
	
	[actionContext beginAction:[GtAction actionWithActionType:GtActionDescriptionTypeLoad itemName:@"User"] 
		configureAction:^(id action) {
			[action queueOperation:[GtTwitterLoadProfileImageOperation operation]
				configureOperation:^(id operation) {
	//			operation.session = [[GtTwitterMgr instance] sessionForUserGuid:userGuid];
					[operation setUsername:session.screen_name];

					[operation setDatabase:[GtUserSession instance].cacheDatabase];
					[operation setCacheBehavior:GtHttpOperationCacheBehaviorAll];

					[operation setWasLoadedFromCacheMainThreadCallback: ^{
						GtCachedImage* photo = [operation operationOutput];
						self.thumbnail = photo.imageFile.image;
						[self stopSpinner];
					}];
				} ];
			
			[action setDidCompleteCallback: ^{ [self _didCompleteLoad:action]; }];
	}];

}



@end
