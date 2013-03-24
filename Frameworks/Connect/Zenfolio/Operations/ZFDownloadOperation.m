//
//  ZFDownloadOperation.m
//  Zenfolio Downloader
//
//  Created by Mike Fullerton on 2/27/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "ZFDownloadOperation.h"
#import "ZFWebApi.h"
#import "FLImageFolder.h"
#import "ZFDownloadImageHttpRequest.h"

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

@interface ZFDownloadOperation ()
@property (readwrite, strong, nonatomic) ZFGroup* rootGroup;
@property (readwrite, copy, nonatomic) NSSet* photoSets;
@property (readwrite, copy, nonatomic) NSString* destinationPath;
@property (readwrite, assign, nonatomic) BOOL downloadVideos;
@property (readwrite, assign, nonatomic) BOOL downloadImages;
@end

@implementation ZFDownloadOperation  

@synthesize photoSets = _photoSets;
@synthesize destinationPath = _destinationPath;
@synthesize downloadVideos = _downloadVideos;
@synthesize downloadImages = _downloadImages;
@synthesize rootGroup = _rootGroup;

+ (id) downloadOperation:(NSSet*) photoSetIDs 
               rootGroup:(ZFGroup*) rootGroup 
           objectStorage:(id<FLObjectStorage>) objectStorage 
         destinationPath:(NSString*) destinationPath 
        downloadVideos:(BOOL) downloadVideos
         downloadImages:(BOOL) downloadImages {
    
    FLAssertNotNil(objectStorage);
    FLAssertNotNil(rootGroup);
    FLAssertNotNil(photoSetIDs);
    FLAssertNotNil(destinationPath);
    
    ZFDownloadOperation* operation = FLAutorelease([[[self class] alloc] initWithObjectStorage:objectStorage]);
    operation.rootGroup = rootGroup;
    operation.photoSets = photoSetIDs;
    operation.destinationPath = destinationPath;
    operation.downloadImages = downloadImages;
    operation.downloadVideos = downloadVideos;
    return operation;
}


