//
//  ZFBatchDownloadOperation.h
//  Zenfolio Downloader
//
//  Created by Mike Fullerton on 2/27/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLSynchronousOperation.h"
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

@interface ZFBatchDownloadOperation : FLSynchronousOperation {
@private
    ZFGroup* _rootGroup;
    NSString* _destinationPath;
    NSSet* _photoSetIDs; 
    NSArray* _mediaTypes;
    ZFDownloadState_t _state;
    NSTimeInterval _lastProgress;
    
    BOOL _downloadImages;
    BOOL _downloadVideos;
}

+ (id) downloadOperation:(NSSet*) photoSetIDs 
               rootGroup:(ZFGroup*) rootGroup
         destinationPath:(NSString*) destinationPath
              mediaTypes:(NSArray*) mediaTypes;
@end

#define ZFDownloadedPhotoKey @"photo"
#define ZFDownloadedPhotoSetKey @"photoSet"
#define ZFDownloadedImageKey @"image"
#define ZFDownloadedDestinationPathKey @"path"
#define ZFDownloadFolderKey @"folder"
#define ZFDownloadPhotoErrorKey @"error"

@protocol ZFBatchDownloadOperationObserver <NSObject>
- (void) downloadOperation:(ZFBatchDownloadOperation*) operation updateDownloadInfo:(ZFDownloadState*) downloadInfo;

@optional

- (void) downloadOperationWillBeginDownload:(ZFBatchDownloadOperation*) operation;
- (void) downloadOperation:(ZFBatchDownloadOperation*) operation didFinishWithResult:(FLResult) result;

- (void) downloadOperation:(ZFBatchDownloadOperation*) operation willUpdatePhotoSet:(ZFPhotoSet*) photoSet;
- (void) downloadOperation:(ZFBatchDownloadOperation*) operation didUpdatePhotoSet:(ZFPhotoSet*) photoSet;

// these are called per photo set
- (void) downloadOperation:(ZFBatchDownloadOperation*) operation willStartDownloadingPhotosInPhotoSet:(NSDictionary*) downloadInfo;
- (void) downloadOperation:(ZFBatchDownloadOperation*) operation willDownloadPhoto:(NSDictionary*) downloadInfo;
- (void) downloadOperation:(ZFBatchDownloadOperation*) operation didSkipPhoto:(NSDictionary*) downloadInfo;
- (void) downloadOperation:(ZFBatchDownloadOperation*) operation didDownloadPhoto:(NSDictionary*) downloadInfo;
- (void) downloadOperation:(ZFBatchDownloadOperation*) operation didDownloadPhotosInPhotoSet:(NSDictionary*) downloadInfo;

@end