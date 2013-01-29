//
//  FLLoadGroupFromCacheOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 11/3/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLLoadGroupFromCacheOperation.h"
#import "FLZfCacheService.h"

@implementation FLZfLoadGroupFromCacheOperation

- (id) initWithGroupId:(int) groupId {
	if((self = [super init])) {
        _groupID = groupId;
	}
	
	return self;
}

- (id) loadObjectFromDatabase {
    return [[self.context cacheService] loadGroupWithID:_groupID];
}

- (void) saveObjectToDatabase:(id) object {
    [[self.context cacheService] saveGroup:object];
}

- (FLResult) runSubOperations {
    
    FLHttpRequest* request = [FLZfHttpRequest loadGroupHttpRequest:[NSNumber numberWithInt:_groupID] 
                                                           level:kZfInformatonLevelFull 
                                                 includeChildren:YES];

    return [request sendSynchronouslyInContext:self.context];
}


@end