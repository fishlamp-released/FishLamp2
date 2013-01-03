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

@synthesize userGuid = _userGuid;

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
	FLRelease(_userGuid);
	FLSuperDealloc();
}

- (void) _didCompleteLoad:(FLAction*) action
{
	if(action.didSucceed)
	{
		FLCachedImage* photo = [[action lastOperation] operationOutput];
		self.thumbnail = photo.imageFile.image;
	}

	[self stopSpinner];
}

- (void) startLoadingInViewController:(UIViewController*) viewController userGuid:(NSString*) userGuid
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

    [action addOperation:operation];

	[viewController startAction:action completion: ^(id result) {
        [self _didCompleteLoad:action]; 
        }];

}



@end
