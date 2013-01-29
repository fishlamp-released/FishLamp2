//
//  FLZfDownloaderSession.h
//  Downloader
//
//  Created by Mike Fullerton on 11/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLService.h"

#import "FLZfHttpRequest.h"
#import "FLZfImageDownloadingService.h"

#import "FLZfBatchPhotoDownloadOperation.h"
#import "FLZfUserContext.h"
#import "FLZfGroupElementSelection.h"

//	[string] parent path of the download folder, set by user
//	The default path is ~/Desktop.
extern NSString * const FLZfBaseFolder;

//	[int] the average download speed during the previous session in kB/S
//	The default value is 0.
extern NSString * const FLZfDownloadSpeed;


@interface FLZfDownloaderSession : FLZfUserContext {
@private
    NSString* _destination;
    FLZfImageDownloadingService* _imageDownloader;
    FLZfGroupElementSelection* _selection;
}

//@property (readwrite, assign) BOOL loading;
//@property (readonly, strong, nonatomic) NSString* downloadFolder;
//@property (readonly, strong, nonatomic) NSString* downloadFolderName;
//@property (readonly, strong, nonatomic) NSArray* selectedPhotoSets;
//@property (readonly, assign, nonatomic) long long selectionSize;
@property (readwrite, strong) FLZfGroupElementSelection* selection;
@property (readwrite, strong) FLZfImageDownloadingService* imageDownloader;

// download info
@property (readwrite, strong) NSString* destination;

- (NSString*) downloadFolder;
- (NSString*) downloadFolderName;
- (NSString*) baseFolder;

// actions

- (FLFinisher*) startSyncingGroupList:(FLResultBlock) completionBlock;

- (FLFinisher*) startDownload:(FLResultBlock) completionBlock;

- (FLFinisher*) resumeDownload:(FLZfBatchPhotoDownloadOperation*) downloader 
                    completion:(FLResultBlock) completionBlock;


@end

@protocol FLZfDownloaderSessionObserver <NSObject>
- (void) downloaderUserContext:(FLZfDownloaderSession*) userContext downloadStarted:(FLZfBatchPhotoDownloadOperation*) downloader;
- (void) downloaderUserContext:(FLZfDownloaderSession*) userContext downloadFinished:(FLZfBatchPhotoDownloadOperation*) downloader withError:(NSError*) error;
@end

