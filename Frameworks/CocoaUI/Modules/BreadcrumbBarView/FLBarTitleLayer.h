//
//  FLBarTitleLayer.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/9/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "FLMouseTrackingView.h"
#import "FLAttributedString.h"

@class FLBarTitleLayer;

@interface FLBarTitleLayer : CALayer<FLMouseHandler> {
@private
    NSString* _title;
    FLStringDisplayStyle* _titleStyle;
    BOOL _mouseIn;
    BOOL _mouseDown;
    BOOL _enabled;
    BOOL _emphasized;
    BOOL _highlighted;
    NSAttributedString* _attributedString;
}

@property (readwrite, assign, nonatomic, getter=isHighlighted) BOOL highlighted;
@property (readwrite, assign, nonatomic, getter=isEnabled) BOOL enabled;
@property (readwrite, assign, nonatomic, getter=isEmphasized) BOOL emphasized;

@property (readwrite, strong, nonatomic) NSString* title;
@property (readwrite, strong, nonatomic) FLStringDisplayStyle* titleStyle;

@end
