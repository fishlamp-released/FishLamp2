//
//  FLBreadcrumbBarView.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/15/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//
#if OSX
#import "FLBreadcrumbBarView.h"
#import "FLCoreText.h"
#import "FLColorRange+Gradients.h"
#import "FLColorUtilities.h"

#define ArrowWidth 10.0f
#define kWideWidth 100
#define kTallHeight 50

@interface FLBreadcrumbBarView ()
@end

@implementation FLBreadcrumbBarView  

@synthesize delegate = _delegate;
@synthesize titles = _titles;
@synthesize highlightLayer = _highlightLayer;
@synthesize titleTop = _titleTop;

#if FL_MRC
- (void) dealloc {
    [_titles release];
    [_highlightLayer release];
    [super dealloc];
}
#endif

- (void) awakeFromNib {
    [super awakeFromNib];
    _titleTop = (kTallHeight*4);

    if(!_titles) {
        _titles = [[NSMutableArray alloc] init];

        self.wantsLayer = YES;
        self.layer = [CALayer layer];
        
        _highlightLayer = [[FLBarHighlightBackgoundLayer alloc] init];
        _highlightLayer.hidden = YES;
        _highlightLayer.lineColor = [SDKColor gray85Color];
    
        [self.layer addSublayer:_highlightLayer];
    }
    
//    [self setNeedsDisplay:YES];
}

- (void) updateLayout:(BOOL) animated {
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];

    FLNavigationTitle* highlightedTitle = nil;

    CGRect bounds = self.bounds;
    CGFloat top = FLRectGetBottom(bounds);

    for(FLNavigationTitle* title in _titles) {

        CGRect frame = bounds;
        frame.size.height = title.titleHeight; 
        frame.origin.y = top - frame.size.height;

        if(!CGRectEqualToRect(title.frame, frame)) {
            title.frame = frame;
        }
        [title setNeedsDisplay];
        if(title.emphasized) {
            highlightedTitle = title;
        }
        top -= frame.size.height;
    }

    [CATransaction commit];
    
    if(highlightedTitle) {
        if(!animated) {
            [CATransaction begin];
            [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
        }
                
        if(_highlightLayer.isHidden) {
            _highlightLayer.hidden = NO;
        }
        
        CGRect highlightFrame = FLRectSetWidth(highlightedTitle.frame, highlightedTitle.frame.size.width + 11);
        if(!CGRectEqualToRect(_highlightLayer.frame, highlightFrame)) {
            _highlightLayer.frame = highlightFrame;
        }
        
        if(!animated) {
            [CATransaction commit];
        }

        [_highlightLayer setNeedsDisplay];
    }
    else {
        if(!_highlightLayer.isHidden) {
            _highlightLayer.hidden = YES;
        }
    }

    [self setNeedsDisplay:YES];
        
}

- (void) addTitle:(FLNavigationTitle*) title {
    [_titles addObject:title];
    [self.layer addSublayer:title];
    [title setNeedsDisplay];
    [self updateLayout:NO];
    
    self.needsDisplay = YES;
}

- (void) handleMouseMoved:(CGPoint) location mouseIn:(BOOL) mouseIn mouseDown:(BOOL) mouseDown {
    for(FLNavigationTitle* title in _titles) {
        BOOL mouseInTitle = CGRectContainsPoint(title.frame, location);
        [self.delegate titleNavigationController:self handleMouseMovedInTitle:title mouseIn:mouseInTitle];
        
        if(mouseInTitle) {
            [title handleMouseMoved:location mouseIn:YES mouseDown:mouseDown];
        }
        else {
            [title handleMouseMoved:location mouseIn:NO mouseDown:NO];
        }
    }
}

- (void) handleMouseUpInside:(CGPoint) location {
    for(FLNavigationTitle* title in _titles) {
        if(CGRectContainsPoint(title.frame, location)) {
            [self.delegate titleNavigationController:self handleMouseDownInTitle:title];
            break;
        }
    }
}

- (void) setFrame:(CGRect) frame {
    [super setFrame:frame];
    [self updateLayout:NO];
}

//- (void) drawRect:(NSRect)dirtyRect {
//    [super drawRect:dirtyRect];
//    
//    if(!_highlightLayer.isHidden && CGRectIntersectsRect(dirtyRect, _highlightLayer.frame)) {
//        [_highlightLayer setNeedsDisplay];
//    }
//}


@end



#endif