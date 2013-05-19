//
//  FLVisibleGridCellCollection.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/11/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLOrderedCollection.h"

typedef struct {
    NSInteger count;
    NSRange* ranges;
} FLVisibleCellRanges;

NS_INLINE
NSUInteger FLRangeLastIndex(NSRange range) {
    return range.location + range.length - 1;
}

@protocol FLVisibleGridCellCollectionDelegate;

@protocol FLVisibleGridCellCollection <NSObject, NSFastEnumeration> 

@property (readwrite, assign, nonatomic) id<FLVisibleGridCellCollectionDelegate> delegate;

@property (readonly, assign, nonatomic) FLVisibleCellRanges visibleRanges;

@property (readonly, assign, nonatomic) NSInteger count;

- (void) removeAllCells;

- (void) recalculateVisibleCellsInBounds:(CGRect) bounds;

@end

@interface FLContiguousVisibleGridCellCollection : NSObject<FLVisibleGridCellCollection> {
@private
    NSRange _visibleRange;
    __unsafe_unretained id<FLVisibleGridCellCollectionDelegate> _delegate;
}

@end

@protocol FLVisibleGridCellCollectionDelegate <NSObject>
- (void) visibleGridCellCollectionVisibleCellsDidChange:(id<FLVisibleGridCellCollection>) collection;
- (void) visibleGridCellCollection:(id<FLVisibleGridCellCollection>) collection updateCellVisiblityInBounds:(CGRect) bounds;
- (FLOrderedCollection*) visibleGridCellCollectionGetCellCollection:(id<FLVisibleGridCellCollection>) collection;
@end
