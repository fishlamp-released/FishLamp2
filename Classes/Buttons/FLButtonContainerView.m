//
//  FLAlertButtonContainerView.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/19/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLButtonContainerView.h"
#import "FLArrangement.h"


@implementation FLButtonContainerView

@synthesize onSetupButton = _onSetupButton;

- (id)initWithFrame:(FLRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.arrangement = [FLCenterJustifiedColumnArrangement arrangement];
        self.arrangement.outerInsets = UIEdgeInsetsMake(0,5,0,5);
    }
    return self;
}

- (void) dealloc {
    release_(_onSetupButton);
    super_dealloc_();
}

- (void) layoutSubviews {
    [super layoutSubviews];
    [self layoutSubviewsWithArrangement:self.arrangement
                         adjustViewSize:NO];
}

- (void) addButton:(FLButton*) button {

    if(_onSetupButton) {
        _onSetupButton(self, button);
    }
    
    [self insertSubview:button withArrangeableWeight:button.arrangeableWeight];
    [self setNeedsLayout];
}
   
   
- (FLSize)sizeThatFits:(FLSize) inSize {


    return inSize;

}

@end
