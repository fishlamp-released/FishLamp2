//
//  ZFPhotoSetDownloader.m
//  FishLampConnect
//
//  Created by Mike Fullerton on 4/20/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "ZFPhotoSetDownloader.h"
#import "ZFAsyncObserving.h"

@interface ZFPhotoSetDownloader ()
@property (readwrite, strong, nonatomic) NSNumber* photoSetID;
@end

@implementation ZFPhotoSetDownloader
@synthesize photoSetID = _photoSetID;


- (id) initWithPhotoSetID:(NSNumber*) photoSetID withPhotos:(BOOL) withPhotos {	
	self = [super init];
	if(self) {
		self.photoSetID = photoSetID;
        _withPhotos = withPhotos;
    }
	return self;
}

+ (id) downloadPhotoSet:(NSNumber*) photoSetID withPhotos:(BOOL) withPhotos {
    return FLAutorelease([[[self class] alloc] initWithPhotoSetID:photoSetID withPhotos:withPhotos]);
}

- (ZFPhotoSet*) loadCachedPhotoSet {
    ZFPhotoSet* inputPhotoSet = [ZFPhotoSet photoSet];
    inputPhotoSet.IdValue = _photoSetID; 
    return [self.storageService readObject:inputPhotoSet];
}

- (void) downloadLatestPhotoSet {

    FLHttpRequest* request = [ZFHttpRequestFactory loadPhotoSetHttpRequest:_photoSetID 
                                                                     level:kZenfolioInformatonLevelFull 
                                                             includePhotos:_withPhotos];

    [self runChildAsynchronously:request completion:^(id<FLAsyncResult> result) {
        if([result didSucceed]) {
            [self.storageService writeObject:result.returnedObject];
        }

        [self setFinishedWithResult:result];
    }];
}

- (void) downloadMinimalPhotoSet {
    FLHttpRequest* request = [ZFHttpRequestFactory loadPhotoSetHttpRequest:_photoSetID 
                                                                     level:kZenfolioInformatonLevelLevel1 
                                                             includePhotos:NO];

    [self runChildAsynchronously:request completion:^(id<FLAsyncResult> result) {
        if([result didFail]) {
            [self setFinishedWithResult:result];
        }
        else {
            ZFPhotoSet* downloaded = result.returnedObject;
            ZFPhotoSet* cached = [self loadCachedPhotoSet];
            if( !cached || 
                [cached isStaleComparedToPhotoSet:downloaded] || 
                (_withPhotos && !cached.photosAreDownloaded)) {
                [self downloadLatestPhotoSet];
            }
            else {
                [self setFinishedWithResult:[cached asAsyncResult]];
            }
        }
    }];
}

- (id) startAsyncOperation {
    
#if TRACE
    FLLog(@"starting async queue processing: %@", self);
#endif

    ZFPhotoSet* photoSet = [self loadCachedPhotoSet];
    if(!photoSet || (_withPhotos && !photoSet.photosAreDownloaded)) {
        [self downloadLatestPhotoSet];
    }
    else {
        [self downloadMinimalPhotoSet];
    }
    return photoSet;
}

- (void) sendStartMessagesWithInitialData:(id) initialData {
    [self.observer receiveObservation:@selector(willDownloadPhotoSet:photoSetID:) withObject:initialData withObject:self.photoSetID];
}

- (void) sendFinishMessagesWithResult:(id<FLAsyncResult>) result {
    [self.observer receiveObservation:@selector(didDownloadPhotoSetWithResult:) withObject:result];
}



@end
