////
////  FLZenfolioLoadGroupsFromCache.m
////  FishLamp
////
////  Created by Mike Fullerton on 10/13/12.
////  Copyright (c) 2012 Mike Fullerton. All rights reserved.
////
//
//#import "FLZenfolioLoadGroupsFromCacheOperation.h"
//
//#import "FLZenfolioCache.h"
//#import "FLZenfolioWebApi.h"
//
//@interface FLZenfolioLoadGroupsFromCacheOperation ()
//@end
//
//@implementation FLZenfolioLoadGroupsFromCacheOperation
//
//- (id) initWithGroupList:(NSArray*) groupList {
//    self = [super init];
//    if(self) {
//        _groupList = [groupList copy];
//    }
//    
//    return self;
//}
//
//
//#if FL_NO_ARC
//- (void) dealloc {
//    [_groupList release];
//    [super dealloc];
//}
//#endif
//
//- (FLResult) runOperation {
//    
//    NSMutableArray* outputList = [NSMutableArray array];
//    for(NSNumber* idObject in _groupList) {
//        [self abortIfNeeded];
//		
//		FLZenfolioGroup* group = [[self.userContext objectCache] loadGroupWithID:idObject.intValue];
//		if(group)  {	
//			[outputList addObject:group];
//		}
//	}
//    
//    return outputList;
//}
//
//@end

