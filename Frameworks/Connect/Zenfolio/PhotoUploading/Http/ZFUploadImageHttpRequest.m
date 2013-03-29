//
//  ZFUploadImageOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/1/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//

#import "ZFUploadImageHttpRequest.h"

@implementation ZFUploadImageHttpRequest

static NSNumberFormatter* s_formatter = nil;

+ (void) initialize {
    if(!s_formatter) {
        s_formatter = [[NSNumberFormatter alloc] init];
    }
}

- (id) initWithUploadablePhoto:(ZFQueuedPhoto*) photo  preparedImage:(FLJpegFile*) image {
	if((self = [super init]))  {
        _imageFile = FLRetain(image);
		_photo = FLRetain(photo);
    }
	
	return self;
}

- (void) dealloc
{
	FLRelease(_imageFile);
	FLRelease(_photo);
	FLSuperDealloc();
}

//- (FLResult) performSynchronously {
//    if(FLStringIsEmpty(_photo.uploadGallery.uploadUrl)) {
//        FLThrowErrorCodeWithComment(ZFErrorDomain, ZFErrorCodeUploadPhotoSetNotFound, @"PhotoSet not found: %@", _photo.uploadGallery.name);
//    }
//    if(FLStringIsEmpty(_photo.assetFileName)) {
//        FLThrowErrorCodeWithComment(ZFErrorDomain, ZFErrorCodeUploadFileNameEmpty, @"FileName is empty");
//    }
//
//    FLHttpRequest* httpRequest = [FLHttpRequest httpPostRequestWithURL:[_photo buildUploadURL:YES]];
//    [httpRequest setJpegContentWithFilePath:_imageFile.filePath];
//
//    FLHttpResponse* httpResponse = [self runChildSynchronously:httpRequest];
//    
//    NSString* textId = FLAutorelease([[NSString alloc] initWithData:httpResponse.responseData encoding:NSASCIIStringEncoding]);
//    if(FLStringIsNotEmpty(textId)) {
//        NSNumber* photoId = [s_formatter numberFromString:textId];
//        if([photoId intValue] != 0) {
//            return photoId;
//        }
//        else {
//            FLThrowErrorCodeWithComment(ZFErrorDomain, ZFErrorCodeUnknownObjectId, @"invalid photo id returned from server");
//        }
//    }
//    
//    return nil;
//}

@end
