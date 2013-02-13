//
//  FLZenfolioUploadImageOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/1/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//

#import "FLHttp.h"
#import "FLZenfolioQueuedPhoto.h"
#import "FLJpegFile.h"

@protocol FLZenfolioUploadImageOperationDelegate;

@interface FLZenfolioUploadImageHttpRequest : FLHttpRequest {
@private
	FLZenfolioQueuedPhoto* _photo;
	FLJpegFile* _imageFile;
}

- (id) initWithUploadablePhoto:(FLZenfolioQueuedPhoto*) photo 
                 preparedImage:(FLJpegFile*) image;

@end
