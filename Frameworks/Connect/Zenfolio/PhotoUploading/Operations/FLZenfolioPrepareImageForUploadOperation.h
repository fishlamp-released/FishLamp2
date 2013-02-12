//
//  FLZenfolioPrepareImageForUploadOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/1/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//

#import "FLOperation.h"
#import "FLZenfolioQueuedPhoto.h"
#import "FLJpegFile.h"

@interface FLZenfolioPrepareImageForUploadOperation : FLOperation {
@private
	FLZenfolioQueuedPhoto* _photo;
    unsigned long long _startSize;
    unsigned long long _finalSize;
}

@property (readonly, assign, nonatomic) unsigned long long startFileSize;
@property (readonly, assign, nonatomic) unsigned long long finalFileSize;

- (id) initWithUploadablePhoto:(FLZenfolioQueuedPhoto*) photo;

@end