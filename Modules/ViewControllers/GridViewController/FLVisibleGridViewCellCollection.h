//
//  FLVisibleGridViewCellCollection.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/11/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
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

@protocol FLVisibleGridViewCellCollectionDelegate;

@protocol FLVisibleGridViewCellCollection <NSObject, NSFastEnumeration> 

@property (readwrite, assign, nonatomic) id<FLVisibleGridViewCellCollectionDelegate> delegate;

@property (readonly, assign, nonatomic) FLVisibleCellRanges visibleRanges;

@property (readonly, assign, nonatomic) NSInteger count;

- (void) removeAllCells;

- (void) recalculateVisibleCellsInBounds:(CGRect) bounds;

@end

@interface FLContiguousVisibleGridViewCellCollection : NSObject<FLVisibleGridViewCellCollection> {
@private
    NSRange _visibleRange;
    id<FLVisibleGridViewCellCollectionDelegate> _delegate;
}

@end

@protocol FLVisibleGridViewCellCollectionDelegate <NSObject>
- (void) visibleGridViewCellCollectionVisibleCellsDidChange:(id<FLVisibleGridViewCellCollection>) collection;
- (void) visibleGridViewCellCollection:(id<FLVisibleGridViewCellCollection>) collection updateCellVisiblityInBounds:(CGRect) bounds;
- (FLOrderedCollection*) visibleGridViewCellCollectionGetCellCollection:(id<FLVisibleGridViewCellCollection>) collection;
@end
