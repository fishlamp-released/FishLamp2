//
//  FLAlertButtonContainerView.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/19/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLButtonContainerView.h"
#import "FLArrangement.h"


@implementation FLButtonContainerView

@synthesize onSetupButton = _onSetupButton;

- (id)initWithFrame:(CGRect)frame
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
    FLRelease(_onSetupButton);
    FLSuperDealloc();
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
   
   
- (CGSize)sizeThatFits:(CGSize) inSize {


    return inSize;

}

@end
