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

@protocol FLBarTitleStyleProvider;

@interface FLBarTitleLayer : CALayer<FLMouseHandler> {
@private
    NSString* _title;
    BOOL _mouseIn;
    BOOL _mouseDown;
    BOOL _enabled;
    BOOL _emphasized;
    BOOL _highlighted;
    NSAttributedString* _attributedString;
    
    __unsafe_unretained id<FLBarTitleStyleProvider> _titleDelegate;
}
@property (readwrite, assign, nonatomic) id<FLBarTitleStyleProvider> styleProvider;


@property (readwrite, assign, nonatomic, getter=isHighlighted) BOOL highlighted;
@property (readwrite, assign, nonatomic, getter=isEnabled) BOOL enabled;
@property (readwrite, assign, nonatomic, getter=isEmphasized) BOOL emphasized;

@property (readwrite, strong, nonatomic) NSString* title;

@end

@protocol FLBarTitleStyleProvider <NSObject>

- (FLStringDisplayStyle*) barTitleLayerGetStringDisplayStyle:(FLBarTitleLayer*) title;

@end