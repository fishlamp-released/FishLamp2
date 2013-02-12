//
//  FLFacebookLoadUserPictureOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/5/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLFacebookLoadUserPictureHttpRequest.h"
#import "FLOperationCacheHandler.h"
#import "FLDownloadImageHttpRequest.h"
#import "FLCachedImage.h"

@implementation FLFacebookLoadUserPictureHttpRequest

@synthesize pictureSize = _pictureSize;

- (id) initWithRequestURL:(NSURL*) url httpMethod:(NSString*) httpMethod {
    self = [super initWithRequestURL:url httpMethod:httpMethod];
    if(self) {
        self.object = @"picture";
        [self setPictureSize:FLFacebookLoadUserPictureOperationInputSizeNormal];
    }
    return self;
}

- (void) dealloc {	
	FLRelease(_pictureSize);
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
//	if((self = [super initWithURL:[NSURL URLWithString:[FLFacebookFacebookService buildURL:encodedToken user:userId object:@"picture" params:@"type", sizeStr, nil]]]))
//	{	
//		self.userId = userId;
//		self.operationInput = [FLCachedImage cachedImageWithUrlString:self.URL.absoluteString];
//		self.cacheBehavior	= FLHttpOperationCacheBehaviorAll;
//	}
//	
//	return self;
//}
//

- (void) willSendHttpRequest {

}


- (id) didReceiveHttpResponse:(FLHttpResponse*) response {

    return response;
}

//
//- (FLResult) runOperation {
//
//FIXME(@"need the behavior but not the operation");
//  
////        self.responseHandler = [FLHttpImageDownloadNetworkResponseHandler instance];
////        self.operationInput = [FLCachedImage cachedImage];
//  
//
//   return  [super runOperation];
//}

- (void) addParametersToURLString:(NSMutableString*) url
{
	[url appendFormat:@"&type=%@", self.pictureSize];
}



//+ (FLFacebookLoadUserPictureOperation*) facebookLoadUserPicture:(NSString*) encodedToken userId:(NSString*) userId  size:(FLFacebookPictureSize) size
//{
//	return FLAutorelease([[FLFacebookLoadUserPictureOperation alloc] initWithAccessToken:encodedToken userId:userId size:size]);
//}


@end
