// [Generated]
//
// FLViewGradients.m
// Project: FishLamp Themes
// Schema: FLThemeObjects
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//
// [/Generated]

#import "__FLViewGradients.h"
#import "FLViewGradients.h"
#import "FLColorRange+FLThemes.h"

@implementation FLViewGradients (MyCode)

- (FLColorRange*) colorRangeForControlState:(UIControlState) controlState {
    
    FLColorRange* gradient = nil; 
    if(!gradient) {
        switch(controlState) {
            case UIControlStateNormal:
                gradient = self.normalGradient;
                if(!gradient) {
                    gradient = [FLColorRange colorRangeWithColorRangeName:self.normalGradientEnumValue];
                    self.normalGradient = gradient;
                }
            break;
            
            case UIControlStateDisabled:
                gradient = self.disabledGradient;
                if(!gradient) {
                    gradient = [FLColorRange colorRangeWithColorRangeName:self.disabledGradientEnumValue];
                    self.disabledGradient = gradient;
                }
            break;
            
            case UIControlStateHighlighted:
                gradient = self.highlightedGradient;
                if(!gradient) {
                    gradient = [FLColorRange colorRangeWithColorRangeName:self.highlightedGradientEnumValue];
                    self.highlightedGradient = gradient;
                }
            break;
            
            case UIControlStateSelected:
                gradient = self.selectedGradient;
                if(!gradient) {
                    gradient = [FLColorRange colorRangeWithColorRangeName:self.selectedGradientEnumValue];
                    self.selectedGradient = gradient;
                }
            break;
            
            default:
            break;

        }
    }
    
    return gradient;

}

- (void) setColorRange:(FLColorRange*) color 
     forControlState:(UIControlState) controlState {

    switch(controlState) {
        case UIControlStateNormal:
            self.normalGradient = color;
        break;
        
        case UIControlStateDisabled:
            self.disabledGradient = color;
        break;
        
        case UIControlStateHighlighted:
            self.highlightedGradient = color;
        break;
        
        case UIControlStateSelected:
            self.selectedGradient = color;
        break;

        default:
        break;
    }
}
@end
