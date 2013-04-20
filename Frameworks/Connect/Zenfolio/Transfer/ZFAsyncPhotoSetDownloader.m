//
//  ZFAsyncPhotoSetDownloader.m
//  FishLampConnect
//
//  Created by Mike Fullerton on 4/20/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "ZFAsyncPhotoSetDownloader.h"

@interface ZFAsyncPhotoSetDownloader ()
@property (readwrite, strong, nonatomic) NSNumber* photoSetID;
@end

@implementation ZFAsyncPhotoSetDownloader
@synthesize photoSetID = _photoSetID;


- (id) initWithPhotoSetID:(NSNumber*) photoSetID {	
	self = [super init];
	if(self) {
		self.photoSetID = photoSetID;
	}
	return self;
}

+ (id) downloadPhotoSet:(NSNumber*) photoSetID {
    return FLAutorelease([[[self class] alloc] initWithPhotoSetID:photoSetID]);
}

- (ZFPhotoSet*) loadCachedPhotoSet {
    ZFPhotoSet* inputPhotoSet = [ZFPhotoSet photoSet];
    inputPhotoSet.IdValue = _photoSetID; 
    return [self.objectStorage readObject:inputPhotoSet];
}

- (void) downloadLatestPhotoSet {

    FLHttpRequest* request = [ZFHttpRequestFactory loadPhotoSetHttpRequest:_photoSetID 
                                                                     level:kZenfolioInformatonLevelFull 
                                                             includePhotos:YES];

    [self runChildAsynchronously:request completion:^(FLResult result) {
        if(![result isErrorResult]) {
            [self.objectStorage writeObject:result];
        }

        [self setFinishedWithResult:result];
    }];
}

- (void) downloadMinimalPhotoSet {
    FLHttpRequest* request = [ZFHttpRequestFactory loadPhotoSetHttpRequest:_photoSetID 
                                                                     level:kZenfolioInformatonLevelLevel1 
                                                             includePhotos:NO];

    [self runChildAsynchronously:request completion:^(FLResult result) {
        if([result isErrorResult]) {
            [self setFinishedWithResult:result];
        }
        else {
            ZFPhotoSet* downloaded = result;
            ZFPhotoSet* cached = [self loadCachedPhotoSet];
            if(!cached || [cached isStaleComparedToPhotoSet:downloaded]) {
                [self downloadLatestPhotoSet];
            }
            else {
                [self setFinishedWithResult:cached];
            }
        }
    }];
}


- (void) performUntilFinished:(FLFinisher*) finisher {

    [super performUntilFinished:finisher];
    
#if TRACE
    FLLog(@"starting async queue processing: %@", self);
#endif

    ZFPhotoSet* photoSet = [self loadCachedPhotoSet];
    if(!photoSet) {
        [self downloadLatestPhotoSet];
    }
    else {
        [self downloadMinimalPhotoSet];
    }
}

@end
