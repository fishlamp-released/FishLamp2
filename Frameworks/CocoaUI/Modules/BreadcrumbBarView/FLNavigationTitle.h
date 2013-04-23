//
//  FLNavigationTitle.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/9/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "FLMouseTrackingView.h"
#import "FLAttributedString.h"

#define FLNavigationTitleDefaultHeight 40

@interface FLNavigationTitle : CALayer<FLMouseHandler> {
@private
    NSString* _localizedTitle;
    NSAttributedString* _attributedString;
    id _identifier;
    FLStringDisplayStyle* _titleStyle;

    BOOL _mouseIn;
    BOOL _mouseDown;
    BOOL _enabled;
    BOOL _emphasized;
    BOOL _highlighted;
    BOOL _willUpdate;
    CGFloat _titleHeight;
}

- (id) initWithIdentifier:(id) identifier localizedTitle:(NSString*) localizedTitle;
+ (id) navigationTitle:(id) identifier localizedTitle:(NSString*) localizedTitle;

@property (readwrite, assign, nonatomic) CGFloat titleHeight;
@property (readonly, strong, nonatomic) id identifier;

@property (readwrite, strong, nonatomic) NSString* localizedTitle;
@property (readwrite, strong, nonatomic) FLStringDisplayStyle* titleStyle;

@property (readwrite, assign, nonatomic, getter=isHighlighted) BOOL highlighted;
@property (readwrite, assign, nonatomic, getter=isEnabled) BOOL enabled;
@property (readwrite, assign, nonatomic, getter=isEmphasized) BOOL emphasized;

@end

