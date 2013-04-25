//
//  ZFPhotoDownloaderObserving.h
//  FishLampConnect
//
//  Created by Mike Fullerton on 4/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "ZFDownloadSpec.h"

@protocol ZFAsyncObserving <NSObject>
@optional

- (void) willDownloadPhoto:(ZFDownloadSpec*) downloadSpec;
- (void) didDownloadPhotoWithResult:(id<FLAsyncResult>) withResult;

- (void) didDownloadBytes:(NSNumber*) amount
                 forPhoto:(ZFDownloadSpec*) downloadSpec;

- (void) willDownloadPhotoSet:(ZFPhotoSet*) photoSet // may be nil if not in cache
                   photoSetID:(NSNumber*) number; 

- (void) didDownloadPhotoSetWithResult:(id<FLAsyncResult>) result;

- (void) willDownloadRootGroup;
- (void) didDownloadRootGroupWithResult:(id<FLAsyncResult>) result;

- (void) willDownloadPhotoSetBatch;
- (void) didDownloadPhotoSetBatchWithResult:(id<FLAsyncResult>) result;

- (void) didDownloadPhotoBatchWithResult:(id<FLAsyncResult>) result;

@end

