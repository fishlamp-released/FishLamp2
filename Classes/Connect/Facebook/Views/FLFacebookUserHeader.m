//
//  FLFacebookUserHeader.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/6/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLFacebookUserHeader.h"

#import "FLCachedImage.h"
#import "FLFacebookUser.h"
#import "FLAction.h"
#import "FLFacebookLoadUserOperation.h"
#import "FLFacebookLoadUserPictureOperation.h"
#import "FLOperationCacheHandler.h"

#import "FLUserSession.h"

@implementation FLFacebookUserHeader

- (id) initWithFrame:(FLRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.logoView.image = [UIImage imageNamed:@"f_logo.png"];
	}
	return self;
}

- (void) _didCompleteLoad:(FLAction*) action
{
	if(action.didSucceed)
	{
		FLFacebookUser* user = [[action firstOperation] operationOutput];
		
		self.name = user.name;
		
		FLCachedImage* photo = [[action lastOperation] operationOutput];
		
		self.thumbnail = photo.imageFile.image;
		
	}

	[self stopSpinner];
}

- (void) startLoadingInViewController:(UIViewController*) viewController {
	[self startSpinner];
		
    FLAction* action = [FLAction actionWithActionType:FLActionDescriptionTypeLoad actionItemName:@"User"];
    			
    [action.operations addOperationWithFactoryBlock:^{
            FLFacebookLoadUserOperation* operation = [FLFacebookLoadUserOperation facebookOperation]; 
            FLOperationCacheHandler* cacheHandler = 
                [FLOperationCacheHandler operationCacheHandler:[FLUserSession instance].cacheDatabase 
                                                      behavior:FLHttpOperationCacheBehaviorAll];
            
            cacheHandler.onLoadedFromCacheInMainThread = ^(FLOperationCacheHandler* theHandler, id theOperation) {
                    FLFacebookUser* user = [theOperation operationOutput];
                    self.name = user.name;
                };
                          
            [operation addObserver:cacheHandler];
            return operation;
        }];

    [action.operations addOperationWithFactoryBlock:^{
        FLFacebookLoadUserPictureOperation* operation = [FLFacebookLoadUserPictureOperation facebookOperation];
        [operation setPictureSize:FLFacebookLoadUserPictureOperationInputSizeSquare];

        FLOperationCacheHandler* cacheHandler = 
            [FLOperationCacheHandler operationCacheHandler:[FLUserSession instance].cacheDatabase 
                                                  behavior:FLHttpOperationCacheBehaviorAll];

        cacheHandler.onLoadedFromCacheInMainThread = ^(FLOperationCacheHandler* theHandler, id theOperation){
            FLCachedImage* photo = [theOperation operationOutput];
            self.thumbnail = photo.imageFile.image;
            [self stopSpinner];
            };
            
        [operation addObserver:cacheHandler];
        return operation;
    }];

	[viewController startAction: action completion: ^(FLFinisher* result) {
        [self _didCompleteLoad:action]; 
        }];

}
@end
