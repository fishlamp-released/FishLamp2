//
//  FLTwitterLoadProfileImageOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/9/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLTwitterLoadProfileImageOperation.h"

#if IOS
#import "FLHttpImageDownloadNetworkResponseHandler.h"
#endif

#import "FLTwitterMgr.h"
#import "FLOperationCacheHandler.h"
#import "FLUserSession.h"

@implementation FLTwitterLoadProfileImageOperation

@synthesize imageSize = _imageSize;
@synthesize username = _username;

- (void) didInit
{
	[super didInit];
	
#if IOS
// TODO: refactor this
	self.responseHandler = [FLHttpImageDownloadNetworkResponseHandler instance];
#endif    
	self.imageSize = FLTwitterImageSizeNormal;

    [self addObserver:
        [FLOperationCacheHandler operationCacheHandler:[FLUserSession instance].cacheDatabase
                                              behavior:FLHttpOperationCacheBehaviorAll]];
}

- (void) dealloc
{
	mrc_release_(_username);
	mrc_release_(_imageSize);
	mrc_super_dealloc_();
}

- (NSURL*) createURL
{
	NSMutableString* url = [NSString stringWithFormat:@"http://api.twitter.com/1/users/profile_image/%@.json?size=%@", _username, _imageSize];

	return [NSURL URLWithString:url];
}


@end
