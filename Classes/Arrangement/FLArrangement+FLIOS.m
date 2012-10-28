//
//  FLArrangement+FLIOS.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/21/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
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