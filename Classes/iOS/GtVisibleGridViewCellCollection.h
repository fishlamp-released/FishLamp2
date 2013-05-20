//
//  GtVisibleGridViewCellCollection.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/11/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtOrderedCollection.h"

typedef struct {
    NSInteger count;
    NSRange* ranges;
} GtVisibleCellRanges;

NS_INLINE
NSInteger GtRangeLastIndex(NSRange range)
{
    return range.location + range.length - 1;
}

@protocol GtVisibleGridViewCellCollectionDelegate;

@protocol GtVisibleGridViewCellCollection <NSObject, NSFastEnumeration> 

@property (readwrite, assign, nonatomic) id<GtVisibleGridViewCellCollectionDelegate> delegate;

@property (readonly, assign, nonatomic) GtVisibleCellRanges visibleRanges;

@property (readonly, assign, nonatomic) NSInteger count;

- (void) removeAllCells;

- (void) recalculateVisibleCellsInBounds:(CGRect) bounds;

@end

@interface GtContiguousVisibleGridViewCellCollection : NSObject<GtVisibleGridViewCellCollection> {
@private
    NSRange m_visibleRange;
    id<GtVisibleGridViewCellCollectionDelegate> m_delegate;
}

@end

@protocol GtVisibleGridViewCellCollectionDelegate <NSObject>
- (void) visibleGridViewCellCollectionVisibleCellsDidChange:(id<GtVisibleGridViewCellCollection>) collection;
- (void) visibleGridViewCellCollection:(id<GtVisibleGridViewCellCollection>) collection updateCellVisiblityInBounds:(CGRect) bounds;
- (GtOrderedCollection*) visibleGridViewCellCollectionGetCellCollection:(id<GtVisibleGridViewCellCollection>) collection;

@end
