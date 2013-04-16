//
//  ZFBatchDownloadOperation.m
//  Zenfolio Downloader
//
//  Created by Mike Fullerton on 2/27/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "ZFBatchDownloadOperation.h"
#import "ZFWebApi.h"
#import "FLImageFolder.h"
#import "ZFDownloadImageHttpRequest.h"
#import "FLFileSink.h"
#import "FLHiddenFolderFileSink.h"


@interface ZFBatchDownloadOperation ()
@property (readwrite, copy, nonatomic) NSURL* downloadFolderURL;
@property (readwrite, copy, nonatomic) ZFBatchDownloadSpec* downloadSpec;
@end

@implementation ZFBatchDownloadOperation  

@synthesize downloadFolderURL = _downloadFolderURL;
@synthesize downloadSpec = _downloadSpec;

- (id) initWithDownloadSpec:(ZFBatchDownloadSpec*) spec {	
	self = [super init];
	if(self) {
        FLAssert(spec.rootGroupID != 0);
        FLAssertNotNil(spec.photoSets);
        FLAssertNotNil(spec.destinationPath);
		self.downloadSpec = spec;
        self.downloadFolderURL = [NSURL fileURLWithPath:[spec.destinationPath stringByAppendingPathComponent:@".download"] isDirectory:YES];
	}
	return self;
}

+ (id) downloadOperation:(ZFBatchDownloadSpec*) downloadSpec {
    return FLAutorelease([[[self class] alloc] initWithDownloadSpec:downloadSpec]);
}

//+ (id) downloadOperation:(NSSet*) photoSetIDs 
//               rootGroup:(ZFGroup*) rootGroup 
//         destinationPath:(NSString*) destinationPath 
//      downloadFolderName:(NSString*) downloadFolderName
//              mediaTypes:(NSArray*) mediaTypes {
//    
//    FLAssertNotNil(rootGroup);
//    FLAssertNotNil(photoSetIDs);
//    FLAssertNotNil(destinationPath);
//    
//    ZFBatchDownloadOperation* operation = FLAutorelease([[[self class] alloc] init]);
//    operation.rootGroup = rootGroup;
//    operation.photoSets = photoSetIDs;
//    operation.destinationPath = destinationPath;
//    operation.mediaTypes = mediaTypes;
//    operation.downloadFolderURL = [NSURL fileURLWithPath:[destinationPath stringByAppendingPathComponent:downloadFolderName] isDirectory:YES];
//    return operation;
//}


#if FL_MRC
- (void) dealloc {
    [_downloadSpec release];
    [_downloadFolderURL release];
    [super dealloc];
}
#endif

- (NSString*) relativePathForPhotoSet:(ZFPhotoSet*) photoSet {
    
    NSArray* path = [_rootGroup pathComponentsToGroupElement:photoSet];
    NSString* pathString = @"";
    for(id element in path) {
        pathString = [pathString stringByAppendingPathComponent:[element Title]];
    }

    return pathString;
}

- (FLImageFolder*) createFolderForPhotoSet:(ZFPhotoSet*) photoSet {
    NSString* folderPath = [_downloadSpec.destinationPath stringByAppendingPathComponent:[self relativePathForPhotoSet:photoSet]];
    
    NSError* err = nil;
    if(![[NSFileManager defaultManager] createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:&err]) {
        // TODO: can't create dir
    } 
    
    FLThrowIfError(err);
    
    return [FLImageFolder folderWithPath:folderPath];
}

- (void) updateProgress:(BOOL) canDefer {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
        if(!canDefer || ([NSDate timeIntervalSinceReferenceDate] - _lastProgress) > 0.3) {

            [self sendObservation:@selector(downloadOperation:updateDownloadInfo:) 
                           withObject:[ZFTransferState transferState:_state]];

            _lastProgress = now;
        }
    });

}

- (ZFPhotoSet*) downloadLatestPhotoSet:(ZFPhotoSet*) photoSet {


    FLHttpRequest* request = [ZFHttpRequestFactory loadPhotoSetHttpRequest:photoSet.Id level:kZenfolioInformatonLevelFull includePhotos:YES];

    ZFPhotoSet* latestPhotoSet = [self runChildSynchronously:request];
    FLAssertNotNil(latestPhotoSet);
    
    return latestPhotoSet;
}

