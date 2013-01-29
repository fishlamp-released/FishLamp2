//
//	FLZfBatchSavePhotosToDevice.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/4/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//
#if REFACTOR

#import <Foundation/Foundation.h>

#import "FLBatchActionManager.h"
#import "FLZfUtils.h"

#if IOS

@interface FLZfBatchSavePhotosToDevice : FLBatchActionManager<UIAlertViewDelegate> {
@private
    FLZfPhotoSizeEnum _downloadSize;
}

@end

#endif

#endif