//
//  FLBreadcrumbBarViewController.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/15/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLBreadcrumbBarViewController.h"
#import "FLBreadcrumbBarView.h"
#import "FLAttributedString.h"
#import "FLMoveAnimation.h"
#import "FLBarHighlightBackgoundLayer.h"
#import "SDKColor+FLMoreColors.h"

@interface FLBreadcrumbBarViewController ()
@end

@implementation FLBreadcrumbBarViewController

@synthesize delegate = _delegate;

#if FL_MRC
- (void) dealloc {
    [super dealloc];
}
#endif

- (FLBreadcrumbBarView*) breadcrumbView {
    return (FLBreadcrumbBarView*) self.view; 
}

- (void) awakeFromNib {
    [super awakeFromNib];
    self.breadcrumbView.delegate = self;
}

- (BOOL)acceptsFirstResponder {
    return NO;
}   

- (void) updateTitle:(FLNavigationTitle*) title withState:(FLNavigationTitleState) state {
    if(state.hidden != title.hidden) {
        title.hidden = state.hidden;
    }
    title.enabled = state.enabled;
    title.selected = state.selected;

}

- (void) updateNavigationTitlesAnimated:(BOOL) animated {
    
    BOOL selected = NO;
    
    for(FLNavigationTitle* title in self.breadcrumbView.titles) {
        FLNavigationTitleState state = 
            [self.delegate titleNavigationController:self navigationTitleState:title];
    
        [self updateTitle:title withState:state];
        
        if(state.selected) {
            selected = YES;
        }
    }
    
    if(!selected) {
        FLLog(@"not selected");
    }
    
    [self.breadcrumbView updateLayout:animated];
}

- (void) addNavigationTitle:(FLNavigationTitle*) title {

//    if(title.titleStyle == nil) {
//        title.titleStyle = FLCopyWithAutorelease(_titleStringStyle);
//    }

    FLAssertStringIsNotEmpty(title.localizedTitle);
    FLAssertNotNil(title.identifier);
    [self.breadcrumbView addTitle:title];
    [self updateNavigationTitlesAnimated:NO];
    [self.delegate titleNavigationController:self didAddNavigationTitle:title];
    
    [self.view setNeedsDisplay:YES];
}

- (void) removeNavigationTitleForIdentifier:(id) identifier {

}
- (void) titleNavigationController:(FLBreadcrumbBarView*) view
           handleMouseMovedInTitle:(FLNavigationTitle*) title  
                           mouseIn:(BOOL) mouseIn {
                           

    FLNavigationTitleState state = 
        [self.delegate titleNavigationController:self navigationTitleState:title];

    [self updateTitle:title withState:state];

//    title.enabled = [self.delegate titleNavigationController:self navigationTitleIsEnabled:title];
//    title.selected = [self.delegate titleNavigationController:self navigationTitleIsSelected:title];
}

- (void) titleNavigationController:(FLBreadcrumbBarView*) view 
            handleMouseDownInTitle:(FLNavigationTitle*) title {


    FLNavigationTitleState state = 
        [self.delegate titleNavigationController:self navigationTitleState:title];

    [self updateTitle:title withState:state];
            
    if(title.enabled && !title.selected) {
        [self.delegate titleNavigationController:self navigationTitleWasSelected:title];
    }
    
    [self updateNavigationTitlesAnimated:YES];
}

            

@end



