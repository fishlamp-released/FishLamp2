//
//  FLZenfolioLoadPhotoSetFromCacheOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 11/3/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZenfolioLoadPhotoSetFromCacheOperation.h"
#import "FLZenfolioCacheService.h"
#import "FLZenfolioSyncService.h"
#import "FLZenfolioHttpRequest.h"

@implementation FLZenfolioLoadPhotoSetFromCacheOperation

- (id) initWithPhotoSetId:(int) photoSetId 
                   textCn:(int) textCn
              photoListCn:(int) photoListCn {
	if((self = [super init])) {
        _photoSetID = photoSetId;
    	_textCn = textCn;
        _photoListCn = photoListCn;
    }
	
	return self;
}

- (id) loadObjectFromDatabase {

    FLZenfolioCacheService* service = [self.context cacheService];
    FLZenfolioPhotoSet* photoSet = [service loadPhotoSetWithID:_photoSetID];
    
    self.alwaysRunSubOperations = 
            photoSet && 
            [photoSet isStaleComparedTo:_textCn photoListCn:_photoListCn photoCount:-1];

    return photoSet;
}

- (FLResult) runSubOperations {

    FLHttpRequest* request = [FLZenfolioHttpRequest loadPhotoSetHttpRequest:[NSNumber numberWithInt:_photoSetID]];

    return FLConfirmResultType([request sendSynchronouslyInContext:self.context], FLZenfolioPhotoSet);
}

- (void) saveObjectToDatabase:(id) object {
    FLZenfolioCacheService* cache = [self.context cacheService];
    [cache savePhotoSet:object];
}

@end