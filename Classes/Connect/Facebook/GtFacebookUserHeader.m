//
//  GtFacebookUserHeader.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/6/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFacebookUserHeader.h"

#import "GtCachedImage.h"
#import "GtFacebookUser.h"
#import "GtAction.h"
#import "GtFacebookLoadUserOperation.h"
#import "GtFacebookLoadUserPictureOperation.h"

@implementation GtFacebookUserHeader

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.logoView.image = [UIImage imageNamed:@"f_logo.png"];
	}
	return self;
}

- (void) _didCompleteLoad:(GtAction*) action
{
	if(action.didFinishWithoutError)
	{
		GtFacebookUser* user = [[action operationAtIndex:0] operationOutput];
		
		self.name = user.name;
		
		GtCachedImage* photo = [[action operationAtIndex:1] operationOutput];
		
		self.thumbnail = photo.imageFile.image;
		
	}

	[self stopSpinner];
}

- (void) beginLoadingInActionContext:(GtActionContext*) actionContext
{
	[self startSpinner];
		
	[actionContext beginAction:[GtAction actionWithActionType:GtActionDescriptionTypeLoad itemName:@"User"] 
		configureAction:^(id action) {
			
			[action queueOperation:[GtFacebookLoadUserOperation facebookOperation] 
				configureOperation:^(id operation) {
					[operation setWasLoadedFromCacheMainThreadCallback: ^{
						GtFacebookUser* user = [operation operationOutput];
						self.name = user.name;
					}];
			}];
		
			[action queueOperation:[GtFacebookLoadUserPictureOperation facebookOperation] 
				configureOperation:^(id operation) {
					[operation setPictureSize:GtFacebookLoadUserPictureOperationInputSizeSquare];
					[operation setWasLoadedFromCacheMainThreadCallback: ^{
						GtCachedImage* photo = [operation operationOutput];
						self.thumbnail = photo.imageFile.image;
						[self stopSpinner];
						}];
				}];
		
			[action setDidCompleteCallback: ^{ [self _didCompleteLoad:action]; }];
		}];

}
@end
