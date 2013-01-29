//
//  ZFBatchPhotoUploader.h
//  myZenfolio
//
//  Created by Mike Fullerton on 8/31/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZFPhotoUploader.h"

@interface ZFBatchPhotoUploader : ZFPhotoUploader {
@private
	NSUInteger _uploadCount;
    NSUInteger _totalPhotosInQueue;
}

@end