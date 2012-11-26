//
//  FLResult.h
//  FishLampCore
//
//  Created by Mike Fullerton on 11/16/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSError+FLExtras.h"

typedef id FLResult;
typedef void (^FLResultBlock)(FLResult result);

@protocol FLResultContract <NSObject>
@property (readonly, strong) NSError* error;
@property (readonly, assign) BOOL isExpectedResult;
@property (readonly, assign) BOOL isFailedResult;
@end

@protocol FLResultProducing <NSObject>
@property (readonly, strong) FLResult result;
@end

extern id FLMakeResult(id payload);
#define FLSuccessfullResult FLMakeResult(nil)
