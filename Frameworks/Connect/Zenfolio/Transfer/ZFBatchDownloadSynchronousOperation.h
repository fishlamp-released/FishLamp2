////
////  ZFBatchDownloadSynchronousOperation.h
////  Zenfolio FishLamp
////
////  Created by Mike Fullerton on 2/27/13.
////  Copyright (c) 2013 Mike Fullerton. All rights reserved.
////
//
//#import "FLSynchronousOperation.h"
//#import "FLObjectStorage.h"
//#import "ZFBatchDownloadSpec.h"
//#import "ZFTransferState.h"
//
//@interface ZFBatchDownloadSynchronousOperation : FLSynchronousOperation {
//@private
//    ZFBatchDownloadSpec* _downloadSpec;
//
//    ZFTransferState_t _state;
//    NSTimeInterval _lastProgress;
//    NSString* _downloadFolderPath;
//    
//    BOOL _downloadImages;
//    BOOL _downloadVideos;
//    
//    ZFGroup* _rootGroup;
//}
//
//+ (id) downloadOperation:(ZFBatchDownloadSpec*) downloadSpec;
//@end
//
//#define ZFDownloadedPhotoKey @"photo"
//#define ZFDownloadedPhotoSetKey @"photoSet"
//#define ZFDownloadedImageKey @"image"
//#define ZFDownloadedDestinationPathKey @"path"
//#define ZFDownloadFolderKey @"folder"
//#define ZFDownloadPhotoErrorKey @"error"
//
//@protocol ZFBatchDownloadOperationObserver <NSObject>
//@optional
//- (void) downloadOperation:(ZFBatchDownloadSynchronousOperation*) operation updateDownloadInfo:(ZFTransferState*) downloadInfo;
//
//- (void) downloadOperationWillBeginDownload:(ZFBatchDownloadSynchronousOperation*) operation;
//
//- (void) downloadOperation:(ZFBatchDownloadSynchronousOperation*) operation willUpdatePhotoSet:(ZFPhotoSet*) photoSet;
//- (void) downloadOperation:(ZFBatchDownloadSynchronousOperation*) operation didUpdatePhotoSet:(ZFPhotoSet*) photoSet;
//
//// these are called per photo set
//- (void) downloadOperation:(ZFBatchDownloadSynchronousOperation*) operation willStartDownloadingPhotosInPhotoSet:(NSDictionary*) downloadInfo;
//- (void) downloadOperation:(ZFBatchDownloadSynchronousOperation*) operation willDownloadPhoto:(NSDictionary*) downloadInfo;
//- (void) downloadOperation:(ZFBatchDownloadSynchronousOperation*) operation didSkipPhoto:(NSDictionary*) downloadInfo;
//- (void) downloadOperation:(ZFBatchDownloadSynchronousOperation*) operation didDownloadPhoto:(NSDictionary*) downloadInfo;
//- (void) downloadOperation:(ZFBatchDownloadSynchronousOperation*) operation didDownloadPhotosInPhotoSet:(NSDictionary*) downloadInfo;
//
//@end
