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
    _titleStringStyle.emphasizedStyle.textColor = [SDKColor colorWithRGBRed:203 green:102 blue:10 alpha:1.0];
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

- (void) updateViewsAnimated:(BOOL) animated {
    for(FLBarTitleLayer* title in self.breadcrumbView.titles) {
        title.enabled = [self.delegate breadcrumbBar:self breadcrumbIsEnabled:title.title];
        title.emphasized = [self.delegate breadcrumbBar:self breadcrumbIsVisible:title.title];
    }
    
    [self.breadcrumbView updateLayout:animated];
}


- (void) addBreadcrumb:(NSString*) title {

    FLAssertStringIsNotEmpty(title);

    FLBarTitleLayer* titleLayer = [FLBarTitleLayer layer];
    titleLayer.title = title;
    titleLayer.styleProvider = self;
    [self.breadcrumbView addTitle:titleLayer];
    [self updateViewsAnimated:NO];
    
    [self.view setNeedsDisplay:YES];
}

- (void) removeBreadcrumb:(NSString*) title {

}
- (void) breadcrumbBar:(FLBreadcrumbBarView*) view handleMouseMovedInTitle:(FLBarTitleLayer*) title  mouseIn:(BOOL) mouseIn {
    title.enabled = [self.delegate breadcrumbBar:self breadcrumbIsEnabled:title.title];
    title.emphasized = [self.delegate breadcrumbBar:self breadcrumbIsVisible:title.title];
}

- (void) breadcrumbBar:(FLBreadcrumbBarView*) view handleMouseDownInTitle:(FLBarTitleLayer*) title {
    title.enabled = [self.delegate breadcrumbBar:self breadcrumbIsEnabled:title.title];
    title.emphasized = [self.delegate breadcrumbBar:self breadcrumbIsVisible:title.title];
    if(title.enabled && !title.emphasized) {
        [self.delegate breadcrumbBar:self breadcrumbWasClicked:title.title];
    }
    
    [self updateViewsAnimated:YES];
}

- (FLStringDisplayStyle*) barTitleLayerGetStringDisplayStyle:(FLBarTitleLayer*) title {
    return _titleStringStyle;
}
@end



