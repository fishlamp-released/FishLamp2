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

#if FL_MRC
- (void) dealloc {
    [_titles release];
    [_highlightLayer release];
    [super dealloc];
}
#endif

- (id) setupBreadcrumbBarView {
    if(!_titles) {
        _titles = [[NSMutableArray alloc] init];
    }
    self.wantsLayer = YES;
    self.layer = [CALayer layer];
    
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

    CGRect frame = CGRectMake(0, FLRectGetBottom(self.bounds) - (kTallHeight*2), _contentEnclosure.frame.origin.x, kTallHeight);
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
    
    if(!_highlightLayer) {
        _highlightLayer = [[FLBarHighlightBackgoundLayer alloc] init];
        _highlightLayer.hidden = YES;
        
        _highlightLayer.lineColor = [SDKColor gray85Color];
        
        [self.layer addSublayer:_highlightLayer];
    }
    
    [self.layer addSublayer:title];
    [self updateLayout];
    [self updateHighlightedTitle:NO];
    [self setNeedsDisplay];
}

- (void) handleMouseMoved:(CGPoint) location mouseIn:(BOOL) mouseIn mouseDown:(BOOL) mouseDown {
    for(FLBarTitleLayer* title in _titles) {
        BOOL mouseInTitle = CGRectContainsPoint(title.frame, location);
        
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
            [self.delegate breadcrumbBar:self handleMousedownInTitle:title];
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

//- (void) drawRect:(NSRect)dirtyRect {
//    [super drawRect:dirtyRect];
//
////    if(_highlightLayer.hidden == NO) {
////        [_highlightLayer setNeedsDisplay]; 
////    }
////
////    for(FLBarTitleLayer* title in _titles) {
////        [title setNeedsDisplay]; 
////    }
//    
//}


@end

//@implementation FLHorizontalBreadcrumbBarView
//
//- (id)initWithFrame:(NSRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        _shape = FLAutorelease([[FLDrawableForwardButtonShape alloc] init]);
//        _shape.edgeInset = 1.0;
//        _shape.edgeInsetColor = [NSColor grayColor];
//        _shape.cornerRadius = 1.0;
//        _shape.shapeSize = 10.0;
//    }
//    
//    return self;
//}
//
//#if FL_MRC
//- (void) dealloc {
//    [_shape release];
//    [super dealloc];
//}
//#endif
//
//- (void)drawRect:(NSRect)dirtyRect {
//    
//    if(self.isEmphasized) {
//        _shape.backgroundColor = [NSColor gray85Color];
//    }
//    else if(self.isHighlighted) {
//        _shape.backgroundColor = [NSColor grayColor];
//    }
//    else {
//        _shape.backgroundColor = [NSColor gray95Color];
//    }
//    
//    [_shape drawRect:dirtyRect withFrame:self.bounds inParent:self drawEnclosedBlock:^{
//        [self drawTitle:dirtyRect];
//    }];
//
//
//    
////    CGContextSaveGState(context);
////    CGContextSetLineCap(context, kCGLineCapSquare);
////    CGContextSetStrokeColorWithColor(context, color);
////    CGContextSetLineWidth(context, 1.0);
////    CGContextMoveToPoint(context, startPoint.x + 0.5, startPoint.y + 0.5);
////    CGContextAddLineToPoint(context, endPoint.x + 0.5, endPoint.y + 0.5);
////    CGContextStrokePath(context);
////    CGContextRestoreGState(context);        
// 
//    
//}
//
//
//
//@end




#endif