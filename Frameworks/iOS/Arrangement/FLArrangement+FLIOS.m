//
//  FLArrangement+FLIOS.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/21/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLArrangement+FLIOS.h"

@implementation FLArrangement (FLIOS)

- (FLArrangementWillLayoutBlock) onWillArrangeForPhone {
    return self.onWillArrange;
}

- (FLArrangementWillLayoutBlock) onWillArrangeForPad {
    return self.onWillArrange;
}

- (void) setOnWillArrangeForPhone:(FLArrangementWillLayoutBlock)onWillArrangeForPhone {
    if(DeviceIsPhone()) {
        self.onWillArrange = onWillArrangeForPhone;
    }
}

- (void) setOnWillArrangeForPad:(FLArrangementWillLayoutBlock) onWillArrangeForPad {
    if(DeviceIsPad()) {
        self.onWillArrange = onWillArrangeForPad;
    }
}

@end