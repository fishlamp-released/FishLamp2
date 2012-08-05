//
//  FLTwitterUserHeaderView.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/8/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLTwitterUserHeaderView.h"
#import "FLOAuthSession.h"
#import "FLTwitterMgr.h"
#import "FLTwitterLoadProfileImageOperation.h"
#import "FLCachedImage.h"
#import "FLOperationCacheHandler.h"
#import "FLUserSession.h"

@implementation FLTwitterUserHeaderView

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
	FLRelease(m_userGuid);
	FLSuperDealloc();
}

- (void) _didCompleteLoad:(FLAction*) action
{
	if(action.didFinishWithoutError)
	{
		FLCachedImage* photo = [[action lastOperation] operationOutput];
		self.thumbnail = photo.imageFile.image;
	}

	[self stopSpinner];
}

- (void) beginLoadingInActionContext:(FLActionContext*) actionContext userGuid:(NSString*) userGuid
{
	[self startSpinner];
	
	FLOAuthSession* session = [[FLTwitterMgr instance] sessionForUserGuid:userGuid];
	
	self.name = [NSString stringWithFormat:@"@%@", session.screen_name];
	
    FLAction* action = [FLAction actionWithActionType:FLActionDescriptionTypeLoad actionItemName:@"User"] ;
    
    FLTwitterLoadProfileImageOperation* operation = [FLTwitterLoadProfileImageOperation operation];
    [operation setUsername:session.screen_name];

    FLOperationCacheHandler* cacheHandler = 
        [FLOperationCacheHandler operationCacheHandler:[FLUserSession instance].cacheDatabase 
                                              behavior:FLHttpOperationCacheBehaviorAll];

    [cacheHandler setOnLoadedFromCacheInMainThread: ^(FLOperationCacheHandler* handler, id theOperation) {
        FLCachedImage* photo = [theOperation operationOutput];
        self.thumbnail = photo.imageFile.image;
        [self stopSpinner];
        }];
        
    [operation addObserver:cacheHandler];

    [action queueOperation:operation];

    [action setOnFinished: ^(id theAction) { 
        [self _didCompleteLoad:theAction]; 
        }];

	[actionContext beginAction:action];

}



@end
