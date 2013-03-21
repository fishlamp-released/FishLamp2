//
//  FLZenfolioDownloadOperation.h
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
    
} FLZenfolioDownloadState_t;

@interface FLZenfolioDownloadState : NSObject<NSCopying> {
@private
    FLZenfolioDownloadState_t _values;
}
@property (readonly, assign, nonatomic) FLZenfolioDownloadState_t values;
@end

@interface FLZenfolioDownloadOperation : FLOperation {
@private
    FLZenfolioGroup* _rootGroup;
    
    NSString* _destinationPath;
    NSMutableArray* _photoSets; 
    BOOL _downloadVideos;
    BOOL _downloadImages;
    
    FLZenfolioDownloadState_t _state;
    
    NSTimeInterval _lastProgress;
}

+ (id) downloadOperation:(NSArray*) photoSets 
               rootGroup:(FLZenfolioGroup*) rootGroup
           objectStorage:(id<FLObjectStorage>) storage 
         destinationPath:(NSString*) destinationPath
          downloadVideos:(BOOL) downloadVideos
          downloadImages:(BOOL) downloadImages;

@property (readonly, assign, nonatomic) BOOL downloadVideos;
@property (readonly, assign, nonatomic) BOOL downloadImages;
@property (readonly, copy, nonatomic) NSArray* photoSets;
@property (readonly, copy, nonatomic) NSString* destinationPath;
@end

#define ZFDownloadedPhotoKey @"photo"
#define ZFDownloadedPhotoSetKey @"photoSet"
#define ZFDownloadedImageKey @"image"
#define ZFDownloadedDestinationPathKey @"path"
#define ZFDownloadFolderKey @"folder"
#define ZFDownloadPhotoErrorKey @"error"

@protocol FLZenfolioDownloadOperationObserver <NSObject>
- (void) downloadOperation:(FLZenfolioDownloadOperation*) operation updateDownloadInfo:(FLZenfolioDownloadState*) downloadInfo;

@optional

- (void) downloadOperationWillBeginDownload:(FLZenfolioDownloadOperation*) operation;
- (void) downloadOperation:(FLZenfolioDownloadOperation*) operation didFinishWithResult:(FLResult) result;

- (void) downloadOperation:(FLZenfolioDownloadOperation*) operation willUpdatePhotoSet:(FLZenfolioPhotoSet*) photoSet;
- (void) downloadOperation:(FLZenfolioDownloadOperation*) operation didUpdatePhotoSet:(FLZenfolioPhotoSet*) photoSet;

// these are called per photo set
- (void) downloadOperation:(FLZenfolioDownloadOperation*) operation willStartDownloadingPhotosInPhotoSet:(NSDictionary*) downloadInfo;
- (void) downloadOperation:(FLZenfolioDownloadOperation*) operation willDownloadPhoto:(NSDictionary*) downloadInfo;
- (void) downloadOperation:(FLZenfolioDownloadOperation*) operation didSkipPhoto:(NSDictionary*) downloadInfo;
- (void) downloadOperation:(FLZenfolioDownloadOperation*) operation didDownloadPhoto:(NSDictionary*) downloadInfo;
- (void) downloadOperation:(FLZenfolioDownloadOperation*) operation didDownloadPhotosInPhotoSet:(NSDictionary*) downloadInfo;

@end