- (void) httpRequest:(FLHttpRequest*) httpRequest didReadBytes:(NSNumber*) amount {
    _state.currentPhotoBytes += [amount longLongValue];
    _state.byteCount += [amount longLongValue];
    [self updateProgress:YES];
}

- (FLResult) downloadPhotoToFile:(ZFPhoto*) photo 
                        filePath:(NSString*) filePath {

    FLHttpRequest* request = 
        [FLHttpRequest httpRequest:[photo urlForImageWithSize:[ZFMediaType originalImage]]];

    request.inputSink = [FLHiddenFolderFileSink hiddenFolderFileSink:[NSURL fileURLWithPath:filePath] 
                                                           folderURL:self.downloadFolderURL];

    request.asyncObserver = self;
                                                               
    return [self runChildSynchronously:request];

}

- (BOOL) willDownloadPhoto:(ZFPhoto*) photo {
    return ( (photo.IsVideoValue && _downloadVideos) || (!photo.IsVideoValue && _downloadImages));
}

- (void) updateCountsForMediaType:(ZFMediaType*) mediaType {
    if(mediaType.mediaTypeID == ZFMediaTypeVideo) {
        _state.videoCount++;
    }
    else {
        _state.photoCount++;
    }
}

- (void) mediaExists:(ZFMediaType*) mediaType forPhoto:(ZFPhoto*) photo filePath:(NSString*) filePath {
    NSMutableDictionary* info = [NSMutableDictionary dictionary];
    [info setObject:photo forKey:ZFDownloadedPhotoKey];
    [info setObject:filePath forKey:ZFDownloadedDestinationPathKey];
        
    [self sendObservation:@selector(downloadOperation:willDownloadPhoto:) withObject:info];
    [self updateCountsForMediaType:mediaType];
    [self sendObservation:@selector(downloadOperation:didSkipPhoto:) withObject:info];
    
}

- (void) downloadMedia:(ZFMediaType*) mediaType 
              forPhoto:(ZFPhoto*) photo 
              filePath:(NSString*) filePath
              fileName:(NSString*) fileName {

    NSMutableDictionary* info = [NSMutableDictionary dictionary];
    [info setObject:photo forKey:ZFDownloadedPhotoKey];
    [info setObject:filePath forKey:ZFDownloadedDestinationPathKey];

    
    _state.currentPhotoBytes = 0;

    NSTimeInterval downloadStart = [NSDate timeIntervalSinceReferenceDate];
    
    FLResult result = [self downloadPhotoToFile:photo filePath:filePath];
    
    NSTimeInterval elapsedTime = ([NSDate timeIntervalSinceReferenceDate] - downloadStart);

    [self abortIfNeeded];

    // for accurute download speed caculations
    _state.transferTime += elapsedTime;
    _state.transferredBytes += _state.currentPhotoBytes;

#if TRACE
    FLLog(@"downloaded %ld, expected: %ld, elapsed time: %f", _state.currentPhotoBytes, photo.SizeValue, elapsedTime);
#endif
    
    // fix the total byte count so we don't mess up progress.
    _state.byteCount -= _state.currentPhotoBytes;
    _state.currentPhotoBytes = 0;
    _state.byteCount += photo.SizeValue; 

    [self abortIfNeeded];

    [self updateCountsForMediaType:mediaType];

    if([result error]) {
        [info setObject:[result error] forKey:ZFDownloadPhotoErrorKey];
    }
    
    [self sendObservation:@selector(downloadOperation:didDownloadPhoto:) withObject:info];
}

