//
//  FLResult.h
//  FishLampCore
//
//  Created by Mike Fullerton on 11/16/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSError+FLExtras.h"

@protocol FLResult <NSObject>

// note that [NSError error] returns itself.

@property (readonly, strong) NSError* error;
@end

@interface FLSuccessfullResult : NSObject 
+ (id) successfulResult;
@end

typedef void (^FLResultBlock)(id result);
