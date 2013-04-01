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

@interface ZFDownloadState ()
@property (readwrite, assign, nonatomic) ZFDownloadState_t values;
@end

@implementation ZFDownloadState  
@synthesize values = _values;

- (id) copyWithZone:(NSZone*) zone {
    ZFDownloadState* copy = [[ZFDownloadState alloc] init];
    copy.values = self.values;
    return copy;
}

- (id) initWithState:(ZFDownloadState_t) state {	
	self = [super init];
	if(self) {
		_values = state;
	}
	return self;
}

- (id) init {	
	self = [super init];
	if(self) {
		memset(&_values, 0, sizeof(ZFDownloadState_t));
	}
	return self;
}

+ (id) downloadState:(ZFDownloadState_t) state {
    return FLAutorelease([[[self class] alloc] initWithState:state]);
}

+ (id) downloadState {
    return FLAutorelease([[[self class] alloc] init]);
}

@end

@interface ZFBatchDownloadOperation ()
@property (readwrite, strong, nonatomic) ZFGroup* rootGroup;
@property (readwrite, copy, nonatomic) NSSet* photoSets;
@property (readwrite, copy, nonatomic) NSString* destinationPath;
@property (readwrite, strong, nonatomic) NSArray* mediaTypes;
@end

@implementation ZFBatchDownloadOperation  

@synthesize photoSets = _photoSetIDs;
@synthesize destinationPath = _destinationPath;
@synthesize mediaTypes = _mediaTypes;
@synthesize rootGroup = _rootGroup;

+ (id) downloadOperation:(NSSet*) photoSetIDs 
               rootGroup:(ZFGroup*) rootGroup 
         destinationPath:(NSString*) destinationPath 
              mediaTypes:(NSArray*) mediaTypes {
    
    FLAssertNotNil(rootGroup);
    FLAssertNotNil(photoSetIDs);
    FLAssertNotNil(destinationPath);
    
    ZFBatchDownloadOperation* operation = FLAutorelease([[[self class] alloc] init]);
    operation.rootGroup = rootGroup;
    operation.photoSets = photoSetIDs;
    operation.destinationPath = destinationPath;
    operation.mediaTypes = mediaTypes;
    return operation;
}


#if FL_MRC
- (void) dealloc {
    [_mediaTypes release];
    [_rootGroup release];
    [_destinationPath release];
    [_photoSetIDs release];
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
    NSString* folderPath = [self.destinationPath stringByAppendingPathComponent:[self relativePathForPhotoSet:photoSet]];
    
//        BOOL isDir = NO;
//        if(![[NSFileManager defaultManager] fileExistsAtPath:folderPath isDirectory:&isDir]) {
//        
    NSError* err = nil;
    if(![[NSFileManager defaultManager] createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:&err]) {
        // TODO: can't create dir
    } 
    
    if(err) {
        // TODO: continue if "already exists"
        
        FLThrowIfError(err);
    }
    
    return [FLImageFolder folderWithPath:folderPath];
}

- (void) updateProgress:(BOOL) canDefer {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
        if(!canDefer || ([NSDate timeIntervalSinceReferenceDate] - _lastProgress) > 0.3) {

            [self sendObservation:@selector(downloadOperation:updateDownloadInfo:) 
                           withObject:[ZFDownloadState downloadState:_state]];

            _lastProgress = now;
        }
    });

}

//- (NSString*) downloadFileNameForPhoto:(ZFPhoto*) photo {
//    NSMutableString* name = [NSMutableString stringWithFormat:@"%@-%@", [photo.FileName stringByDeletingPathExtension], [photo Id]]; //, [photo.Sequence];
//            
//    if(FLStringIsNotEmpty(photo.Sequence)) {
//        [name appendFormat:@"-%@", photo.Sequence];
//    }
//    
//    [name appendFormat:@".%@", [photo.FileName pathExtension]];
//    return name;        
//}

- (ZFPhotoSet*) downloadLatestPhotoSet:(ZFPhotoSet*) photoSet {


    FLHttpRequest* request = [ZFHttpRequest loadPhotoSetHttpRequest:photoSet.Id level:kZenfolioInformatonLevelFull includePhotos:YES];
    ZFPhotoSet* latestPhotoSet = [self runChildSynchronously:request];
    FLAssertNotNil(latestPhotoSet);
    
    return latestPhotoSet;
}

//- (FLResult) downloadPhoto:(ZFPhoto*) photo
//             withImageSize:(ZFMediaType*) imageSize
//               imageFolder:(FLImageFolder*) imageFolder {
//           
//    ZFDownloadImageHttpRequest* request = 
//        [ZFDownloadImageHttpRequest downloadImageHttpRequest:photo 
//                                                           imageSize:imageSize 
//                                                               cache:nil];
//
//    request.inputSink = [FLFileSink fileSink:[NSURL fileURLWithPath:[imageFolder pathForFile:photo.FileName]]];
//    request.asyncObserver = self;
//                                                               
//    return [self runChildSynchronously:request];
//}

- (void) httpRequest:(FLHttpRequest*) httpRequest didReadBytes:(NSNumber*) amount {
    _state.currentPhotoBytes += [amount longLongValue];
    _state.byteCount += [amount longLongValue];
    [self updateProgress:YES];
}

- (FLResult) downloadPhotoToFile:(ZFPhoto*) photo 
                        filePath:(NSString*) filePath {

    FLHttpRequest* request = 
        [FLHttpRequest httpRequest:[photo urlForImageWithSize:[ZFMediaType originalImage]]];

    request.inputSink = [FLHiddenFolderFileSink hiddenFolderFileSink:[NSURL fileURLWithPath:filePath] folderURL:[NSURL fileURLWithPath:[self.destinationPath stringByAppendingPathComponent:@".downloader"] isDirectory:YES]];

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
    _state.downloadingTime += elapsedTime;
    _state.downloadedBytes += _state.currentPhotoBytes;
//    _state.downloadedBytes += photo.SizeValue;
    FLLog(@"downloaded %ld, expected: %ld, elapsed time: %f", _state.currentPhotoBytes, photo.SizeValue, elapsedTime);
    
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
        for(ZFMediaType* media in _mediaTypes) {
            [self abortIfNeeded];
            
            if( ((media.mediaTypeID == ZFMediaTypeVideo) && photo.IsVideoValue) ||
                ((media.mediaTypeID != ZFMediaTypeVideo) && !photo.IsVideoValue)) {

                NSString* fileName = [media humanReadableFileNameForPhoto:photo];
                
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
    _state.photoSetTotal = _photoSetIDs.count;
    _state.videoTotal = 0;
    _state.photoTotal = 0;
    _state.byteTotal = 0;

    for(NSNumber* photoSetID in _photoSetIDs) {
        
        ZFPhotoSet* inputPhotoSet = [ZFPhotoSet photoSet];
        inputPhotoSet.Id = photoSetID; 
        ZFPhotoSet* photoSet = [self.objectStorage readObject:inputPhotoSet];
        if(!photoSet) {
            photoSet = [self.rootGroup subElementForID:photoSetID.intValue];
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

    for(NSNumber* photoSetID in _photoSetIDs) {
    
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

    FLAssertNotNil(self.rootGroup);

    memset(&_state, 0, sizeof(ZFDownloadState_t));

    _downloadVideos = NO;
    _downloadImages = NO;
    
    for(ZFMediaType* type in _mediaTypes) {
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
    [self sendObservation:@selector(downloadOperation:didFinishWithResult:)];
    
    return _photoSetIDs;
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
