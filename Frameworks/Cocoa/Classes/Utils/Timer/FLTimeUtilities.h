//
//  FLTimeUtilities.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSTimeInterval FLTimeBlock (dispatch_block_t block);

extern uint64_t FLTimeGetHighResolutionTimeStamp();
extern NSTimeInterval FLTimeGetInterval(uint64_t start, uint64_t end);
