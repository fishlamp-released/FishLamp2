//
//  FLNotificationAlert.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 5/31/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLNotificationAlert.h"

@implementation FLNotificationAlert

+ (CGSize) defaultAutoPostionedViewSize {
    return CGSizeMake(320,100);
}

- (id) init {
    self = [super init];
    if(self) {
//        self.dialogViewStyle = FLDialogViewStyleNotificationBar;
        if(DeviceIsPad()) {
            self.contentMode = FLRectLayoutMake(FLRectLayoutHorizontalRight, FLRectLayoutVerticalBottom);
        }
        else {
            self.contentMode = FLRectLayoutMake(FLRectLayoutHorizontalFill, FLRectLayoutVerticalBottom);
        }
    }
    return self;   
}

- (UIView*) createContentView {
    return nil;
}

@end
