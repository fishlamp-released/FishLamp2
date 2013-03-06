//
//  FLBreadcrumbBarView.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/15/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#if OSX
#import <Cocoa/Cocoa.h>

#import "FLAttributedString.h"
#import "FLOrderedCollection.h"
#import "FLDrawableString.h"
#import "FLDrawableShape.h"

@class FLBreadcrumbBarView;

typedef void (^FLBreadcrumbBarViewTouchedBlock)(FLBreadcrumbBarView* view);

@interface FLBreadcrumbBarView : UIView {
@private
    NSString* _title;
    FLStringDisplayStyle* _titleStyle;
    FLBreadcrumbBarViewTouchedBlock _touchedBlock;
    NSTrackingArea* _trackingArea;

    BOOL _mouseIn;
    BOOL _mouseDown;
    BOOL _enabled;
    BOOL _emphasized;
    BOOL _highlighted;

    NSColor* _lineColor;
    BOOL _drawTopLine;
}

@property (readwrite, strong, nonatomic) NSColor* lineColor;
@property (readwrite, assign, nonatomic) BOOL drawTopLine;
@property (readwrite, assign, nonatomic, getter=isHighlighted) BOOL highlighted;
@property (readwrite, assign, nonatomic, getter=isEnabled) BOOL enabled;
@property (readwrite, assign, nonatomic, getter=isEmphasized) BOOL emphasized;

@property (readwrite, strong, nonatomic) NSString* title;
@property (readwrite, strong, nonatomic) FLStringDisplayStyle* titleStyle;
@property (readwrite, copy, nonatomic) FLBreadcrumbBarViewTouchedBlock touchedBlock;

- (void) didLayout;

@end

@interface FLHorizontalBreadcrumbBarView : FLBreadcrumbBarView {
@private
    FLDrawableForwardButtonShape* _shape;
}

@end
#endif