//
//  FLFacebookLoadUserPictureOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/5/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLFacebookLoadUserPictureOperation.h"
#import "FLOperationCacheHandler.h"
#import "FLDownloadImageOperation.h"
#import "FLCachedImage.h"

@implementation FLFacebookLoadUserPictureOperation

@synthesize pictureSize = _pictureSize;

- (id) initWithHTTPRequestURL:(NSURL*) url {
    self = [super initWithHTTPRequestURL:url];
    if(self) {
        self.object = @"picture";
        [self setPictureSize:FLFacebookLoadUserPictureOperationInputSizeNormal];
    }
    return self;
}

- (void) dealloc {	
	FLRelease(_pictureSize);
	super_dealloc_();
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
//	if((self = [super initWithURL:[NSURL URLWithString:[FLFacebookService buildURL:encodedToken user:userId object:@"picture" params:@"type", sizeStr, nil]]]))
//	{	
//		self.userId = userId;
//		self.operationInput = [FLCachedImage cachedImageWithUrlString:self.URL.absoluteString];
//		self.cacheBehavior	= FLHttpOperationCacheBehaviorAll;
//	}
//	
//	return self;
//}
//



- (FLResult) runSelf:(id) input {

FIXME(@"need the behavior but not the operation");
  
//        self.responseHandler = [FLHttpImageDownloadNetworkResponseHandler instance];
//        self.operationInput = [FLCachedImage cachedImage];
  

   return  [super runSelf:(id) input];
}

- (void) addParametersToURLString:(NSMutableString*) url
{
	[url appendFormat:@"&type=%@", self.pictureSize];
}



//+ (FLFacebookLoadUserPictureOperation*) facebookLoadUserPicture:(NSString*) encodedToken userId:(NSString*) userId  size:(FLFacebookPictureSize) size
//{
//	return FLAutorelease([[FLFacebookLoadUserPictureOperation alloc] initWithAccessToken:encodedToken userId:userId size:size]);
//}


@end
