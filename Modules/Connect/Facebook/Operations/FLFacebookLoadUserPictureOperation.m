//
//  FLFacebookLoadUserPictureOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/5/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLFacebookLoadUserPictureOperation.h"
#import "FLOperationCacheHandler.h"

#if IOS
#import "FLHttpImageDownloadNetworkResponseHandler.h"
#endif

#if IOS
#import "FLCachedImage.h"
#endif

@implementation FLFacebookLoadUserPictureOperation


@synthesize pictureSize = m_pictureSize;

- (void) didInit
{
	[super didInit];
	
	self.object = @"picture";

#if IOS
	self.responseHandler = [FLHttpImageDownloadNetworkResponseHandler instance];
	self.input = [FLCachedImage cachedImage];
#endif
	
	[self setPictureSize:FLFacebookLoadUserPictureOperationInputSizeNormal];
}

- (void) dealloc
{	
	FLRelease(m_pictureSize);
	FLSuperDealloc();
}

//- (id) initWithAccessToken:(NSString*) encodedToken userId:(NSString*) userId  size:(FLFacebookPictureSize) size
//{
//	NSString* sizeStr = kFacebookPictureSizeNormal;
//	switch(size)
//	{
//		case FLFacebookPictureSizeNormal:
//			sizeStr = kFacebookPictureSizeNormal;
//		break;
//		case FLFacebookPictureSizeSmall:
//			sizeStr = kFacebookPictureSizeSmall;
//		break;
//		case FLFacebookPictureSizeLarge:
//			sizeStr = kFacebookPictureSizeLarge;
//		break;
//		case FLFacebookPictureSizeSquare:
//			sizeStr = kFacebookPictureSizeSquare;
//		break;
//	}
//
//	if((self = [super initWithURL:[NSURL URLWithString:[FLFacebookMgr buildURL:encodedToken user:userId object:@"picture" params:@"type", sizeStr, nil]]]))
//	{	
//		self.userId = userId;
//		self.input = [FLCachedImage cachedImageWithUrlString:self.URL.absoluteString];
//		self.cacheBehavior	= FLHttpOperationCacheBehaviorAll;
//	}
//	
//	return self;
//}
//

- (void) willPerformOperation
{
#if IOS
	[self.input setUrl:self.URL.absoluteString];
#endif
    [super willPerformOperation];
}

- (void) addParametersToURLString:(NSMutableString*) url
{
	[url appendFormat:@"&type=%@", self.pictureSize];
}



//+ (FLFacebookLoadUserPictureOperation*) facebookLoadUserPicture:(NSString*) encodedToken userId:(NSString*) userId  size:(FLFacebookPictureSize) size
//{
//	return FLReturnAutoreleased([[FLFacebookLoadUserPictureOperation alloc] initWithAccessToken:encodedToken userId:userId size:size]);
//}


@end
