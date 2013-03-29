//
//  FLDispatchTypes.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLResult.h"

@class FLFinisher;

typedef dispatch_block_t fl_block_t;
typedef void (^fl_result_block_t)(FLResult result);
typedef void (^fl_finisher_block_t)(FLFinisher* result);
typedef fl_result_block_t fl_completion_block_t;

