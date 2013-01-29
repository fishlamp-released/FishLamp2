//
//  FLUserLogin+FLZfAdditions.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLUserLogin+FLZfAdditions.h"

@implementation FLUserLogin (FLZfAdditions)

- (NSNumber*) rootGroupID {
    return [self.userInfo objectForKey:@"root_group_id"];
}

-(void) setUserInfoObject:(id) object forKey:(id) key {
    NSMutableDictionary* dict = FLAutorelease([self.userInfo mutableCopy]);
    if(!dict) {
        dict = [NSMutableDictionary dictionary];
    }
    [dict setObject:object forKey:key];
    self.userInfo = dict;
}

- (void) setRootGroupID:(NSNumber*) groupID {
    [self setUserInfoObject:groupID forKey:@"root_group_id"];
}

- (void) setPrivilegeEnabled:(NSString*) privilege {
    [self setUserInfoObject:privilege forKey:privilege];
}

- (BOOL) isPrivilegeEnabled:(NSString*) privilege {
    return [self.userInfo objectForKey:privilege] != nil;
}


@end
