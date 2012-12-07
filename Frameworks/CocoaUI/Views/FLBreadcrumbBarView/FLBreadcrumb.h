//
//  FLBreadcrumb.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/29/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLCocoa.h"

@class FLBreadcrumb;

typedef void (^FLBreadcrumbTouchedBlock)(FLBreadcrumb* breadcrumb);

@interface FLBreadcrumb : NSObject {
@private
    FLColor* _enabledTextColor;
    FLColor* _disabledTextColor;
    FLColor* _highlightedTextColor;
    FLFont* _textFont;

    NSString* _string;
    FLBreadcrumbTouchedBlock _touchedBlock;
    NSMutableArray* _runFrames;
    
    BOOL _highlighted;
    BOOL _touchable;
    BOOL _enabled;
    BOOL _hidden;
}

// if not set inherits from view
@property (readwrite, strong, nonatomic) FLColor* enabledTextColor;
@property (readwrite, strong, nonatomic) FLColor* disabledTextColor;
@property (readwrite, strong, nonatomic) FLColor* highlightedTextColor;
@property (readonly, strong, nonatomic) FLColor* colorForState;

@property (readwrite, strong, nonatomic) FLFont* textFont;

// touch event
@property (readwrite, copy, nonatomic) FLBreadcrumbTouchedBlock touchedBlock;


// state
@property (readwrite, assign, nonatomic, getter=isHidden) BOOL hidden;
@property (readwrite, assign, nonatomic, getter=isHighlighted) BOOL highlighted;
@property (readwrite, assign, nonatomic, getter=isTouchable) BOOL touchable;
@property (readwrite, assign, nonatomic, getter=isEnabled) BOOL enabled;

// string
@property (readonly, strong, nonatomic) NSAttributedString* attributedString; 
@property (readwrite, strong, nonatomic) NSString* string;

- (id) initWithString:(NSString*) string;

+ (FLBreadcrumb*) breadcrumb;
+ (FLBreadcrumb*) breadcrumb:(NSString*) string;

@end


@interface FLBreadcrumb ()

// hit detection
- (BOOL) pointInString:(CGPoint) point;

// run frames
@property (readonly, strong, nonatomic) NSMutableArray* runFrames;
- (void) resetRunFrames;
- (void) addRunFrame:(CGRect) frame;
@end