//
//  ZFUpdateSyncList.h
//  ZenLib
//
//  Created by Mike Fullerton on 10/13/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLBatchOperation.h"

@interface ZFPhotoSetStatusSyncOperation : FLBatchOperation {
}
@end

@protocol ZFPhotoSetStatusSyncOperationObserver <NSObject>
- (void) syncPhotoSets:(ZFPhotoSetStatusSyncOperation*) updater
    photoSetWasUpdated:(ZFPhotoSet*) photoSet;

- (void) syncPhotoSets:(ZFPhotoSetStatusSyncOperation*) updater
    photoSetWasRemoved:(NSNumber*) photoSetID;
@end

