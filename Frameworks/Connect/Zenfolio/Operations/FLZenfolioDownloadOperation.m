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
@property (readwrite, assign, nonatomic) NSUInteger videoCount;
@property (readwrite, assign, nonatomic) NSUInteger photoSetCount;
@property (readwrite, assign, nonatomic) NSUInteger photoCount;
@property (readwrite, assign, nonatomic) NSUInteger videoTotal;
@property (readwrite, assign, nonatomic) NSUInteger photoSetTotal;
@property (readwrite, assign, nonatomic) NSUInteger photoTotal;
@property (readwrite, assign, nonatomic) unsigned long long byteCount;
@property (readwrite, assign, nonatomic) unsigned long long byteTotal;
@end

@implementation FLZenfolioDownloadState  
@synthesize photoCount = _photoCount;
@synthesize videoCount = _videoCount;
@synthesize byteCount = _byteCount;
@synthesize photoSetCount = _photoSetCount;
@synthesize photoTotal = _photoTotal;
@synthesize videoTotal = _videoTotal;
@synthesize byteTotal = _byteTotal;
@synthesize photoSetTotal = _photoSetTotal;

- (id) copyWithZone:(NSZone*) zone {
    FLZenfolioDownloadState* copy = [[FLZenfolioDownloadState alloc] init];
    copy.photoCount = self.photoCount;
    copy.videoCount = self.videoCount;
    copy.byteCount = self.byteCount;
    copy.photoSetCount = self.photoSetCount;
    copy.photoTotal = self.photoTotal;
    copy.videoTotal = self.videoTotal;
    copy.byteTotal = self.byteTotal;
    copy.photoSetTotal = self.photoSetTotal;
    return copy;
}

+ (id) downloadState {
    return FLAutorelease([[[self class] alloc] init]);
}

@end

@interface FLZenfolioDownloadOperation ()
@property (readwrite, strong, nonatomic) FLZenfolioDownloadState* state;
@end

@implementation FLZenfolioDownloadOperation  

@synthesize rootGroup = _rootGroup;
@synthesize photoSets = _photoSets;
@synthesize destinationPath = _destinationPath;
@synthesize downloadVideos = _downloadVideos;
@synthesize downloadImages = _downloadImages;
@synthesize state = _state;

#if FL_MRC
- (void) dealloc {
    [_state release];
    [_destinationPath release];
    [_rootGroup release];
    [_photoSets release];
    [super dealloc];
}
#endif

- (void) setPhotoSets:(NSArray*) selection {
    FLSetObjectWithMutableCopy(_photoSets, selection);
}

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

- (void) updateProgress:(id) observer {
    [self sendMessage:@selector(downloadOperation:updateDownloadInfo:) 
                   toListener:observer 
                   withObject:FLAutorelease([_state copy])];
}

- (FLZenfolioPhotoSet*) downloadLatestPhotoSet:(FLZenfolioPhotoSet*) photoSet inContext:(id) context withObserver:(id) observer {


    FLHttpRequest* request = [FLZenfolioHttpRequest loadPhotoSetHttpRequest:photoSet.Id level:kZenfolioInformatonLevelFull includePhotos:YES];
    FLZenfolioPhotoSet* latestPhotoSet = FLThrowIfError([context runWorker:request withObserver:nil]);
    FLAssertNotNil_(latestPhotoSet);
    
    return latestPhotoSet;
}

- (FLResult) downloadPhoto:(FLZenfolioPhoto*) photo
           imageFolder:(FLImageFolder*) imageFolder 
             inContext:(id) context 
              observer:(id) observer {

    FLZenfolioDownloadImageHttpRequest* request = 
        [FLZenfolioDownloadImageHttpRequest downloadImageHttpRequest:photo 
                                                           imageSize:[FLZenfolioImageSize originalImageSize] 
                                                               cache:nil];

    request.networkStreamSink = [FLFileStreamSink fileStreamSink:[NSURL fileURLWithPath:[imageFolder pathForFile:photo.FileName]]];
                                                               
    return FLThrowIfError([context runWorker:request withObserver:nil]);
}

- (FLResult) downloadPhotoToFile:(FLZenfolioPhoto*) photo
           imageFolder:(FLImageFolder*) imageFolder 
             inContext:(id) context 
              observer:(id) observer {

    FLHttpRequest* request = 
        [FLHttpRequest httpRequest:[photo urlForImageWithSize:[FLZenfolioImageSize originalImageSize]]];

    request.networkStreamSink = [FLFileStreamSink fileStreamSink:[NSURL fileURLWithPath:[imageFolder pathForFile:photo.FileName]]];
                                                               
    return FLThrowIfError([context runWorker:request withObserver:nil]);

}

