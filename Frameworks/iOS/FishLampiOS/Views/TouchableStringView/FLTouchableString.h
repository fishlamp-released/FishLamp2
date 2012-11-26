//
//  FLTouchableString.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/29/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLCallback_t.h"

@interface FLTouchableString : NSObject {
@private
    UIColor* _color;
    UIColor* _highlightedColor;
    NSString* _text;
    FLCallback_t _callback;
    UIFont* _font;
    NSMutableArray* _runFrames;
    struct {
        unsigned int isHighlighted: 1;
        unsigned int isTouchable: 1;
        unsigned int isEnabled: 1;
        unsigned int isHidden: 1;
    } _flags;
    
}

+ (FLTouchableString*) touchableString;

@property (readwrite, retain, nonatomic) UIColor* textColor;
@property (readwrite, retain, nonatomic) UIColor* highlightedTextColor;
@property (readwrite, retain, nonatomic) NSString* text;
@property (readwrite, retain, nonatomic) UIFont* textFont;

@property (readwrite, assign, nonatomic) FLCallback_t touchedCallback;

@property (readwrite, assign, nonatomic, getter=isHidden) BOOL hidden;
@property (readwrite, assign, nonatomic, getter=isHighlighted) BOOL highlighted;
@property (readwrite, assign, nonatomic, getter=isTouchable) BOOL touchable;
@property (readwrite, assign, nonatomic, getter=isEnabled) BOOL enabled;

// returns copy of built string
@property (readonly, copy, nonatomic) NSAttributedString* attributedString;

// hit detection
- (BOOL) pointInString:(FLPoint) point;

// run frames
@property (readonly, retain, nonatomic) NSMutableArray* runFrames;
- (void) resetRunFrames;
- (void) addRunFrame:(FLRect) frame;

@end
