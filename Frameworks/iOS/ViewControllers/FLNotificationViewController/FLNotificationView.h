//
//  FLNotificationView.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 3/23/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <UIKit/UIKit.h>

#import "FLGradientView.h"

@interface FLNotificationView : UIView {
@private
    UILabel* _titleLabel;
    FLGradientView* _gradient;
}

@end