- (BOOL) willDownloadPhoto:(FLZenfolioPhoto*) photo {
    return ( (photo.IsVideoValue && self.downloadVideos) || (!photo.IsVideoValue && self.downloadImages));
}

- (void) downloadPhotosInPhotoSet:(FLZenfolioPhotoSet*) photoSet imageFolder:(FLImageFolder*) imageFolder inContext:(id) context observer:(id) observer {
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
                           toListener:observer 
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
                               toListener:observer 
                               withObject:info];
            }
            else {
                [self abortIfNeeded];
                
                FLResult result = nil;
                if(photo.IsVideoValue) {
                    if(self.downloadVideos) {
                        result  = [self downloadPhotoToFile:photo imageFolder:imageFolder inContext:context observer:observer];
                        _state.videoCount++;
                    }
                }
                else {
                    if(self.downloadImages) {
                        result  = [self downloadPhotoToFile:photo imageFolder:imageFolder inContext:context observer:observer];
                        _state.photoCount++;
                    }
                }
                
                if([result error]) {
                    [info setObject:[result error] forKey:ZFDownloadPhotoErrorKey];
                }

                [self abortIfNeeded];
            
                [self sendMessage:@selector(downloadOperation:didDownloadPhoto:) 
                               toListener:observer 
                               withObject:info];
            }
            
            _state.byteCount += photo.SizeValue;

            [self updateProgress:observer];
        }
        @catch(NSException* ex) {
            @throw;
        }
        @finally {
            FLRelease(info);
        }
    }
}

- (void) updateNumbers {
    _state.photoSetTotal = _photoSets.count;
    _state.videoTotal = 0;
    _state.photoTotal = 0;
    _state.byteTotal = 0;
    
    for(FLZenfolioPhotoSet* set in _photoSets) {
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

    FLAssertNotNil_(self.rootGroup);

    self.state = [FLZenfolioDownloadState downloadState];

    [self sendMessage:@selector(downloadOperationWillBeginDownload:) toListener:observer];
    [self updateNumbers];
    [self updateProgress:observer];

    for(NSUInteger i = 0; i < _photoSets.count; i++) {
        
        FLZenfolioPhotoSet* photoSet = [_photoSets objectAtIndex:i];
        
        [self sendMessage:@selector(downloadOperation:willUpdatePhotoSet:)
                       toListener:observer 
                       withObject:photoSet];

        photoSet = [self downloadLatestPhotoSet:photoSet inContext:context withObserver:observer];
        FLAssertNotNil_(photoSet);
    
    // first update the photoset
        [_photoSets replaceObjectAtIndex:i withObject:photoSet];
        [self.rootGroup replaceGroupElement:photoSet];
        
        [self updateNumbers];
        [self updateProgress:observer];
        [self abortIfNeeded];

        [self sendMessage:@selector(downloadOperation:didUpdatePhotoSet:)
                       toListener:observer 
                       withObject:photoSet];
    }
   
    // now start downloading all the photos and videos 

    for(NSUInteger i = 0; i < _photoSets.count; i++) {
        FLZenfolioPhotoSet* photoSet = [_photoSets objectAtIndex:i];
    
        FLImageFolder* imageFolder = [self createFolderForPhotoSet:photoSet];
    
        NSMutableDictionary* info = [NSMutableDictionary dictionary];
        [info setObject:photoSet forKey:ZFDownloadedPhotoSetKey];
        [info setObject:imageFolder forKey:ZFDownloadFolderKey];

        [self sendMessage:@selector(downloadOperation:willStartDownloadingPhotosInPhotoSet:) toListener:observer withObject:info];

        [self downloadPhotosInPhotoSet:photoSet imageFolder:imageFolder inContext:context observer:observer];

        [self sendMessage:@selector(downloadOperation:didDownloadPhotosInPhotoSet:) toListener:observer withObject:info];

        _state.photoSetCount++;

        [self updateProgress:observer];
        [self abortIfNeeded];
    }
    
    [self updateProgress:observer];
    [self sendMessage:@selector(downloadOperation:didFinishWithResult:) toListener:observer withObject:_photoSets];
    
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
