//
//  FLZfUploadImageOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/1/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//

#import "FLHttpRequest.h"
#import "FLZfQueuedPhoto.h"
#import "FLJpegFile.h"
#import "FLZfUtils.h"
#import "FLZfBitsUploadProtocolResponse.h"


@protocol FLZfUploadImageOperationDelegate;

@interface FLZfUploadImageHttpRequest : FLHttpRequest {
@private
	FLZfQueuedPhoto* _photo;
	FLJpegFile* _imageFile;
}

- (id) initWithUploadablePhoto:(FLZfQueuedPhoto*) photo preparedImage:(FLJpegFile*) image;

@end
