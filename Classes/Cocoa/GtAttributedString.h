//
//  GtAttributedString.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/29/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

@interface GtAttributedString : NSObject {
@private
    UIColor* m_color;
    UIColor* m_highlightedColor;
    NSString* m_text;
    GtCallback m_callback;
    UIFont* m_font;
    NSMutableArray* m_runFrames;
    NSMutableArray* m_substrings;
    struct {
        unsigned int isHighlighted: 1;
        unsigned int isTouchable: 1;
        unsigned int isEnabled: 1;
        unsigned int isHidden: 1;
    } m_flags;
    
}

+ (GtAttributedString*) attributedString;

@property (readwrite, retain, nonatomic) UIColor* textColor;
@property (readwrite, retain, nonatomic) UIColor* highlightedTextColor;
@property (readwrite, retain, nonatomic) NSString* text;
@property (readwrite, retain, nonatomic) UIFont* textFont;

@property (readwrite, assign, nonatomic) GtCallback touchedCallback;

@property (readwrite, assign, nonatomic, getter=isHidden) BOOL hidden;
@property (readwrite, assign, nonatomic, getter=isHighlighted) BOOL highlighted;
@property (readwrite, assign, nonatomic, getter=isTouchable) BOOL touchable;
@property (readwrite, assign, nonatomic, getter=isEnabled) BOOL enabled;

// returns copy of built string
@property (readonly, copy, nonatomic) NSAttributedString* attributedString;

// hit detection
- (BOOL) pointInString:(CGPoint) point;

// run frames
@property (readonly, retain, nonatomic) NSMutableArray* runFrames;
- (void) resetRunFrames;
- (void) addRunFrame:(CGRect) frame;

@end
