//
//  FLZenfolioDownloadOperation.h
//  Zenfolio Downloader
//
//  Created by Mike Fullerton on 2/27/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLOperation.h"

@interface FLZenfolioDownloadState : NSObject<NSCopying>
+ (id) downloadState;
@property (readonly, assign, nonatomic) NSUInteger videoCount;
@property (readonly, assign, nonatomic) NSUInteger photoSetCount;
@property (readonly, assign, nonatomic) NSUInteger photoCount;
@property (readonly, assign, nonatomic) NSUInteger videoTotal;
@property (readonly, assign, nonatomic) NSUInteger photoSetTotal;
@property (readonly, assign, nonatomic) NSUInteger photoTotal;
@property (readonly, assign, nonatomic) unsigned long long byteCount;
@property (readonly, assign, nonatomic) unsigned long long byteTotal;
@end

@interface FLZenfolioDownloadOperation : FLOperation

@property (readwrite, assign, nonatomic) BOOL downloadVideos;
@property (readwrite, assign, nonatomic) BOOL downloadImages;

@property (readwrite, copy, nonatomic) FLZenfolioGroup* rootGroup;
@property (readwrite, copy, nonatomic) NSArray* photoSets;
@property (readwrite, copy, nonatomic) NSString* destinationPath;
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