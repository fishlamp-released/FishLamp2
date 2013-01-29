//
//  ZFDownloaderSession.h
//  Downloader
//
//  Created by Mike Fullerton on 11/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLService.h"

#import "ZFHttpRequest.h"
#import "ZFImageDownloadingService.h"

#import "ZFBatchPhotoDownloadOperation.h"
#import "ZFUserContext.h"
#import "ZFGroupElementSelection.h"

//	[string] parent path of the download folder, set by user
//	The default path is ~/Desktop.
extern NSString * const ZFBaseFolder;

//	[int] the average download speed during the previous session in kB/S
//	The default value is 0.
extern NSString * const ZFDownloadSpeed;


@interface ZFDownloaderSession : ZFUserContext {
@private
    NSString* _destination;
    ZFImageDownloadingService* _imageDownloader;
    ZFGroupElementSelection* _selection;
}

//@property (readwrite, assign) BOOL loading;
//@property (readonly, strong, nonatomic) NSString* downloadFolder;
//@property (readonly, strong, nonatomic) NSString* downloadFolderName;
//@property (readonly, strong, nonatomic) NSArray* selectedPhotoSets;
//@property (readonly, assign, nonatomic) long long selectionSize;
@property (readwrite, strong) ZFGroupElementSelection* selection;
@property (readwrite, strong) ZFImageDownloadingService* imageDownloader;

// download info
@property (readwrite, strong) NSString* destination;

- (NSString*) downloadFolder;
- (NSString*) downloadFolderName;
- (NSString*) baseFolder;

// actions

- (FLFinisher*) startSyncingGroupList:(FLResultBlock) completionBlock;

- (FLFinisher*) startDownload:(FLResultBlock) completionBlock;

- (FLFinisher*) resumeDownload:(ZFBatchPhotoDownloadOperation*) downloader 
                    completion:(FLResultBlock) completionBlock;


@end

@protocol ZFDownloaderSessionObserver <NSObject>
- (void) downloaderUserContext:(ZFDownloaderSession*) userContext downloadStarted:(ZFBatchPhotoDownloadOperation*) downloader;
- (void) downloaderUserContext:(ZFDownloaderSession*) userContext downloadFinished:(ZFBatchPhotoDownloadOperation*) downloader withError:(NSError*) error;
@end

