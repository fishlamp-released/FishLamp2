//
//  ZFSinglePhotoUploader.h
//  FishLamp
//
//  Created by Mike Fullerton on 8/31/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZFPhotoUploader.h"

@interface ZFSinglePhotoUploader : ZFPhotoUploader {
}
- (id) initWithPhoto:(ZFQueuedPhoto*) photo 
         uploadQueue:(ZFUploadQueue*) uploadQueue;

@end
