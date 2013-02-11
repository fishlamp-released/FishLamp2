//
//	FLZenfolioBatchSavePhotosToDevice.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/4/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//
#if REFACTOR

#import <Foundation/Foundation.h>

#import "FLBatchActionManager.h"
#import "FLZenfolioUtils.h"

#if IOS

@interface FLZenfolioBatchSavePhotosToDevice : FLBatchActionManager<UIAlertViewDelegate> {
@private
    FLZenfolioPhotoSizeEnum _downloadSize;
}

@end

#endif

#endif