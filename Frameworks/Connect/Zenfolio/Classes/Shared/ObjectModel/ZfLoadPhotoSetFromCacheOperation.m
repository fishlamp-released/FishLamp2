//
//  ZFLoadPhotoSetFromCacheOperation.m
//  ZenLib
//
//  Created by Mike Fullerton on 11/3/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "ZFLoadPhotoSetFromCacheOperation.h"
#import "ZFCacheService.h"
#import "ZFSyncService.h"
#import "ZFHttpRequest.h"

@implementation ZFLoadPhotoSetFromCacheOperation

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

    ZFCacheService* service = [self.context cacheService];
    ZFPhotoSet* photoSet = [service loadPhotoSetWithID:_photoSetID];
    
    self.alwaysRunSubOperations = 
            photoSet && 
            [photoSet isStaleComparedTo:_textCn photoListCn:_photoListCn photoCount:-1];

    return photoSet;
}

- (FLResult) runSubOperations {

    FLHttpRequest* request = [ZFHttpRequest loadPhotoSetHttpRequest:[NSNumber numberWithInt:_photoSetID]];

    return FLConfirmResultType([request sendSynchronouslyInContext:self.context], ZFPhotoSet);
}

- (void) saveObjectToDatabase:(id) object {
    ZFCacheService* cache = [self.context cacheService];
    [cache savePhotoSet:object];
}

@end