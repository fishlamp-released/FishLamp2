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

- (void) operationDidRun:(FLHttpOperation*) operation {

    FLThrowIfError_([operation.httpResponse simpleHttpResponseErrorCheck]);

    FLCachedImage* photo = [FLCachedImage create];

    photo.url = operation.URLString;
    
    NSData* data = operation.httpResponse.responseData;
    if(data && data.length > 0)
    {
        // note: folder and file name will be set by image cache.
        FLJpegFile* imageFile = [[FLJpegFile alloc] init];
        imageFile.jpegData = data;
        photo.imageFile = imageFile;
        FLReleaseWithNil_(imageFile);
        
        operation.output = photo;
    }
}



@end

