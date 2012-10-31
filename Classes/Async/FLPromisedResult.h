//
//  FLPromisedResult.h
//  FishLampCore
//
//  Created by Mike Fullerton on 10/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLResult.h"

typedef void (^FLConditionalBlock)(BOOL* condition);

@protocol FLPromisedResult <NSObject>
@property (readonly, assign) BOOL hasResult;
@property (readonly, strong) FLResult result;
- (FLResult) waitForResult;
- (FLResult) waitForResultWithCondition:(FLConditionalBlock) checkCondition;
- (FLResult) waitForResultWithTimeout:(NSTimeInterval) timeout;
@end

