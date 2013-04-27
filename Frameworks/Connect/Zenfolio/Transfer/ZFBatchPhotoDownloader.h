//
//  ZFBatchPhotoDownloader.h
//  FishLampConnect
//
//  Created by Mike Fullerton on 4/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAsyncOperationQueue.h"
#import "ZFBatchDownloadSpec.h"
#import "ZFDownloadQueue.h"
#import "FLDispatchQueue.h"
#import "ZFTransferState.h"
#import "ZFWebApi.h"
#import "ZFDownloadSpec.h"
#import "ZFAsyncObserving.h"

@interface ZFBatchPhotoDownloader : FLAsyncOperation {
@private
    ZFBatchDownloadSpec* _downloadSpec;
    ZFTransferState* _transferState;
    NSMutableArray* _downloadQueue;
    
    NSTimeInterval _lastProgress;
    NSString* _downloadFolderPath;
    ZFGroup* _rootGroup;
    
    BOOL _downloadImages;
    BOOL _downloadVideos;
}

+ (id) batchPhotoDownloadOperation:(ZFBatchDownloadSpec*) spec;

@end




//@protocol ZFBatchPhotoDownloaderDelegate <NSObject>
//- (void) batchPhotoSetDownloader:(ZFBatchPhotoSetDownloader*) downloader 
//             didDownloadPhotoSet:(ZFPhotoSet*) photoSet;
//             
//- (void) didDownloadPhotoSets:(id<FLAsyncResult>) result;
//             
//@end

//@protocol ZFBatchPhotoDownloaderDelegate <FLOperationDelegate>
//@optional
//- (void) batchPhotoDownloader:(ZFBatchPhotoDownloader*) operation updateDownloadInfo:(ZFTransferState*) downloadInfo;
//
//- (void) batchPhotoDownloaderWillBeginDownload:(ZFBatchPhotoDownloader*) operation;
//
//- (void) batchPhotoDownloader:(ZFBatchPhotoDownloader*) operation willUpdatePhotoSet:(ZFPhotoSet*) photoSet;
//- (void) batchPhotoDownloader:(ZFBatchPhotoDownloader*) operation didUpdatePhotoSet:(ZFPhotoSet*) photoSet;
//
//// these are called per photo set
//- (void) batchPhotoDownloader:(ZFBatchPhotoDownloader*) operation willStartDownloadingPhotosInPhotoSet:(NSDictionary*) downloadInfo;
//
//- (void) batchPhotoDownloader:(ZFBatchPhotoDownloader*) operation willDownloadPhoto:(ZFDownloadSpec*) downloadInfo;
//- (void) batchPhotoDownloader:(ZFBatchPhotoDownloader*) operation didSkipPhoto:(ZFDownloadSpec*) downloadInfo;
//- (void) batchPhotoDownloader:(ZFBatchPhotoDownloader*) operation didDownloadPhoto:(ZFDownloadSpec*) downloadInfo;
//
//- (void) batchPhotoDownloader:(ZFBatchPhotoDownloader*) operation didDownloadPhotosInPhotoSet:(NSDictionary*) downloadInfo;
//
//@end
//

