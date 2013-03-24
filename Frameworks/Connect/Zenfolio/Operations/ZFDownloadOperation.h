//
//  ZFDownloadOperation.h
//  Zenfolio Downloader
//
//  Created by Mike Fullerton on 2/27/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLOperation.h"
#import "FLObjectStorage.h"

typedef struct {
    NSUInteger videoCount;
    NSUInteger videoTotal;
    NSUInteger photoCount;
    NSUInteger photoTotal;
    NSUInteger photoSetCount;
    NSUInteger photoSetTotal;
    unsigned long long byteTotal;
    unsigned long long byteCount;
    NSTimeInterval startedTime;
    
    NSTimeInterval downloadingTime;
    unsigned long long downloadedBytes;
    unsigned long long currentPhotoBytes;
    
} ZFDownloadState_t;

@interface ZFDownloadState : NSObject<NSCopying> {
@private
    ZFDownloadState_t _values;
}
+ (id) downloadState;

@property (readonly, assign, nonatomic) ZFDownloadState_t values;
@end

@interface ZFDownloadOperation : FLOperation {
@private
    ZFGroup* _rootGroup;
    NSString* _destinationPath;
    NSSet* _photoSetIDs; 

    BOOL _downloadVideos;
    BOOL _downloadImages;
    ZFDownloadState_t _state;
    NSTimeInterval _lastProgress;
}

+ (id) downloadOperation:(NSSet*) photoSetIDs 
               rootGroup:(ZFGroup*) rootGroup
           objectStorage:(id<FLObjectStorage>) storage 
         destinationPath:(NSString*) destinationPath
          downloadVideos:(BOOL) downloadVideos
          downloadImages:(BOOL) downloadImages;
@end

#define ZFDownloadedPhotoKey @"photo"
#define ZFDownloadedPhotoSetKey @"photoSet"
#define ZFDownloadedImageKey @"image"
#define ZFDownloadedDestinationPathKey @"path"
#define ZFDownloadFolderKey @"folder"
#define ZFDownloadPhotoErrorKey @"error"

@protocol ZFDownloadOperationObserver <NSObject>
- (void) downloadOperation:(ZFDownloadOperation*) operation updateDownloadInfo:(ZFDownloadState*) downloadInfo;

@optional

- (void) downloadOperationWillBeginDownload:(ZFDownloadOperation*) operation;
- (void) downloadOperation:(ZFDownloadOperation*) operation didFinishWithResult:(FLResult) result;

- (void) downloadOperation:(ZFDownloadOperation*) operation willUpdatePhotoSet:(ZFPhotoSet*) photoSet;
- (void) downloadOperation:(ZFDownloadOperation*) operation didUpdatePhotoSet:(ZFPhotoSet*) photoSet;

// these are called per photo set
- (void) downloadOperation:(ZFDownloadOperation*) operation willStartDownloadingPhotosInPhotoSet:(NSDictionary*) downloadInfo;
- (void) downloadOperation:(ZFDownloadOperation*) operation willDownloadPhoto:(NSDictionary*) downloadInfo;
- (void) downloadOperation:(ZFDownloadOperation*) operation didSkipPhoto:(NSDictionary*) downloadInfo;
- (void) downloadOperation:(ZFDownloadOperation*) operation didDownloadPhoto:(NSDictionary*) downloadInfo;
- (void) downloadOperation:(ZFDownloadOperation*) operation didDownloadPhotosInPhotoSet:(NSDictionary*) downloadInfo;

@end