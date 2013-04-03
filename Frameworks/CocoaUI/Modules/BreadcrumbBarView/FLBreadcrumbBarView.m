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

//- (void) applyThemeToBreadcrumbBarView:(id) theme {
//
//}
//
//- (SEL) themeSelector {
//    return @selector(applyThemeToBreadcrumbBarView:);
//}

- (id) setupBreadcrumbBarView {
    if(!_titles) {
        _titles = [[NSMutableArray alloc] init];
    }
    self.wantsLayer = YES;
    self.layer = [CALayer layer];
    
    _highlightLayer = [[FLBarHighlightBackgoundLayer alloc] init];
    _highlightLayer.hidden = YES;
    _highlightLayer.lineColor = [SDKColor gray85Color];
    
    [self.layer addSublayer:_highlightLayer];
    
    _titleTop = (kTallHeight*4);
    
    return self;
}

- (id) initWithFrame:(NSRect) rect {
    return [[super initWithFrame:rect] setupBreadcrumbBarView];
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    return [[super initWithCoder:aDecoder] setupBreadcrumbBarView];
}

- (void) awakeFromNib {
    [super awakeFromNib];
    [self setupBreadcrumbBarView];
    
    _contentEnclosure.autoresizesSubviews = NO;
    _contentView.autoresizesSubviews = NO;
}

- (void) updateLayout {
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];

    CGRect frame = CGRectMake(0, FLRectGetBottom(self.bounds) - _titleTop, _contentEnclosure.frame.origin.x, kTallHeight);
    for(FLBarTitleLayer* title in _titles) {
        title.frame = frame;
        frame.origin.y -= frame.size.height;
    
        if(title.emphasized) {
            _highlightLayer.hidden = NO;
            _highlightLayer.frame = FLRectSetWidth(title.frame, title.frame.size.width + 11);
        }
    
    }

    [CATransaction commit];
}

- (void) setNeedsDisplay {
    [_highlightLayer setNeedsDisplay];
    [super setNeedsDisplay];
}

- (void) addTitle:(FLBarTitleLayer*) title {

    [_titles addObject:title];
    [self.layer addSublayer:title];
    [self updateLayout];
    [self updateHighlightedTitle:NO];
    [self setNeedsDisplay];
}

- (void) handleMouseMoved:(CGPoint) location mouseIn:(BOOL) mouseIn mouseDown:(BOOL) mouseDown {
    for(FLBarTitleLayer* title in _titles) {
        BOOL mouseInTitle = CGRectContainsPoint(title.frame, location);
        [self.delegate breadcrumbBar:self handleMouseMovedInTitle:title mouseIn:mouseInTitle];
        
        if(mouseInTitle) {
            [title handleMouseMoved:location mouseIn:YES mouseDown:mouseDown];
        }
        else {
            [title handleMouseMoved:location mouseIn:NO mouseDown:NO];
        }
    }
}

- (void) handleMouseUpInside:(CGPoint) location {
    for(FLBarTitleLayer* title in _titles) {
        if(CGRectContainsPoint(title.frame, location)) {
            [self.delegate breadcrumbBar:self handleMouseDownInTitle:title];
            break;
        }
    }
}

- (void) setFrame:(CGRect) frame {
    [super setFrame:frame];
//    _contentView.frame = CGRectInset(self.bounds, 1, 1);
    [self updateLayout];
}

- (void) updateHighlightedTitle:(BOOL) animated {

    if(!animated) {
        [CATransaction begin];
        [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    }

    for(FLBarTitleLayer* title in self.titles) {
        if(title.emphasized) {
            _highlightLayer.hidden = NO;
            _highlightLayer.frame = FLRectSetWidth(title.frame, title.frame.size.width + 11);
            [_highlightLayer setNeedsDisplay];
            return;
        }
    }
    
    _highlightLayer.hidden = YES;

    if(!animated) {
        [CATransaction commit];
    }
}




@end



#endif