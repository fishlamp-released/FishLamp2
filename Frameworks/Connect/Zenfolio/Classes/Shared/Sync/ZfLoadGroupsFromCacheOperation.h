//
//  ZFLoadGroupsFromCache.h
//  ZenLib
//
//  Created by Mike Fullerton on 10/13/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLOperation.h"

// returns array of groups

@interface ZFLoadGroupsFromCacheOperation : FLOperation {
@private
    NSArray* _groupList;
}

- (id) initWithGroupList:(NSArray*) groupList;

@end
