//
//  NSError+FLTimeout.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (FLTimeout)
+ (NSError*) timeoutError;
@property (readonly, nonatomic) BOOL isTimeoutError;
@end
