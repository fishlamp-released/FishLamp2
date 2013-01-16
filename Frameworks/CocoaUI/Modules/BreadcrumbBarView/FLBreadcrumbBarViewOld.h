//
//  FLBreadcrumbBarView.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/29/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCocoaUIRequired.h"
#import "FLAttributedString.h"
#import "FLOrderedCollection.h"
#import "FLDrawableString.h"
#import "FLBatchDictionary.h"

@interface FLBreadcrumbBarViewOld : UIView {
@private
    FLOrderedCollection* _strings;
    FLVerticalTextAlignment _verticalTextAlignment;

    UIColor* _enabledTextColor;
    UIColor* _disabledTextColor;
    UIColor* _highlightedTextColor;
    UIFont* _textFont;

    FLMutableBatchDictionary* _runFrames;
}

@property (readwrite, retain, nonatomic) UIColor* enabledTextColor;
@property (readwrite, retain, nonatomic) UIColor* disabledTextColor;
@property (readwrite, retain, nonatomic) UIColor* highlightedTextColor;
@property (readwrite, retain, nonatomic) UIFont* textFont;

@property (readwrite, assign, nonatomic) FLVerticalTextAlignment verticalTextAlignment;

@property (readonly, retain, nonatomic) FLOrderedCollection* strings;

// returns complete string for whole stringBar
- (NSAttributedString*) buildAttributedString;

- (FLAttributedString*) stringAtPoint:(CGPoint) point;

- (FLAttributedString*) stringAtIndex:(NSUInteger) index;

- (FLAttributedString*) stringForKey:(NSString*) key;

- (void) setAttributedString:(FLAttributedString*) string 
                      forKey:(NSString*) key;

- (void) setString:(NSString*) string 
           atIndex:(NSUInteger) stringIndex;

- (void) setString:(NSString*) string 
            forKey:(NSString*) key;

- (void) setStringForAllStrings:(NSString*) string; // e.g. @""


@end
