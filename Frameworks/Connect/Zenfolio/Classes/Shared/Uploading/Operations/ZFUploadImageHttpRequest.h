//
//  ZFUploadImageOperation.h
//  myZenfolio
//
//  Created by Mike Fullerton on 9/1/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//

#import "FLHttpRequest.h"
#import "ZFQueuedPhoto.h"
#import "FLJpegFile.h"
#import "ZFUtils.h"
#import "ZFBitsUploadProtocolResponse.h"


@protocol ZFUploadImageOperationDelegate;

@interface ZFUploadImageHttpRequest : FLHttpRequest {
@private
	ZFQueuedPhoto* _photo;
	FLJpegFile* _imageFile;
}

- (id) initWithUploadablePhoto:(ZFQueuedPhoto*) photo preparedImage:(FLJpegFile*) image;

@end
