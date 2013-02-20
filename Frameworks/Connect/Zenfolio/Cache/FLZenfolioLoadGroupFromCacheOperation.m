////
////  FLLoadGroupFromCacheOperation.m
////  FishLamp
////
////  Created by Mike Fullerton on 11/3/12.
////  Copyright (c) 2012 Mike Fullerton. All rights reserved.
////
//
//#import "FLZenfolioLoadGroupFromCacheOperation.h"
//#import "FLZenfolioCacheService.h"
//#import "FLZenfolioWebApi.h"
//
//@implementation FLZenfolioLoadGroupFromCacheOperation
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
//- (FLResult) runSubOperations {
//    
//    FLHttpRequest* request = [FLZenfolioHttpRequest loadGroupHttpRequest:[NSNumber numberWithInt:_groupID] 
//                                                           level:kZenfolioInformatonLevelFull 
//                                                 includeChildren:YES];
//
//    return [self sendHttpRequest:request];
//}
//
//
//@end