#if FL_MRC
- (void) dealloc {
    [_rootGroup release];
    [_destinationPath release];
    [_photoSets release];
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

- (NSString*) downloadFileNameForPhoto:(ZFPhoto*) photo {
    NSMutableString* name = [NSMutableString stringWithFormat:@"%@-%@", [photo.FileName stringByDeletingPathExtension], [photo Id]]; //, [photo.Sequence];
            
    if(FLStringIsNotEmpty(photo.Sequence)) {
        [name appendFormat:@"-%@", photo.Sequence];
    }
    
    [name appendFormat:@".%@", [photo.FileName pathExtension]];
    return name;        
}

- (ZFPhotoSet*) downloadLatestPhotoSet:(ZFPhotoSet*) photoSet {


    FLHttpRequest* request = [ZFHttpRequest loadPhotoSetHttpRequest:photoSet.Id level:kZenfolioInformatonLevelFull includePhotos:YES];
    ZFPhotoSet* latestPhotoSet = FLThrowIfError([self.workerContext runWorker:request withObserver:nil]);
    FLAssertNotNil(latestPhotoSet);
    
    return latestPhotoSet;
}

- (FLResult) downloadPhoto:(ZFPhoto*) photo
           imageFolder:(FLImageFolder*) imageFolder {
           
    ZFDownloadImageHttpRequest* request = 
        [ZFDownloadImageHttpRequest downloadImageHttpRequest:photo 
                                                           imageSize:[ZFImageSize originalImageSize] 
                                                               cache:nil];

    request.networkStreamSink = [FLFileStreamSink fileStreamSink:[NSURL fileURLWithPath:[imageFolder pathForFile:photo.FileName]]];
                                                               
    return FLThrowIfError([self.workerContext runWorker:request withObserver:self]);
}

- (void) httpRequest:(FLHttpRequest*) httpRequest didReadBytes:(NSNumber*) amount {
    _state.currentPhotoBytes += [amount longLongValue];
    _state.byteCount += [amount longLongValue];
    [self updateProgress:YES];
}

- (FLResult) downloadPhotoToFile:(ZFPhoto*) photo
           imageFolder:(FLImageFolder*) imageFolder {
    FLHttpRequest* request = 
        [FLHttpRequest httpRequest:[photo urlForImageWithSize:[ZFImageSize originalImageSize]]];

    request.networkStreamSink = [FLFileStreamSink fileStreamSink:[NSURL fileURLWithPath:[imageFolder pathForFile:[self downloadFileNameForPhoto:photo]]]];
                                                               
    return FLThrowIfError([self.workerContext runWorker:request withObserver:self]);

}

- (BOOL) willDownloadPhoto:(ZFPhoto*) photo {
    return ( (photo.IsVideoValue && self.downloadVideos) || (!photo.IsVideoValue && self.downloadImages));
}

- (void) downloadPhotosInPhotoSet:(ZFPhotoSet*) photoSet imageFolder:(FLImageFolder*) imageFolder {
    [self abortIfNeeded];
    
    for(ZFPhoto* photo in photoSet.Photos) {
        [self abortIfNeeded];
        if(![self willDownloadPhoto:photo]) {
            continue;
        }
        
        NSMutableDictionary* info = [[NSMutableDictionary alloc] init];
        @try {
            NSString* pathToContent = [imageFolder pathForFile:[self downloadFileNameForPhoto:photo]];
            
            [info setObject:photo forKey:ZFDownloadedPhotoKey];
            [info setObject:pathToContent forKey:ZFDownloadedDestinationPathKey];
        
            [self sendObservation:@selector(downloadOperation:willDownloadPhoto:) 
                           withObject:info];

            if([imageFolder fileExistsInFolder:pathToContent]) {
            
                if(photo.IsVideoValue) {
                    if(self.downloadVideos) {
                        _state.videoCount++;
                    
                    }
                }
                else {
                    if(self.downloadImages) {
                        _state.photoCount++;
                    }
                }            
                
                [self sendObservation:@selector(downloadOperation:didSkipPhoto:) 
                               withObject:info];
            }
            else {
                [self abortIfNeeded];


                NSTimeInterval downloadStart = [NSDate timeIntervalSinceReferenceDate];

                _state.currentPhotoBytes = 0;

                FLResult result = nil;
                if(photo.IsVideoValue) {
                    if(self.downloadVideos) {
                        result  = [self downloadPhotoToFile:photo imageFolder:imageFolder];
                        _state.videoCount++;
                    }
                }
                else {
                    if(self.downloadImages) {
                        result  = [self downloadPhotoToFile:photo imageFolder:imageFolder];
                        _state.photoCount++;
                    }
                }

                _state.downloadingTime += ([NSDate timeIntervalSinceReferenceDate] - downloadStart);
                _state.downloadedBytes += _state.currentPhotoBytes;
                _state.byteCount -= _state.currentPhotoBytes;
                _state.currentPhotoBytes = 0;
                
                if([result error]) {
                    [info setObject:[result error] forKey:ZFDownloadPhotoErrorKey];
                }

                [self abortIfNeeded];
            
                [self sendObservation:@selector(downloadOperation:didDownloadPhoto:) 
                               withObject:info];
            }
            
            _state.byteCount += photo.SizeValue;

            [self updateProgress:YES];
        }
        @catch(NSException* ex) {
            @throw;
        }
        @finally {
            FLRelease(info);
        }
    }
}


- (void) updatePhotoSets {
    _state.photoSetTotal = _photoSets.count;
    _state.videoTotal = 0;
    _state.photoTotal = 0;
    _state.byteTotal = 0;

    for(NSNumber* photoSetID in _photoSetIDs) {
        
        ZFPhotoSet* inputPhotoSet = [ZFPhotoSet photoSet];
        inputPhotoSet.Id = photoSetID; 
        ZFPhotoSet* photoSet = [self.objectStorage readObject:inputPhotoSet];
        
        [self sendObservation:@selector(downloadOperation:willUpdatePhotoSet:)
               withObject:photoSet];

        photoSet = [self downloadLatestPhotoSet:photoSet];
        FLAssertNotNil(photoSet);
    
        for(ZFPhoto* photo in photoSet.Photos) {
            if(self.downloadVideos && photo.IsVideoValue) {
                _state.videoTotal++;
                _state.byteTotal += photo.SizeValue;
            }
            if(self.downloadImages && !photo.IsVideoValue) {
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

- (FLResult) runOperationInContext:(id) context withObserver:(id) observer {

    FLAssertNotNil(self.rootGroup);

    memset(&_state, 0, sizeof(ZFDownloadState_t));

    [self sendObservation:@selector(downloadOperationWillBeginDownload:)];
    [self updateProgress:YES];

    [self updatePhotoSets];
    [self downloadPhotos];

    [self updateProgress:NO];
    [self sendObservation:@selector(downloadOperation:didFinishWithResult:)];
    
    return _photoSets;
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
