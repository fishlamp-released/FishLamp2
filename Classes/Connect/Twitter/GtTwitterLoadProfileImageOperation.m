//
//  GtTwitterLoadProfileImageOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/9/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTwitterLoadProfileImageOperation.h"

#if IOS
#import "GtHttpImageDownloadNetworkResponseHandler.h"
#endif

#import "GtTwitterMgr.h"

@implementation GtTwitterLoadProfileImageOperation

@synthesize imageSize = m_imageSize;
@synthesize username = m_username;

- (void) didInit
{
	[super didInit];
	
#if IOS
// TODO: refactor this
	self.responseHandler = [GtHttpImageDownloadNetworkResponseHandler instance];
#endif    
	self.imageSize = GtTwitterImageSizeNormal;
	self.database = [GtTwitterMgr instance].userSession.cacheDatabase;
	self.cacheBehavior = GtHttpOperationCacheBehaviorAll;
}

- (void) dealloc
{
	GtRelease(m_username);
	GtRelease(m_imageSize);
	GtSuperDealloc();
}

- (NSURL*) createURL
{
	NSMutableString* url = [NSString stringWithFormat:@"http://api.twitter.com/1/users/profile_image/%@.json?size=%@", m_username, m_imageSize];

	return [NSURL URLWithString:url];
}


@end
