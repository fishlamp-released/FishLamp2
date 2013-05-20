//
//  GtFacebookLoadUserPictureOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/5/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFacebookLoadUserPictureOperation.h"

#if IOS
#import "GtHttpImageDownloadNetworkResponseHandler.h"
#endif

#if IOS
#import "GtCachedImage.h"
#endif

@implementation GtFacebookLoadUserPictureOperation


@synthesize pictureSize = m_pictureSize;

- (void) didInit
{
	[super didInit];
	
	self.object = @"picture";
	self.cacheBehavior	= GtHttpOperationCacheBehaviorAll;

#if IOS
	self.responseHandler = [GtHttpImageDownloadNetworkResponseHandler instance];
	self.input = [GtCachedImage cachedImage];
#endif
	
	[self setPictureSize:GtFacebookLoadUserPictureOperationInputSizeNormal];
}

- (void) dealloc
{	
	GtRelease(m_pictureSize);
	GtSuperDealloc();
}

//- (id) initWithAccessToken:(NSString*) encodedToken userId:(NSString*) userId  size:(GtFacebookPictureSize) size
//{
//	NSString* sizeStr = kFacebookPictureSizeNormal;
//	switch(size)
//	{
//		case GtFacebookPictureSizeNormal:
//			sizeStr = kFacebookPictureSizeNormal;
//		break;
//		case GtFacebookPictureSizeSmall:
//			sizeStr = kFacebookPictureSizeSmall;
//		break;
//		case GtFacebookPictureSizeLarge:
//			sizeStr = kFacebookPictureSizeLarge;
//		break;
//		case GtFacebookPictureSizeSquare:
//			sizeStr = kFacebookPictureSizeSquare;
//		break;
//	}
//
//	if((self = [super initWithURL:[NSURL URLWithString:[GtFacebookMgr buildURL:encodedToken user:userId object:@"picture" params:@"type", sizeStr, nil]]]))
//	{	
//		self.userId = userId;
//		self.input = [GtCachedImage cachedImageWithUrlString:self.URL.absoluteString];
//		self.cacheBehavior	= GtHttpOperationCacheBehaviorAll;
//	}
//	
//	return self;
//}
//

- (void) prepareToLoadFromCache
{
#if IOS
	[self.input setUrl:self.URL];
#endif
}

- (void) addParametersToURLString:(NSMutableString*) url
{
	[url appendFormat:@"&type=%@", self.pictureSize];
}



//+ (GtFacebookLoadUserPictureOperation*) facebookLoadUserPicture:(NSString*) encodedToken userId:(NSString*) userId  size:(GtFacebookPictureSize) size
//{
//	return GtReturnAutoreleased([[GtFacebookLoadUserPictureOperation alloc] initWithAccessToken:encodedToken userId:userId size:size]);
//}


@end
