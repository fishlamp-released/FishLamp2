//
//  FLNotificationView.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 3/23/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FLGradientView.h"

@interface FLNotificationView : UIView {
@private
    UILabel* _titleLabel;
    FLGradientView* _gradient;
}

@end