- (void) downloadPhotosInPhotoSet:(ZFPhotoSet*) photoSet imageFolder:(FLImageFolder*) imageFolder {
    [self abortIfNeeded];
    
    for(ZFPhoto* photo in photoSet.Photos) {
        for(ZFMediaType* media in _downloadSpec.mediaTypes) {
            [self abortIfNeeded];
            
            NSError* error = nil;
            [[NSFileManager defaultManager] createDirectoryAtPath:imageFolder.folderPath withIntermediateDirectories:YES attributes:nil error:&error];
            FLThrowIfError(error);
            
            if( ((media.mediaTypeID == ZFMediaTypeVideo) && photo.IsVideoValue) ||
                ((media.mediaTypeID != ZFMediaTypeVideo) && !photo.IsVideoValue)) {

                NSString* fileName = [media humanReadableFileNameForPhoto:photo inPhotoSet:photoSet];
                
                if([imageFolder fileExistsInFolder:fileName]) {
                    [self mediaExists:media 
                             forPhoto:photo 
                             filePath:[imageFolder pathForFile:fileName]];
                }
                else {
                    [self downloadMedia:media 
                               forPhoto:photo 
                               filePath:[imageFolder pathForFile:fileName]
                               fileName:fileName];
                }
                
                [self updateProgress:YES];
            }
        }
    }
}


- (void) updatePhotoSets {
    _state.photoSetTotal = _downloadSpec.photoSets.count;
    _state.videoTotal = 0;
    _state.photoTotal = 0;
    _state.byteTotal = 0;

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
        
        [self sendObservation:@selector(downloadOperation:willUpdatePhotoSet:)
               withObject:photoSet];

        photoSet = [self downloadLatestPhotoSet:photoSet];
        FLAssertNotNil(photoSet);
    
        for(ZFPhoto* photo in photoSet.Photos) {
        
            if(_downloadVideos && photo.IsVideoValue) {
                _state.videoTotal++;
                _state.byteTotal += photo.SizeValue;
            }

            if(_downloadImages && !photo.IsVideoValue) {
                _state.photoTotal++;
                _state.byteTotal += photo.SizeValue;
            }
            
            [self abortIfNeeded];
        }
        
        [self.objectStorage writeObject:photoSet];
        
    // first update the photoset
        
        [self updateProgress:YES];
        [self abortIfNeeded];

        [self sendObservation:@selector(downloadOperation:didUpdatePhotoSet:)
                       withObject:photoSet];
    }
}

- (void) downloadPhotos {
    _state.startedTime = [NSDate timeIntervalSinceReferenceDate];
   
    // now start downloading all the photos and videos 

    for(NSNumber* photoSetID in _downloadSpec.photoSets) {
    
        ZFPhotoSet* inputPhotoSet = [ZFPhotoSet photoSet];
        inputPhotoSet.Id = photoSetID; 
        ZFPhotoSet* photoSet = [self.objectStorage readObject:inputPhotoSet];
        if(!photoSet) {
            continue;
        }

        FLImageFolder* imageFolder = [self createFolderForPhotoSet:photoSet];
    
        NSMutableDictionary* info = [NSMutableDictionary dictionary];
        [info setObject:photoSet forKey:ZFDownloadedPhotoSetKey];
        [info setObject:imageFolder forKey:ZFDownloadFolderKey];

        [self sendObservation:@selector(downloadOperation:willStartDownloadingPhotosInPhotoSet:) withObject:info];

        [self downloadPhotosInPhotoSet:photoSet imageFolder:imageFolder];

        [self sendObservation:@selector(downloadOperation:didDownloadPhotosInPhotoSet:) withObject:info];

        _state.photoSetCount++;

        [self updateProgress:YES];
        [self abortIfNeeded];
    }
}

- (FLResult) performSynchronously {

    FLSetObjectWithRetain(_rootGroup, [self.objectStorage readObject:[ZFGroup group:[NSNumber numberWithInt:_downloadSpec.rootGroupID]]]);
    FLAssertNotNil(_rootGroup);

    memset(&_state, 0, sizeof(ZFTransferState_t));

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

    [self sendObservation:@selector(downloadOperationWillBeginDownload:)];
    [self updateProgress:YES];

    [self updatePhotoSets];
    [self downloadPhotos];

    [self updateProgress:NO];
    
    return _downloadSpec.photoSets;
}

@end


////- (NSString *)downloadFolderName {
////	NSString *fmt  = @"Zenfolio Download %1m-%e-%Y";
////	NSString *name = [[NSCalendarDate date] descriptionWithCalendarFormat:fmt];
////	NSString *path = [[NSUserDefaults standardUserDefaults] stringForKey:ZFBaseFolder];
////	if ( !path ) {
////		return name;
////	}
////	
////	path = [path stringByAppendingPathComponent:name];
////	return [ZFUniquePath(path) lastPathComponent];
////}
