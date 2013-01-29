//
//  FLZfUpdateSyncList.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/13/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLBatchOperation.h"

@interface FLZfPhotoSetStatusSyncOperation : FLBatchOperation {
}
@end

@protocol FLZfPhotoSetStatusSyncOperationObserver <NSObject>
- (void) syncPhotoSets:(FLZfPhotoSetStatusSyncOperation*) updater
    photoSetWasUpdated:(FLZfPhotoSet*) photoSet;

- (void) syncPhotoSets:(FLZfPhotoSetStatusSyncOperation*) updater
    photoSetWasRemoved:(NSNumber*) photoSetID;
@end

