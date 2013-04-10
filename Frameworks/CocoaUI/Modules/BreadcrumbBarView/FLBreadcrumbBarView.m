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

//- (id) setupBreadcrumbBarView {
//    
//    return self;
//}
//
//- (id) initWithFrame:(NSRect) rect {
//    return [[super initWithFrame:rect] setupBreadcrumbBarView];
//}
//
//- (id) initWithCoder:(NSCoder *)aDecoder {
//    return [[super initWithCoder:aDecoder] setupBreadcrumbBarView];
//}

- (void) awakeFromNib {
    [super awakeFromNib];
    _titleTop = (kTallHeight*4);
    _contentEnclosure.autoresizesSubviews = NO;
    _contentView.autoresizesSubviews = NO;

    return ;

    if(!_titles) {
        _titles = [[NSMutableArray alloc] init];
    }




    self.wantsLayer = YES;
    self.layer = [CALayer layer];
    
    _highlightLayer = [[FLBarHighlightBackgoundLayer alloc] init];
    _highlightLayer.hidden = YES;
    _highlightLayer.lineColor = [SDKColor gray85Color];
    
    [self.layer addSublayer:_highlightLayer];
    
    
}

//- (void) updateHighlightedTitle:(BOOL) animated {
//
//    for(FLBarTitleLayer* title in self.titles) {
//
//        if(title.emphasized) {
//            if(!animated) {
//                [CATransaction begin];
//                [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
//            }
//            if(_highlightLayer.isHidden) {
//                _highlightLayer.hidden = NO;
//            }
//            CGRect frame = FLRectSetWidth(title.frame, title.frame.size.width + 11);
//            if(!CGRectEqualToRect(_highlightLayer.frame, frame)) {
//                _highlightLayer.frame = frame; 
////                [_highlightLayer setNeedsDisplay];
//            }
//            
//            if(!animated) {
//                [CATransaction commit];
//            }
//
//            return;
//        }
//    }
//    
//    _highlightLayer.hidden = YES;
//}


- (void) updateLayout:(BOOL) animated {
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];

    FLBarTitleLayer* highlightedTitle = nil;

    CGRect frame = CGRectMake(0, FLRectGetBottom(self.bounds) - _titleTop, _contentEnclosure.frame.origin.x, kTallHeight);
    for(FLBarTitleLayer* title in _titles) {
        if(!CGRectEqualToRect(title.frame, frame)) {
            title.frame = frame;
            [_highlightLayer setNeedsDisplay];
        }
        if(title.emphasized) {
            highlightedTitle = title;
        }
        frame.origin.y -= frame.size.height;
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
            [_highlightLayer setNeedsDisplay];
        }
        
        if(!animated) {
            [CATransaction commit];
        }
    }
    else {
        if(!_highlightLayer.isHidden) {
            _highlightLayer.hidden = YES;
        }
    }
    
}

//- (void) setNeedsDisplay {
//    [_highlightLayer setNeedsDisplay];
//    [super setNeedsDisplay];
//}

- (void) addTitle:(FLBarTitleLayer*) title {
return;
    [_titles addObject:title];
    [self.layer addSublayer:title];
    [title setNeedsDisplay];
    [self updateLayout:NO];
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
    [self updateLayout:NO];
}

- (void) drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    if(!_highlightLayer.isHidden && CGRectIntersectsRect(dirtyRect, _highlightLayer.frame)) {
        [_highlightLayer setNeedsDisplay];
    }
}




@end



#endif