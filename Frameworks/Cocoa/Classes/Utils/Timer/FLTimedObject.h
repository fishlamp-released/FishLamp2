//
//  FLTimedObject.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLTimer.h"

@interface FLTimedObject : NSObject {
@private
    FLTimer* _timeoutTimer;
}

@property (readonly, strong) FLTimer* timeoutTimer;
- (void) touchTimestamp;

// override. by default this stops the timer.
- (void) timeoutTimerDidTimeout:(FLTimer*) timer;

@end



