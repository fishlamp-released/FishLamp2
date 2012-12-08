//
//  FLBreadcrumbBarView.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/29/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLView.h"
#import "FLBreadcrumb.h"
#import "FLOrderedCollection.h"

typedef enum { 
    FLVerticalTextAlignmentTop,
    FLVerticalTextAlignmentCenter,
    FLVerticalTextAlignmentBottom
} FLVerticalTextAlignment; 

@interface FLBreadcrumbBarView : FLView {
@private
    FLOrderedCollection* _breadcrumbs;
    FLVerticalTextAlignment _verticalTextAlignment;

    FLColor* _enabledTextColor;
    FLColor* _disabledTextColor;
    FLColor* _highlightedTextColor;
    FLFont* _textFont;
}

@property (readwrite, retain, nonatomic) FLColor* enabledTextColor;
@property (readwrite, retain, nonatomic) FLColor* disabledTextColor;
@property (readwrite, retain, nonatomic) FLColor* highlightedTextColor;
@property (readwrite, retain, nonatomic) FLFont* textFont;

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
