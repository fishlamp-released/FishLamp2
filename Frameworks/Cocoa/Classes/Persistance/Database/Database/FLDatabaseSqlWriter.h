//
//  FLDatabaseSqlWriter.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/21/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FLDatabaseSqlWriter <NSObject>
- (NSString*) sqlString;
@end
