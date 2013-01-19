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

@interface FLBreadcrumbBarViewController ()

@end

@implementation FLBreadcrumbBarViewController

@synthesize delegate = _delegate;
@synthesize textFont = _textFont;

- (id) init {
    self = [super init];
    if(self) {
        _breadcrumbs = [[NSMutableArray alloc] init];
    }
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_textFont release];
    [_breadcrumbs release];
    [super dealloc];
}
#endif

- (void) loadView {
    NSView* view = FLAutorelease([[NSView alloc] initWithFrame:CGRectMake(0,0,100,20)]);
    view.autoresizingMask = NSViewHeightSizable | NSViewWidthSizable;
    self.view = view;
}

#define Size 100

- (void) update {
    CGFloat left = -2;
    for(FLBreadcrumbBarView* view in _breadcrumbs) {
        CGRect frame = self.view.bounds;
        [view sendToBack];
        
        view.enabled = [self.delegate breadcrumbBar:self breadcrumbIsEnabled:view.key];
        view.emphasized = [self.delegate breadcrumbBar:self breadcrumbIsVisible:view.key];
        
        frame = CGRectInset(frame, 2, 2);
        
        frame.size.width = Size;
        frame.origin.x = left;
        frame.size.height += 8;
        frame.origin.y -= 4;
        view.frame = frame;
        left += (view.frame.size.width - 14);
        [view didLayout];
    }
    [self.view setNeedsDisplay];
}

- (void) addBreadcrumb:(NSString*) title forKey:(id) key {

    FLAssertStringIsNotEmpty_(title);

    FLAttributedString* string = [FLAttributedString attributedString:title];
    string.emphasizedColor = [UIColor colorWithRGBRed:203 green:102 blue:10 alpha:1.0];
    string.enabledColor = [UIColor darkGrayColor];
    string.disabledColor = [UIColor grayColor];
    string.highlightedColor = [UIColor blueColor];
    string.textFont = _textFont ? _textFont : [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];

    FLBreadcrumbBarView* view = FLAutorelease([[FLBreadcrumbBarView alloc] initWithFrame:CGRectZero]);
    view.title = string;
    view.key = key;
    view.touched = ^{
        [self.delegate breadcrumbBar:self  breadcrumbWasClicked:view.key];
    };
    [_breadcrumbs addObject:view];
    [self.view addSubview:view];
    [self update];
}

- (void) setBreadcrumbDisabled:(BOOL) disabled forTitle:(NSString*) title {
//    FLBreadcrumbBarView* view = [_breadcrumbs objectForKey:title];
//    view.title.enabled = !disabled;
//    [self update];
}

- (void) setBreadcrumbActive:(BOOL) active forTitle:(NSString*) title {
    BOOL foundActive = NO;
    
    for(FLBreadcrumbBarView* view in _breadcrumbs) {
        view.enabled = !foundActive;
        
        if(FLStringsAreEqual(view.title.string, title)) {
            foundActive = YES;
            view.emphasized = YES;
        }
        else {
            view.emphasized = NO;
        }
    }

    [self update];
}


@end



