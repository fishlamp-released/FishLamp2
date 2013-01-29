//
//	ZFBatchSavePhotosToDevice.h
//	MyZen
//
//	Created by Mike Fullerton on 3/4/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//
#if REFACTOR

#import <Foundation/Foundation.h>

#import "FLBatchActionManager.h"
#import "ZFUtils.h"

#if IOS

@interface ZFBatchSavePhotosToDevice : FLBatchActionManager<UIAlertViewDelegate> {
@private
    ZFPhotoSizeEnum _downloadSize;
}

@end

#endif

#endif