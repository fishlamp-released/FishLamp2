//
//  FLMenuHeaderView.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/24/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLGradientView.h"

@interface FLMenuSectionHeaderView : UIView {
@private
    FLGradientView* _gradientView;
    UILabel* _label;
}

@property (readwrite, retain, nonatomic) NSString* menuHeaderTitle;

// override point
- (void) configureLabel:(UILabel*) label;

@end

@interface FLMenuHeaderView : FLMenuSectionHeaderView

@end