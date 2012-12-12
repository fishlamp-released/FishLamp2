// [Generated]
//
// FLViewColors.m
// Project: FishLamp Themes
// Schema: FLThemeObjects
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//
// [/Generated]

#import "__FLViewColors.h"
#import "FLViewColors.h"

@implementation FLViewColors (MyCode)

- (UIColor*) colorForControlState:(UIControlState) controlState {
    
    UIColor* color = self.normalColor;
    switch(controlState) {
        case UIControlStateNormal:
        break;
        
        case UIControlStateDisabled:
            color = self.disabledColor;
        break;
        
        case UIControlStateHighlighted:
            color = self.highlightedColor;
        break;
        
        case UIControlStateSelected:
            color = self.selectedColor;
        break;
        
        default:
        break;
    }
    
    return color;

}

- (void) setColor:(UIColor*) color forControlState:(UIControlState) controlState {
    switch(controlState) {
        case UIControlStateNormal:
            self.normalColor = color;
        break;
        
        case UIControlStateDisabled:
            self.normalColor = color;
        break;
        
        case UIControlStateHighlighted:
            self.normalColor = color;
        break;
        
        case UIControlStateSelected:
            self.normalColor = color;
        break;

        default:
        break;
    }
}
@end
