//
//  FLGridArrangement.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/18/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLVerticalGridArrangement.h"

@interface FLVerticalGridArrangement ()
@end

@implementation FLVerticalGridArrangement

@synthesize columnCount = _columnCount;
@synthesize cellHeight = _cellHeight;

- (id) init {
    return [self initWithCellHeight:FLVerticalGridArrangementDefaultCellHeight columnCount:1];
}

- (id) initWithCellHeight:(CGFloat) cellHeight {
    return [self initWithCellHeight:cellHeight columnCount:1];
}

- (id) initWithCellHeight:(CGFloat) cellHeight 
              columnCount:(NSUInteger)columnCount {

    self = [super init];
    if(self) {
        self.columnCount = columnCount;
        self.cellHeight = cellHeight;
    }
    return self;
}

+ (FLVerticalGridArrangement*) verticalGridArrangement {
    return FLReturnAutoreleased([[[self class] alloc] init]);
}

+ (FLVerticalGridArrangement*) verticalGridArrangement:(CGFloat) cellHeight {
    return FLReturnAutoreleased([[[self class] alloc] initWithCellHeight:cellHeight]);
}

+ (FLVerticalGridArrangement*) verticalGridArrangement:(CGFloat) cellHeight 
                                         columnCount:(NSUInteger) columnCount {
    return FLReturnAutoreleased([[[self class] alloc] initWithCellHeight:cellHeight columnCount:columnCount]);
}

- (FLSize) layoutArrangeableObjects:(NSArray*) objects
                           inBounds:(FLRect) bounds {

    FLAssert(_columnCount > 0, @"can't have zero columns");
    
    if(_columnCount == 0) {
        return bounds.size;
    }

    CGFloat cellWidth = bounds.size.width / (CGFloat) _columnCount;
    if(!_cellHeight) {
        _cellHeight = round(cellWidth);
    }
    
    NSInteger itemCount = objects.count;
    NSInteger rowCount = ((itemCount / _columnCount) + (((itemCount % _columnCount) > 0) ? 1 : 0));
    
    NSInteger itemIndex = 0;
    FLPoint origin = bounds.origin;
    
    CGFloat maxBottom = 0;

    // layout by rows
    for(NSInteger i = 0; i < rowCount; i++) {
    
        // layout columns in a row
        for(int j = 0; j < _columnCount && itemIndex < itemCount; j++) {
            id object = [objects objectAtIndex:itemIndex++];
            if([object isHidden]) {
                j--;
                continue;
            }

            FLRect frame = FLRectIntegral(FLRectMake(origin.x, origin.y, cellWidth, _cellHeight));
            
            frame = [self setArrangeableFrame:frame forObject:object];
        
            maxBottom = MAX(maxBottom, FLRectGetBottom(frame));
        
            origin.x = FLRectGetRight(frame);
        }
        
        origin.y = maxBottom;
    }
    
    return FLSizeMake(bounds.size.width, maxBottom);
}

@end

