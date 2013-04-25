//
//  ZFLoadPhotoSetFromCacheOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 11/3/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "ZFLoadPhotoSetFromCacheOperation.h"
#import "ZFCacheService.h"
#import "ZFWebApi.h"

//@implementation ZFLoadPhotoSetFromCacheOperation
//
//- (id) initWithPhotoSetId:(int) photoSetId 
//                   textCn:(int) textCn
//              photoListCn:(int) photoListCn {
//	if((self = [super init])) {
//        _photoSetID = photoSetId;
//    	_textCn = textCn;
//        _photoListCn = photoListCn;
//    }
//	
//	return self;
//}
//
//- (id) loadObjectFromDatabase {
//
//    ZFCacheService* service = [self.userContext objectCache];
//
//    ZFPhotoSet* photoSet = [service loadPhotoSetWithID:_photoSetID];
//    
//    self.alwaysRunSubOperations = 
//            photoSet && 
//            [photoSet isStaleComparedTo:_textCn photoListCn:_photoListCn photoCount:-1];
//
//    return photoSet;
//}
//
//- (id<FLAsyncResult>) runSubOperations {
//
//    FLHttpRequest* request = [ZFHttpRequestFactory loadPhotoSetHttpRequest:[NSNumber numberWithInt:_photoSetID]];
//
//    return FLConfirmResultType([self runChildSynchronously:request], ZFPhotoSet);
//}
//
//- (void) saveObjectToDatabase:(id) object {
//    [[self.userContext objectCache] writeObject:object];
//}
//
//@end

