//
//  FLZenfolioSinglePhotoUploader.h
//  FishLamp
//
//  Created by Mike Fullerton on 8/31/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLZenfolioPhotoUploader.h"

@interface FLZenfolioSinglePhotoUploader : FLZenfolioPhotoUploader {
}
- (id) initWithPhoto:(FLZenfolioQueuedPhoto*) photo 
         uploadQueue:(FLZenfolioUploadQueue*) uploadQueue;

@end
