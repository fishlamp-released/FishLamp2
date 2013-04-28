//
//  ZFPhotoDownloaderQueue.m
//  FishLampConnect
//
//  Created by Mike Fullerton on 4/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "ZFPhotoDownloaderQueue.h"

//@interface ZFPhotoDownloaderQueue ()
//@property (readwrite, strong) ZFBatchDownloadSpec* downloadSpec; 
//@end

@implementation ZFPhotoDownloaderQueue

- (id) initWithArrayOfDownloadSpecs:(NSArray*) arrayOfDownloadSpecs {
	self = [super initWithQueuedObjects:arrayOfDownloadSpecs];
	if(self) {
            
	}
	return self;
}

+ (id) photoDownloaderQueue:(NSArray*) arrayOfDownloadSpecs {
    return FLAutorelease([[[self class] alloc] initWithArrayOfDownloadSpecs:arrayOfDownloadSpecs]);
}

- (void) photoDownloader:(ZFPhotoDownloader*) downloader 
                didReadBytes:(FLHttpRequestByteCount*) amount 
                forPhoto:(ZFDownloadSpec*) downloadSpec {
    [self.delegate performOptionalSelector:@selector(photoDownloader:didReadBytes:forPhoto:) 
                       withObject:downloader 
                       withObject:amount 
                       withObject:downloadSpec];
}        

        

//@synthesize downloadSpec = _downloadSpec;
//
//- (id) initWithArrayOfDownloadSpecs:(NSArray*) photos{	
//	
//    self = [super initWithQueuedObjects:photos];
//	if(self) {
//		self.downloadSpec = downloadSpec;
//        
//        _downloadVideos = NO;
//        _downloadImages = NO;
//        
//        for(ZFMediaType* type in _downloadSpec.mediaTypes) {
//            if(type.mediaTypeID == ZFMediaTypeVideo) {
//                _downloadVideos = YES;
//            }
//            if(type.mediaTypeID == ZFMediaTypeOriginalImage) {
//                _downloadImages = YES;
//            }
//        }
//	}
//	return self;
//}
//
//+ (id) photoDownloadQueue:(NSArray*) photos
//                downloadSpec:(ZFBatchDownloadSpec*) downloadSpec {
//    return FLAutorelease([[[self class] alloc] initWithArrayOfDownloadSpecs:photos batchDownloadSpec:downloadSpec]);
//}
//
//#if FL_MRC
//- (void) dealloc {
//	[_downloadSpec release];
//    [super dealloc];
//}
//#endif

//- (void) didProcessAllObjectsInAsyncQueue {
//    [self.transferState setFinished];
//    [super didProcessAllObjectsInAsyncQueue];
//    [self updateProgress:NO];
//}

//- (void) photoDownloader:(ZFPhotoDownloader*) download 
//   didDownloadPhotoBytes:(NSNumber*) amount {
//   
//   FLPerformSelector3(self.delegate, @selector(photoDownloadQueue:photoDownloader:didDownloadBytes:), self, downloader, amount);
//   
////    self.transferState.byteCount += [amount longValue];
////
////    double bps = [httpRequest bytesPerSecond];
////    if(bps) {
////        self.transferState.bytesPerSecondTotal += httpRequest.bytesPerSecond;
////        self.transferState.bytesPerSecondCountForAveraging++; 
////    }
////    
////    [self updateProgress:YES];
//}

//- (void) updateCountsForMediaType:(ZFMediaType*) mediaType {
//    if(mediaType.mediaTypeID == ZFMediaTypeVideo) {
//        self.transferState.videoCount++;
//    }
//    else {
//        self.transferState.photoCount++;
//    }
//}

//- (void) photoDownloaderDidSkipPhoto:(ZFPhotoDownloader*) downloader {
//    self.transferState.byteTotal += downloader.downloadSpec.photo.SizeValue;
//    [self updateCountsForMediaType:downloader.downloadSpec.mediaType];
//    FLPerformSelector2(self.delegate, @selector(batchPhotoDownloader:didSkipPhoto:), self, downloader.downloadSpec);
//    [self updateProgress:YES];
//}

//- (void) photoDownloaderDidDownloadPhoto:(ZFPhotoDownloader*) downloader {
//    [self updateCountsForMediaType:downloader.downloadSpec.mediaType];
//
//    FLPerformSelector2(self.delegate, @selector(batchPhotoDownloader:didDownloadPhoto:), self, downloader.downloadSpec);
//    [self updateProgress:YES];
//}
//
//- (void) willStartDownloadingPhoto:(ZFPhotoDownloader *)operation {
//}
//
//- (void) didFinishOperationInAsyncQueue:(id)operation withResult:(FLPromisedResult)result {
//
//}
//
//
//- (void) willStartOperationInAsyncQueue:(id)operation {
//    FLPerformSelector2(self.delegate, @selector(batchPhotoDownloader:willDownloadPhoto:), self, [operation downloadSpec]);
//    [self updateProgress:YES];
//}

- (FLOperation*) createOperationForObject:(ZFDownloadSpec*) downloadSpec {
    return [ZFPhotoDownloader photoDownloader:downloadSpec];
    
//    FLHttpRequestDelegateSelectors selectors = downloader.delegateSelectors;
////    selectors.willOpen = @selector(willStartDownloadingPhoto:);
////    selectors.didReadBytes = @selector(photoDownloader:didDownloadPhotoBytes:);
////    downloader.delegate = self;
////    downloader.delegateSelectors = selectors;
////    
//    return downloader;
}     


@end
