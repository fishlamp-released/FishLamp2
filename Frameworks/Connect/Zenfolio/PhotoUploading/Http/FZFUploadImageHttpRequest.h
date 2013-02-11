//
//  FLZenfolioUploadImageOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/1/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//

#import "FLHttpRequest.h"
#import "FLZenfolioQueuedPhoto.h"
#import "FLJpegFile.h"
#import "FLZenfolioUtils.h"
#import "FLZenfolioBitsUploadProtocolResponse.h"


@protocol FLZenfolioUploadImageOperationDelegate;

@interface FLZenfolioUploadImageHttpRequest : FLHttpRequest {
@private
	FLZenfolioQueuedPhoto* _photo;
	FLJpegFile* _imageFile;
}

- (id) initWithUploadablePhoto:(FLZenfolioQueuedPhoto*) photo preparedImage:(FLJpegFile*) image;

@end
