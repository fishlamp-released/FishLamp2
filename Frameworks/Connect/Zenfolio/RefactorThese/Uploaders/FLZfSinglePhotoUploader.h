//
//  FLZfSinglePhotoUploader.h
//  FishLamp
//
//  Created by Mike Fullerton on 8/31/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLZfPhotoUploader.h"

@interface FLZfSinglePhotoUploader : FLZfPhotoUploader {
}
- (id) initWithPhoto:(FLZfQueuedPhoto*) photo 
         uploadQueue:(FLZfUploadQueue*) uploadQueue;

@end
