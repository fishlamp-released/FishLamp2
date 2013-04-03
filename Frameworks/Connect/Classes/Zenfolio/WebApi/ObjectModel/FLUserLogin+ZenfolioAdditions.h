//
//  FLUserLogin+ZenfolioAdditions.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLUserLogin.h"

@interface FLUserLogin (ZenfolioAdditions)

@property (readwrite, strong, nonatomic) NSNumber* rootGroupID;

- (void) setPrivilegeEnabled:(NSString*) privilege;
- (BOOL) isPrivilegeEnabled:(NSString*) privilege;

@end
