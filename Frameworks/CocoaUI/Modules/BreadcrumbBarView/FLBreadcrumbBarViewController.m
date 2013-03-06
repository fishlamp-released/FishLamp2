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

#define kWideWidth 100
#define kTallHeight 40

- (void) finishUpdate {
    for(FLBreadcrumbBarView* view in _breadcrumbs) {
        view.enabled = [self.delegate breadcrumbBar:self breadcrumbIsEnabled:view.title];
        view.emphasized = [self.delegate breadcrumbBar:self breadcrumbIsVisible:view.title];
        [view didLayout];
    }
    
    [self.view setNeedsDisplay];
}


- (BOOL)acceptsFirstResponder {
    return YES;
}

- (void) updateVertical {
    CGFloat verticalOffset = FLRectGetBottom(self.view.bounds) - kTallHeight;
    for(FLBreadcrumbBarView* view in _breadcrumbs) {
        CGRect frame = self.view.bounds;
        frame.size.height = kTallHeight;
        frame.origin.y = verticalOffset;
        verticalOffset -= kTallHeight;
        view.frame = frame;
        view.drawTopLine = NO;
    }
    
    [[_breadcrumbs objectAtIndex:0] setDrawTopLine:YES];
}

- (void) updateHorizontal {

    CGFloat left = -2;
    for(FLBreadcrumbBarView* view in _breadcrumbs) {
        [view sendToBack];

        CGRect frame = self.view.bounds;
        frame = CGRectInset(frame, 2, 2);
        
        frame.size.width = kWideWidth;
        frame.origin.x = left;
        frame.size.height += 8;
        frame.origin.y -= 4;
        view.frame = frame;
        left += (view.frame.size.width - 14);
    }

}

- (void) update {
    [self updateVertical];
    [self finishUpdate];
}

- (void) addBreadcrumb:(NSString*) title {

    if(!_breadcrumbs) {
        _breadcrumbs = [[NSMutableArray alloc] init];
    }

    FLAssertStringIsNotEmpty_(title);

    FLStringDisplayStyle* stringStyles = [FLStringDisplayStyle stringDisplayStyle];
    
//    stringStyles.enabledStyle.textColor = [UIColor colorWithRGBRed:203 green:102 blue:10 alpha:1.0];
  
    stringStyles.emphasizedStyle.textColor = [UIColor colorWithRGBRed:203 green:102 blue:10 alpha:1.0];
    stringStyles.enabledStyle.textColor = [UIColor darkGrayColor];
    stringStyles.disabledStyle.textColor = [UIColor lightGrayColor];
    stringStyles.highlightedStyle.textColor = [UIColor whiteColor];
    stringStyles.hoveringStyle.textColor = [UIColor whiteColor];

    if(_textFont) {
        [stringStyles setTextFont:_textFont];
    }
    else {
        [stringStyles setTextFont:[UIFont boldSystemFontOfSize:[UIFont systemFontSize]]];
    }

    FLBreadcrumbBarView* view = FLAutorelease([[FLBreadcrumbBarView alloc] initWithFrame:CGRectZero]);
    view.lineColor = [NSColor gray85Color];
    view.title = title;
    view.titleStyle = stringStyles;
    view.touchedBlock = ^(FLBreadcrumbBarView* clickedView){
        [self.delegate breadcrumbBar:self  breadcrumbWasClicked:title];
        [self update];
    };
    [_breadcrumbs addObject:view];
    [self.view addSubview:view];
    [self update];
}

- (void) removeBreadcrumb:(NSString*) title {

}

- (void) setBreadcrumbActive:(BOOL) active forTitle:(NSString*) title {
    BOOL foundActive = NO;
    
    for(FLBreadcrumbBarView* view in _breadcrumbs) {
        view.enabled = !foundActive;
        
        if(FLStringsAreEqual(view.title, title)) {
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



