//
//  FLZenfolioDownloadOperation.m
//  Zenfolio Downloader
//
//  Created by Mike Fullerton on 2/27/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLZenfolioDownloadOperation.h"
#import "FLZenfolioWebApi.h"
#import "FLImageFolder.h"
#import "FLZenfolioDownloadImageHttpRequest.h"

@interface FLZenfolioDownloadState ()
@property (readwrite, assign, nonatomic) FLZenfolioDownloadState_t values;
@end

@implementation FLZenfolioDownloadState  
@synthesize values = _values;

- (id) copyWithZone:(NSZone*) zone {
    FLZenfolioDownloadState* copy = [[FLZenfolioDownloadState alloc] init];
    copy.values = self.values;
    return copy;
}

- (id) initWithState:(FLZenfolioDownloadState_t) state {	
	self = [super init];
	if(self) {
		_values = state;
	}
	return self;
}

+ (id) downloadState:(FLZenfolioDownloadState_t) state {
    return FLAutorelease([[[self class] alloc] initWithState:state]);
}

@end

@interface FLZenfolioDownloadOperation ()
@property (readwrite, strong, nonatomic) id<FLObjectStorage> objectStorage;
@property (readwrite, strong, nonatomic) FLZenfolioGroup* rootGroup;
@property (readwrite, copy, nonatomic) NSArray* photoSets;
@property (readwrite, copy, nonatomic) NSString* destinationPath;
@property (readwrite, assign, nonatomic) BOOL downloadVideos;
@property (readwrite, assign, nonatomic) BOOL downloadImages;
@end

@implementation FLZenfolioDownloadOperation  

@synthesize photoSets = _photoSets;
@synthesize destinationPath = _destinationPath;
@synthesize downloadVideos = _downloadVideos;
@synthesize downloadImages = _downloadImages;
@synthesize rootGroup = _rootGroup;

+ (id) downloadOperation:(NSArray*) photoSets 
               rootGroup:(FLZenfolioGroup*) rootGroup 
           objectStorage:(id<FLObjectStorage>) objectStorage 
         destinationPath:(NSString*) destinationPath 
        downloadVideos:(BOOL) downloadVideos
         downloadImages:(BOOL) downloadImages {
    
    FLAssertNotNil(objectStorage);
    FLAssertNotNil(rootGroup);
    FLAssertNotNil(photoSets);
    FLAssertNotNil(destinationPath);
    
    FLZenfolioDownloadOperation* operation = FLAutorelease([[[self class] alloc] initWithObjectStorage:objectStorage]);
    operation.rootGroup = rootGroup;
    operation.photoSets = photoSets;
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

- (NSString*) relativePathForPhotoSet:(FLZenfolioPhotoSet*) photoSet {
    
    NSArray* path = [_rootGroup pathComponentsToGroupElement:photoSet];
    NSString* pathString = @"";
    for(id element in path) {
        pathString = [pathString stringByAppendingPathComponent:[element Title]];
    }

    return pathString;
}

- (FLImageFolder*) createFolderForPhotoSet:(FLZenfolioPhotoSet*) photoSet {
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

            [self sendMessage:@selector(downloadOperation:updateDownloadInfo:) 
                           toListener:self.observer 
                           withObject:[FLZenfolioDownloadState downloadState:_state]];

            _lastProgress = now;
        }
    });

}

- (FLZenfolioPhotoSet*) downloadLatestPhotoSet:(FLZenfolioPhotoSet*) photoSet {


    FLHttpRequest* request = [FLZenfolioHttpRequest loadPhotoSetHttpRequest:photoSet.Id level:kZenfolioInformatonLevelFull includePhotos:YES];
    FLZenfolioPhotoSet* latestPhotoSet = FLThrowIfError([self.workerContext runWorker:request withObserver:nil]);
    FLAssertNotNil(latestPhotoSet);
    
    return latestPhotoSet;
}

- (FLResult) downloadPhoto:(FLZenfolioPhoto*) photo
           imageFolder:(FLImageFolder*) imageFolder {
           
    FLZenfolioDownloadImageHttpRequest* request = 
        [FLZenfolioDownloadImageHttpRequest downloadImageHttpRequest:photo 
                                                           imageSize:[FLZenfolioImageSize originalImageSize] 
                                                               cache:nil];

    request.networkStreamSink = [FLFileStreamSink fileStreamSink:[NSURL fileURLWithPath:[imageFolder pathForFile:photo.FileName]]];
                                                               
    return FLThrowIfError([self.workerContext runWorker:request withObserver:self]);
}

- (void) httpRequest:(FLHttpRequest*) httpRequest didReadBytes:(NSNumber*) amount {
    _state.currentPhotoBytes += [amount longLongValue];
    _state.byteCount += [amount longLongValue];
    [self updateProgress:YES];
}

