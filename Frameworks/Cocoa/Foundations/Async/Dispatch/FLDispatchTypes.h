//
//  FLDispatchTypes.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLResult.h"
#import "FLAsyncWorker.h"

@class FLFinisher;
@protocol FLAsyncQueue;

typedef void (^FLBlockWithResult)(FLResult result);
typedef void (^FLBlockWithFinisher)(FLFinisher* result);
