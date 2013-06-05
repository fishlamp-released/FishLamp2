//
//  FLDispatchTypes.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/12/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FishLamp.h"
#import "FLAsyncResult.h"

@class FLFinisher;

typedef dispatch_block_t fl_block_t;
typedef void (^fl_result_block_t)(FLPromisedResult result);
typedef void (^fl_finisher_block_t)(FLFinisher* finisher);
typedef fl_result_block_t fl_completion_block_t;