- (FLResult) downloadPhotoToFile:(FLZenfolioPhoto*) photo
           imageFolder:(FLImageFolder*) imageFolder {
    FLHttpRequest* request = 
        [FLHttpRequest httpRequest:[photo urlForImageWithSize:[FLZenfolioImageSize originalImageSize]]];

    request.networkStreamSink = [FLFileStreamSink fileStreamSink:[NSURL fileURLWithPath:[imageFolder pathForFile:photo.FileName]]];
                                                               
    return FLThrowIfError([self.workerContext runWorker:request withObserver:self]);

}

- (BOOL) willDownloadPhoto:(FLZenfolioPhoto*) photo {
    return ( (photo.IsVideoValue && self.downloadVideos) || (!photo.IsVideoValue && self.downloadImages));
}

- (void) downloadPhotosInPhotoSet:(FLZenfolioPhotoSet*) photoSet imageFolder:(FLImageFolder*) imageFolder {
    [self abortIfNeeded];
    
    for(FLZenfolioPhoto* photo in photoSet.Photos) {
        [self abortIfNeeded];
        if(![self willDownloadPhoto:photo]) {
            continue;
        }
        
        NSMutableDictionary* info = [[NSMutableDictionary alloc] init];
        @try {
            NSString* pathToContent = [imageFolder pathForFile:photo.FileName];
            
            [info setObject:photo forKey:ZFDownloadedPhotoKey];
            [info setObject:pathToContent forKey:ZFDownloadedDestinationPathKey];
        
            [self sendMessage:@selector(downloadOperation:willDownloadPhoto:) 
                           toListener:self.observer 
                           withObject:info];

            if([imageFolder fileExistsInFolder:photo.FileName]) {
            
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
                
                [self sendMessage:@selector(downloadOperation:didSkipPhoto:) 
                               toListener:self.observer 
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
            
                [self sendMessage:@selector(downloadOperation:didDownloadPhoto:) 
                               toListener:self.observer 
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

- (void) updateNumbers:(NSArray*) photoSets {
    _state.photoSetTotal = _photoSets.count;
    _state.videoTotal = 0;
    _state.photoTotal = 0;
    _state.byteTotal = 0;
    
    for(FLZenfolioPhotoSet* set in photoSets) {
        for(FLZenfolioPhoto* photo in set.Photos) {
            if(self.downloadVideos && photo.IsVideoValue) {
                _state.videoTotal++;
                _state.byteTotal += photo.SizeValue;
            }
            if(self.downloadImages && !photo.IsVideoValue) {
                _state.photoTotal++;
                _state.byteTotal += photo.SizeValue;
            }
        }
    }
}

- (FLResult) runOperationInContext:(id) context withObserver:(id) observer {

    FLAssertNotNil(self.rootGroup);

    memset(&_state, 0, sizeof(FLZenfolioDownloadState_t));

    NSMutableArray* photoSets = [NSMutableArray array];

    [self sendMessage:@selector(downloadOperationWillBeginDownload:) toListener:self.observer];
    [self updateNumbers:photoSets];
    [self updateProgress:YES];
    
    for(NSUInteger i = 0; i < _photoSets.count; i++) {
        
        FLZenfolioPhotoSet* photoSet = [_photoSets objectAtIndex:i];
        
        [self sendMessage:@selector(downloadOperation:willUpdatePhotoSet:)
                       toListener:self.observer 
                       withObject:photoSet];

        photoSet = [self downloadLatestPhotoSet:photoSet];
        FLAssertNotNil(photoSet);
    
        [self.objectStorage writeObject:photoSet];
        [photoSets addObject:photoSet];
    
    // first update the photoset
        
        [self updateNumbers:photoSets];
        [self updateProgress:YES];
        [self abortIfNeeded];

        [self sendMessage:@selector(downloadOperation:didUpdatePhotoSet:)
                       toListener:observer 
                       withObject:photoSet];
    }
   
    _state.startedTime = [NSDate timeIntervalSinceReferenceDate];
   
    // now start downloading all the photos and videos 

    for(FLZenfolioPhotoSet* photoSet in photoSets) {
    
        FLImageFolder* imageFolder = [self createFolderForPhotoSet:photoSet];
    
        NSMutableDictionary* info = [NSMutableDictionary dictionary];
        [info setObject:photoSet forKey:ZFDownloadedPhotoSetKey];
        [info setObject:imageFolder forKey:ZFDownloadFolderKey];

        [self sendMessage:@selector(downloadOperation:willStartDownloadingPhotosInPhotoSet:) toListener:observer withObject:info];

        [self downloadPhotosInPhotoSet:photoSet imageFolder:imageFolder];

        [self sendMessage:@selector(downloadOperation:didDownloadPhotosInPhotoSet:) toListener:observer withObject:info];

        _state.photoSetCount++;

        [self updateProgress:YES];
        [self abortIfNeeded];
    }
    
    [self updateProgress:NO];
    [self sendMessage:@selector(downloadOperation:didFinishWithResult:) toListener:observer withObject:photoSets];
    
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
