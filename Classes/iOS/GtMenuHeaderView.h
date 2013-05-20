//
//  GtMenuHeaderView.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/24/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtGradientView.h"

@interface GtMenuSectionHeaderView : UIView {
@private
    GtGradientView* m_gradientView;
    UILabel* m_label;
}

@property (readwrite, retain, nonatomic) NSString* menuHeaderTitle;

// override point
- (void) configureLabel:(UILabel*) label;

@end

@interface GtMenuHeaderView : GtMenuSectionHeaderView

@end