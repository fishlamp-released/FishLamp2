//
//  FLZenfolioUpdateSyncList.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/13/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLBatchOperation.h"

@interface FLZenfolioPhotoSetStatusSyncOperation : FLBatchOperation {
}
@end

@protocol FLZenfolioPhotoSetStatusSyncOperationObserver <NSObject>
- (void) syncPhotoSets:(FLZenfolioPhotoSetStatusSyncOperation*) updater
    photoSetWasUpdated:(FLZenfolioPhotoSet*) photoSet;

- (void) syncPhotoSets:(FLZenfolioPhotoSetStatusSyncOperation*) updater
    photoSetWasRemoved:(NSNumber*) photoSetID;
@end

