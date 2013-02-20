//
//  FLZenfolioLoadPhotoSetFromCacheOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 11/3/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZenfolioLoadPhotoSetFromCacheOperation.h"
#import "FLZenfolioCacheService.h"
#import "FLZenfolioWebApi.h"

//@implementation FLZenfolioLoadPhotoSetFromCacheOperation
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
//    FLZenfolioCacheService* service = [self.userContext objectCache];
//
//    FLZenfolioPhotoSet* photoSet = [service loadPhotoSetWithID:_photoSetID];
//    
//    self.alwaysRunSubOperations = 
//            photoSet && 
//            [photoSet isStaleComparedTo:_textCn photoListCn:_photoListCn photoCount:-1];
//
//    return photoSet;
//}
//
//- (FLResult) runSubOperations {
//
//    FLHttpRequest* request = [FLZenfolioHttpRequest loadPhotoSetHttpRequest:[NSNumber numberWithInt:_photoSetID]];
//
//    return FLConfirmResultType([self sendHttpRequest:request], FLZenfolioPhotoSet);
//}
//
//- (void) saveObjectToDatabase:(id) object {
//    [[self.userContext objectCache] writeObject:object];
//}
//
//@end

