//
//  ZFUploadImageOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/1/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//

#import "FLHttp.h"
#import "ZFQueuedPhoto.h"
#import "FLJpegFile.h"

@protocol ZFUploadImageOperationDelegate;

@interface ZFUploadImageHttpRequest : FLHttpRequest {
@private
	ZFQueuedPhoto* _photo;
	FLJpegFile* _imageFile;
}

- (id) initWithUploadablePhoto:(ZFQueuedPhoto*) photo 
                 preparedImage:(FLJpegFile*) image;

@end
