//
//  FLAttributedStringView.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/29/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLTouchableString.h"
#import "FLOrderedCollection.h"

typedef enum { 
    FLVerticalTextAlignmentTop,
    FLVerticalTextAlignmentCenter,
    FLVerticalTextAlignmentBottom
} FLVerticalTextAlignment; 

@interface FLTouchableStringView : UIView {
@private
    FLOrderedCollection* _strings;
    CTFrameRef _frameRef;
    FLVerticalTextAlignment _verticalTextAlignment;
}
@property (readwrite, assign, nonatomic) FLVerticalTextAlignment verticalTextAlignment;
@property (readonly, retain, nonatomic) FLOrderedCollection* strings;

// returns new string
- (NSAttributedString*) buildAttributedString;

- (FLTouchableString*) stringForPoint:(CGPoint) point;

- (void) addAttributedString:(FLTouchableString*) string forKey:(NSString*) key;
//- (void) insertAttributedString:(FLAttributedString*) string atIndex:(NSUInteger) atIndex forKey:(NSString*) key;

- (FLTouchableString*) attributedStringForIndex:(NSUInteger) index;
- (FLTouchableString*) attributedStringForKey:(NSString*) key;

- (void) updateString:(NSString*) string atIndex:(NSUInteger) stringIndex;
- (void) updateString:(NSString*) string forKey:(NSString*) key;

- (void) clearAllStrings; // leaves the list though


@end
