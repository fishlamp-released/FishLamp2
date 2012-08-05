//
//	FLDownloadHttpImageNetworkOperationBehavior.m
//	FishLampMobileLib
//
//	Created by Mike Fullerton on 11/13/10.
//	Copyright 2010 Greentongue Software. All rights reserved.
//

#import "FLHttpImageDownloadNetworkResponseHandler.h"
#import "FLCachedImage.h"
#import "FLHttpConnection.h"

@implementation FLHttpImageDownloadNetworkResponseHandler

FLSynthesizeSingleton(FLHttpImageDownloadNetworkResponseHandler);

- (NSError*) networkOperation:(FLHttpOperation*) operation networkConnectionDidFinish:(FLHttpConnection*) webRequest
{
	FLAssert([webRequest isKindOfClass:[FLHttpConnection class]], @"not a FLHttpConnection");

	NSError* error = webRequest.error;
	if(!error)
	{
		error = [webRequest.httpResponse simpleHttpResponseErrorCheck];
	}
	if(!error)
	{
		FLCachedImage* photo = [[FLCachedImage alloc] init];

		photo.url = operation.URLString;
		
		NSData* data = webRequest.httpResponse.responseData;
		if(data && data.length > 0)
		{
			// note: folder and file name will be set by image cache.
			FLJpegFile* imageFile = [[FLJpegFile alloc] init];
			imageFile.jpegData = data;
			photo.imageFile = imageFile;
			FLReleaseWithNil(imageFile);
			
			operation.output = photo;
		}
		
		FLRelease(photo);
	}
	return error;
}

- (void) networkOperation:(FLHttpOperation*) operation 
      shouldRedirectToURL:(NSURL*) url
             willRedirect:(BOOL*) willRedirect {
             
             
}


@end

