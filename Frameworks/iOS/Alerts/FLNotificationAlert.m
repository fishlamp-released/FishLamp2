//
//  FLNotificationAlert.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 5/31/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLNotificationAlert.h"

@implementation FLNotificationAlert

+ (CGSize) defaultAutoPostionedViewSize {
    return FLSizeMake(320,100);
}

- (id) init {
    self = [super init];
    if(self) {
//        self.dialogViewStyle = FLDialogViewStyleNotificationBar;
        if(DeviceIsPad()) {
            self.contentMode = FLContentModeMake(FLContentModeHorizontalRight, FLContentModeVerticalBottom);
        }
        else {
            self.contentMode = FLContentModeMake(FLContentModeHorizontalFill, FLContentModeVerticalBottom);
        }
    }
    return self;   
}

- (UIView*) createContentView {
    return nil;
}

@end