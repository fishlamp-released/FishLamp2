//
//  FLNavigationTitle.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/9/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "FLMouseTrackingView.h"
//#import "FLAttributedString.h"
#import "FLAttributedStringController.h"

#define FLNavigationTitleDefaultHeight 40

@interface FLNavigationTitle : CALayer<FLMouseHandler, FLAttributedStringControllerDelegate> {
@private
    FLAttributedStringController* _stringController;
    id _identifier;

    BOOL _mouseIn;
    BOOL _mouseDown;
    BOOL _enabled;
    BOOL _emphasized;
    BOOL _highlighted;
    BOOL _willUpdate;
    CGFloat _titleHeight;
}

- (id) initWithIdentifier:(id) identifier;
+ (id) navigationTitle:(id) identifier;

@property (readwrite, assign, nonatomic) CGFloat titleHeight;
@property (readonly, strong, nonatomic) id identifier;

@property (readwrite, strong, nonatomic) NSString* localizedTitle;

@property (readwrite, assign, nonatomic, getter=isHighlighted) BOOL highlighted;
@property (readwrite, assign, nonatomic, getter=isEnabled) BOOL enabled;
@property (readwrite, assign, nonatomic, getter=isEmphasized) BOOL emphasized;

@end

