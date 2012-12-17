//
//  FLBreadcrumbBarView.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/29/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCocoaUIRequired.h"
#import "FLBreadcrumb.h"
#import "FLOrderedCollection.h"

typedef enum { 
    FLVerticalTextAlignmentTop,
    FLVerticalTextAlignmentCenter,
    FLVerticalTextAlignmentBottom
} FLVerticalTextAlignment; 

@interface FLBreadcrumbBarView : UIView {
@private
    FLOrderedCollection* _breadcrumbs;
    FLVerticalTextAlignment _verticalTextAlignment;

    UIColor* _enabledTextColor;
    UIColor* _disabledTextColor;
    UIColor* _highlightedTextColor;
    UIFont* _textFont;
}

@property (readwrite, retain, nonatomic) UIColor* enabledTextColor;
@property (readwrite, retain, nonatomic) UIColor* disabledTextColor;
@property (readwrite, retain, nonatomic) UIColor* highlightedTextColor;
@property (readwrite, retain, nonatomic) UIFont* textFont;

@property (readwrite, assign, nonatomic) FLVerticalTextAlignment verticalTextAlignment;

@property (readonly, retain, nonatomic) FLOrderedCollection* breadcrumbs;

// returns complete string for whole breadcrumbBar
- (NSAttributedString*) buildAttributedString;

- (FLBreadcrumb*) breadcrumbAtPoint:(CGPoint) point;

- (FLBreadcrumb*) breadcrumbAtIndex:(NSUInteger) index;

- (FLBreadcrumb*) breadcrumbForIndex:(NSString*) key;

- (void) setBreadcrumb:(FLBreadcrumb*) breadcrumb 
                forKey:(NSString*) key;

- (void) setBreadcrumbString:(NSString*) string 
          forBreadcrumbIndex:(NSUInteger) stringIndex;

- (void) setBreadcrumbString:(NSString*) string 
            forBreadcrumbKey:(NSString*) key;

- (void) setStringForAllBreadcrumbs:(NSString*) string; // e.g. @""


@end
