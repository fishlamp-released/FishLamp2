//
//  FLBreadcrumbBarView.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/15/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "FLAttributedString.h"
#import "FLOrderedCollection.h"
#import "FLDrawableString.h"
#import "FLDrawableShape.h"

@interface FLBreadcrumbBarView : UIView {
@private
    FLAttributedString* _title;
    dispatch_block_t _touched;
    
    FLDrawableForwardButtonShape* _shape;
    
    NSTrackingArea* _trackingArea;
    BOOL _mouseIn;
    BOOL _mouseDown;
}

@property (readwrite, assign, nonatomic, getter=isHighlighted) BOOL highlighted;
@property (readwrite, assign, nonatomic, getter=isEnabled) BOOL enabled;
@property (readwrite, assign, nonatomic, getter=isEmphasized) BOOL emphasized;

@property (readwrite, strong, nonatomic) FLAttributedString* title;
@property (readwrite, copy, nonatomic) dispatch_block_t touched;

- (void) didLayout;

@end
