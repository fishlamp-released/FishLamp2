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
@synthesize titleStringStyle = _titleStringStyle;

#if FL_MRC
- (void) dealloc {
    [_titleStringStyle release];
    [super dealloc];
}
#endif

- (FLBreadcrumbBarView*) breadcrumbView {
    return (FLBreadcrumbBarView*) self.view; 
}

- (void) awakeFromNib {
    [super awakeFromNib];

    _titleStringStyle = [[FLStringDisplayStyle alloc] init];
//    _titleStringStyle.emphasizedStyle.textColor = [SDKColor colorWithRGBRed:203 green:102 blue:10 alpha:1.0];
    _titleStringStyle.emphasizedStyle.textColor = [SDKColor darkBlueTintedGrayColor];
    
    _titleStringStyle.enabledStyle.textColor = [SDKColor darkGrayColor];
    _titleStringStyle.disabledStyle.textColor = [SDKColor lightGrayColor];
    _titleStringStyle.highlightedStyle.textColor = [SDKColor whiteColor];
    _titleStringStyle.hoveringStyle.textColor = [SDKColor whiteColor];
    [_titleStringStyle setTextFont:[SDKFont boldSystemFontOfSize:[SDKFont systemFontSize]]];

    self.breadcrumbView.delegate = self;
}

- (BOOL)acceptsFirstResponder {
    return NO;
}   

- (void) updateNavigationTitlesAnimated:(BOOL) animated {
    for(FLNavigationTitle* title in self.breadcrumbView.titles) {
        title.enabled = [self.delegate titleNavigationController:self navigationTitleIsEnabled:title];
        title.emphasized = [self.delegate titleNavigationController:self navigationTitleIsVisible:title];
    }
    
    [self.breadcrumbView updateLayout:animated];
}

- (void) addNavigationTitle:(FLNavigationTitle*) title {

    if(title.titleStyle == nil) {
        title.titleStyle = FLCopyWithAutorelease(_titleStringStyle);
    }

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
                           
    title.enabled = [self.delegate titleNavigationController:self navigationTitleIsEnabled:title];
    title.emphasized = [self.delegate titleNavigationController:self navigationTitleIsVisible:title];
}

- (void) titleNavigationController:(FLBreadcrumbBarView*) view 
            handleMouseDownInTitle:(FLNavigationTitle*) title {
            
    title.enabled = [self.delegate titleNavigationController:self navigationTitleIsEnabled:title];
    title.emphasized = [self.delegate titleNavigationController:self navigationTitleIsVisible:title];
    if(title.enabled && !title.emphasized) {
        [self.delegate titleNavigationController:self navigationTitleWasClicked:title];
    }
    
    [self updateNavigationTitlesAnimated:YES];
}

            

@end



