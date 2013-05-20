//
//  GtAttributedStringView.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/29/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtAttributedString.h"
#import "GtOrderedCollection.h"

typedef enum { 
    GtVerticalTextAlignmentTop,
    GtVerticalTextAlignmentCenter,
    GtVerticalTextAlignmentBottom
} GtVerticalTextAlignment; 

@interface GtAttributedStringView : UIView {
@private
    GtOrderedCollection* m_strings;
    CTFrameRef m_frameRef;
    GtVerticalTextAlignment m_verticalTextAlignment;
}
@property (readwrite, assign, nonatomic) GtVerticalTextAlignment verticalTextAlignment;
@property (readonly, retain, nonatomic) GtOrderedCollection* strings;

// returns new string
- (NSAttributedString*) buildAttributedString;

- (GtAttributedString*) stringForPoint:(CGPoint) point;

- (void) addAttributedString:(GtAttributedString*) string forKey:(NSString*) key;
//- (void) insertAttributedString:(GtAttributedString*) string atIndex:(NSUInteger) atIndex forKey:(NSString*) key;

- (GtAttributedString*) attributedStringForIndex:(NSUInteger) index;
- (GtAttributedString*) attributedStringForKey:(NSString*) key;

- (void) updateString:(NSString*) string atIndex:(NSUInteger) stringIndex;
- (void) updateString:(NSString*) string forKey:(NSString*) key;

- (void) clearAllStrings; // leaves the list though


@end
