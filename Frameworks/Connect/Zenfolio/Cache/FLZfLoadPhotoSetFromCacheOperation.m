//
//  FLZfLoadPhotoSetFromCacheOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 11/3/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZfLoadPhotoSetFromCacheOperation.h"
#import "FLZfCacheService.h"
#import "FLZfSyncService.h"
#import "FLZfHttpRequest.h"

@implementation FLZfLoadPhotoSetFromCacheOperation

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

    FLZfCacheService* service = [self.context cacheService];
    FLZfPhotoSet* photoSet = [service loadPhotoSetWithID:_photoSetID];
    
    self.alwaysRunSubOperations = 
            photoSet && 
            [photoSet isStaleComparedTo:_textCn photoListCn:_photoListCn photoCount:-1];

    return photoSet;
}

- (FLResult) runSubOperations {

    FLHttpRequest* request = [FLZfHttpRequest loadPhotoSetHttpRequest:[NSNumber numberWithInt:_photoSetID]];

    return FLConfirmResultType([request sendSynchronouslyInContext:self.context], FLZfPhotoSet);
}

- (void) saveObjectToDatabase:(id) object {
    FLZfCacheService* cache = [self.context cacheService];
    [cache savePhotoSet:object];
}

@end