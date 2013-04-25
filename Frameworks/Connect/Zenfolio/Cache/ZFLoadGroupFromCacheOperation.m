////
////  FLLoadGroupFromCacheOperation.m
////  FishLamp
////
////  Created by Mike Fullerton on 11/3/12.
////  Copyright (c) 2012 Mike Fullerton. All rights reserved.
////
//
//#import "ZFLoadGroupFromCacheOperation.h"
//#import "ZFCacheService.h"
//#import "ZFWebApi.h"
//
//@implementation ZFLoadGroupFromCacheOperation
//
//- (id) initWithGroupId:(int) groupId {
//	if((self = [super init])) {
//        _groupID = groupId;
//	}
//	
//	return self;
//}
//
//- (id) loadObjectFromDatabase {
//    return [[self.userContext objectCache] loadGroupWithID:_groupID];
//}
//
//- (void) saveObjectToDatabase:(id) object {
//    [[self.userContext objectCache] writeObject:object];
//}
//
//- (id<FLAsyncResult>) runSubOperations {
//    
//    FLHttpRequest* request = [ZFHttpRequestFactory loadGroupHttpRequest:[NSNumber numberWithInt:_groupID] 
//                                                           level:kZenfolioInformatonLevelFull 
//                                                 includeChildren:YES];
//
//    return [self runChildSynchronously:request];
//}
//
//
//@end

