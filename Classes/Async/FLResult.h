//
//  FLResult.h
//  FishLampCore
//
//  Created by Mike Fullerton on 10/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol FLResult <NSObject>
@property (readonly, assign, nonatomic) BOOL didSucceed;
@property (readonly, strong, nonatomic) NSError* error;
@property (readonly, strong, nonatomic) id output;
@end

typedef id<FLResult> FLResult;

typedef void (^FLResultBlock)(FLResult result);

NS_INLINE
id<FLResult> FLThrowFailedResult(id<FLResult> result) {
    if(!result ||  !result.didSucceed || result.error) {
        FLCThrowError_(result.error);
    }
    
    return result;
}
