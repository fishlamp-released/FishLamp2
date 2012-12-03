//
//  FLMenuHeaderView.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/24/11.
//  Copyright 2011 Greentongue Software. All rights reserved.
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