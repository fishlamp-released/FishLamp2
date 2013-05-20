//
//	GtDownloadHttpImageNetworkOperationBehavior.m
//	FishLampMobileLib
//
//	Created by Mike Fullerton on 11/13/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtHttpImageDownloadNetworkResponseHandler.h"
#import "GtCachedImage.h"
#import "GtHttpConnection.h"

@implementation GtHttpImageDownloadNetworkResponseHandler

GtSynthesizeSingleton(GtHttpImageDownloadNetworkResponseHandler);

- (NSError*) networkOperation:(GtHttpOperation*) operation networkConnectionDidClose:(GtHttpConnection*) webRequest
{
	GtAssert([webRequest isKindOfClass:[GtHttpConnection class]], @"not a GtHttpConnection");

	NSError* error = webRequest.error;
	if(!error)
	{
		error = [webRequest.httpResponse simpleHttpResponseErrorCheck];
	}
	if(!error)
	{
		GtCachedImage* photo = [[GtCachedImage alloc] init];

		photo.url = operation.URLString;
		
		NSData* data = webRequest.httpResponse.responseData;
		if(data && data.length > 0)
		{
			// note: folder and file name will be set by image cache.
			GtJpegFile* imageFile = [[GtJpegFile alloc] init];
			imageFile.jpegData = data;
			photo.imageFile = imageFile;
			GtReleaseWithNil(imageFile);
			
			operation.output = photo;
		}
		
		GtRelease(photo);
	}
	return error;
}

@end

