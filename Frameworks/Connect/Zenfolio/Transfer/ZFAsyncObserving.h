//
//  ZFPhotoDownloaderObserving.h
//  FishLampConnect
//
//  Created by Mike Fullerton on 4/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "ZFDownloadSpec.h"
#import "ZFBatchDownloadSpec.h"

@protocol ZFAsyncObserving <NSObject>
@optional

- (void) willDownloadPhoto:(ZFDownloadSpec*) downloadSpec;
- (void) didDownloadPhoto:(ZFDownloadSpec*) downloadSpec withResult:(FLPromisedResult) result;

- (void) willDownloadPhotoSet:(ZFPhotoSet*) photoSet // may be nil if not in cache
                   photoSetID:(NSNumber*) number; 

- (void) didDownloadPhotoSetWithResult:(FLPromisedResult) result;

- (void) willDownloadRootGroup;
- (void) didDownloadRootGroupWithResult:(FLPromisedResult) result;

- (void) willDownloadPhotoSetBatch;
- (void) didDownloadPhotoSetBatchWithResult:(FLPromisedResult) result;

- (void) didDownloadPhotoBatchWithResult:(FLPromisedResult) result;

- (void) transferStateWasUpdated:(ZFTransferState*) transferState 
           forBatchPhotoDownload:(ZFBatchDownloadSpec*) downloadSpec;
 
@end


