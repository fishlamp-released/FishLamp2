//
//  FLPrepareDownloadQueueOperation.m
//  FishLampConnect
//
//  Created by Mike Fullerton on 4/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLPrepareDownloadQueueOperation.h"
#import "FLHttpRequest.h"
#import "FLImageFolder.h"

#import "ZFHttpRequestFactory.h"
#import "ZFDownloadQueue.h"

@interface FLPrepareDownloadQueueOperation ()
@property (readwrite, strong, nonatomic) ZFBatchDownloadSpec* downloadSpec; 
@property (readwrite, strong, nonatomic) ZFGroup* rootGroup;
@end

@implementation FLPrepareDownloadQueueOperation

@synthesize downloadSpec = _downloadSpec;
@synthesize rootGroup = _rootGroup;

- (id) initWithDownloadSpec:(ZFBatchDownloadSpec*) downloadSpec {	
	self = [super init];
	if(self) {
		self.downloadSpec = downloadSpec;
	}
	return self;
}

+ (id) prepareDownloadQueueOperation:(ZFBatchDownloadSpec*) downloadSpec {
    return FLAutorelease([[[self class] alloc] initWithDownloadSpec:downloadSpec]);
}


#if FL_MRC
- (void) dealloc {
	[_downloadSpec release];
    [_rootGroup release];
	[super dealloc];
}
#endif

- (ZFPhotoSet*) downloadLatestPhotoSet:(ZFPhotoSet*) photoSet {
    FLHttpRequest* request = [ZFHttpRequestFactory loadPhotoSetHttpRequest:photoSet.Id level:kZenfolioInformatonLevelFull includePhotos:YES];

    FLResult latestPhotoSet = [self runChildSynchronously:request];
    
    FLThrowIfError(latestPhotoSet);
    
    return latestPhotoSet;
}

- (NSString*) relativePathForPhotoSet:(ZFPhotoSet*) photoSet {
    
    NSArray* path = [_rootGroup pathComponentsToGroupElement:photoSet];
    NSString* pathString = @"";
    for(id element in path) {
        pathString = [pathString stringByAppendingPathComponent:[element Title]];
    }

    return pathString;
}

- (FLResult) performSynchronously {

    FLAssertNotNil(self.objectStorage);

    self.rootGroup = [self.objectStorage readObject:[ZFGroup group:[NSNumber numberWithInt:_downloadSpec.rootGroupID]]]; 
    FLAssertNotNil(_rootGroup);

    _downloadVideos = NO;
    _downloadImages = NO;
    
    for(ZFMediaType* type in _downloadSpec.mediaTypes) {
        if(type.mediaTypeID == ZFMediaTypeVideo) {
            _downloadVideos = YES;
        }
        if(type.mediaTypeID == ZFMediaTypeOriginalImage) {
            _downloadImages = YES;
        }
    }

    ZFDownloadQueue* queue = [ZFDownloadQueue downloadQueue];

//    _state.photoSetTotal = _downloadSpec.photoSets.count;
//    _state.videoTotal = 0;
//    _state.photoTotal = 0;
//    _state.byteTotal = 0;

    for(NSNumber* photoSetID in _downloadSpec.photoSets) {
        
        ZFPhotoSet* inputPhotoSet = [ZFPhotoSet photoSet];
        inputPhotoSet.Id = photoSetID; 
        ZFPhotoSet* photoSet = [self.objectStorage readObject:inputPhotoSet];
        if(!photoSet) {
            photoSet = [_rootGroup subElementForID:photoSetID.intValue];
        }
        if(!photoSet) {
            continue;
        }
        
//        [self sendObservation:@selector(downloadOperation:willUpdatePhotoSet:)
//               withObject:photoSet];

        photoSet = [self downloadLatestPhotoSet:photoSet];
        FLAssertNotNil(photoSet);
    
//        FLImageFolder* imageFolder = [self createFolderForPhotoSet:photoSet];

        NSString* folderPath = [_downloadSpec.destinationPath stringByAppendingPathComponent:[self relativePathForPhotoSet:photoSet]];

        for(ZFPhoto* photo in photoSet.Photos) {

            ZFMediaType* mediaType = nil;
            if(_downloadVideos && photo.IsVideoValue) {
                mediaType = [ZFMediaType originalImage];
            }
            else if(_downloadImages && !photo.IsVideoValue) {
                mediaType = [ZFMediaType video];
            }
            else { 
                continue;
            }

            ZFDownloadSpec* download = [ZFDownloadSpec downloadSpec:photo];
            download.mediaType = mediaType;
            NSString* fileName = [mediaType humanReadableFileNameForPhoto:photo inPhotoSet:photoSet];
            download.fileName = fileName;
            download.destinationPath = [folderPath stringByAppendingPathComponent:fileName];
            download.hiddenFolderPath = [folderPath stringByAppendingPathComponent:@".download"];
            download.rootGroupID = self.downloadSpec.rootGroupID;
            download.photoSetID = photoSet.IdValue;
            
            [queue addObject:download];
            
            [self abortIfNeeded];
        }
        
        [self.objectStorage writeObject:photoSet];
        
    // first update the photoset
        
//        [self updateProgress:YES];
        [self abortIfNeeded];

//        [self sendObservation:@selector(downloadOperation:didUpdatePhotoSet:)
//                       withObject:photoSet];
    }
    
    return queue;
}

@end
