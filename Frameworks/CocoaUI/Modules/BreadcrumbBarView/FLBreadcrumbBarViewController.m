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

- (void) initSelf {
    
    if(!_titleStyle) {
        _titleStyle = [[FLStringDisplayStyle alloc] init];
        _titleStyle.emphasizedStyle.textColor = [UIColor colorWithRGBRed:203 green:102 blue:10 alpha:1.0];
        _titleStyle.enabledStyle.textColor = [UIColor darkGrayColor];
        _titleStyle.disabledStyle.textColor = [UIColor lightGrayColor];
        _titleStyle.highlightedStyle.textColor = [UIColor whiteColor];
        _titleStyle.hoveringStyle.textColor = [UIColor whiteColor];
        [_titleStyle setTextFont:[UIFont boldSystemFontOfSize:[UIFont systemFontSize]]];
    }
}

@synthesize delegate = _delegate;
@synthesize textFont = _textFont;
@synthesize contentView = _contentView;

#if FL_MRC
- (void) dealloc {
    [_textFont release];
    [_titleStyle release];
    [super dealloc];
}
#endif

- (FLBreadcrumbBarView*) breadcrumbView {
    return (FLBreadcrumbBarView*) self.view; 
}

- (void) awakeFromNib {
    [super awakeFromNib];
    [self initSelf];
    self.breadcrumbView.delegate = self;
}

- (void) setTextFont:(NSFont*) font {
    FLSetObjectWithRetain(_textFont, font);
    [_titleStyle setTextFont:font];
}


#define kWideWidth 100
#define kTallHeight 40

- (BOOL)acceptsFirstResponder {
    return YES;
}                          

- (void) updateViewsAnimated:(BOOL) animated {
    for(FLBarTitleLayer* title in self.breadcrumbView.titles) {
        title.enabled = [self.delegate breadcrumbBar:self breadcrumbIsEnabled:title.title];
        title.emphasized = [self.delegate breadcrumbBar:self breadcrumbIsVisible:title.title];
    }
    
    [self.breadcrumbView updateHighlightedTitle:animated];
}


- (void) addBreadcrumb:(NSString*) title {

    FLAssertStringIsNotEmpty_(title);

    FLBarTitleLayer* titleLayer = [FLBarTitleLayer layer];
    titleLayer.title = title;
    titleLayer.titleStyle = _titleStyle;
    [self.breadcrumbView addTitle:titleLayer];
    [self updateViewsAnimated:NO];
}

- (void) removeBreadcrumb:(NSString*) title {

}

- (void) breadcrumbBar:(FLBreadcrumbBarView*) view updateLayoutWithTitles:(NSArray*) titles {
  
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];

    CGRect frame = CGRectMake(0, FLRectGetBottom(self.view.bounds) - (kTallHeight*2), self.contentView.frame.origin.x, kTallHeight);
    for(FLBarTitleLayer* layer in titles) {
        layer.frame = frame;
        frame.origin.y -= frame.size.height;
    }

    [CATransaction commit];
}

- (void) breadcrumbBar:(FLBreadcrumbBarView*) view handleMousedownInTitle:(FLBarTitleLayer*) title {
    [self.delegate breadcrumbBar:self breadcrumbWasClicked:title.title];
    [self updateViewsAnimated:YES];
}

@end



