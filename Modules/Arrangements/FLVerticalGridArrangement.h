//
//  FLGridArrangement.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/18/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FishLampCocoa.h"
#import "FLArrangement.h"

#define FLVerticalGridArrangementDefaultCellHeight 60.0f

@class FLVerticalGridArrangement;

@interface FLVerticalGridArrangement : FLArrangement {
@private
    NSUInteger _columnCount;
    CGFloat _cellHeight;
}

@property (readwrite, assign, nonatomic) CGFloat cellHeight;
@property (readwrite, assign, nonatomic) NSUInteger columnCount;

- (id) initWithCellHeight:(CGFloat) cellHeight;

- (id) initWithCellHeight:(CGFloat) cellHeight
              columnCount:(NSUInteger) columnCount;

+ (FLVerticalGridArrangement*) verticalGridArrangement;

+ (FLVerticalGridArrangement*) verticalGridArrangement:(CGFloat) cellHeight;

+ (FLVerticalGridArrangement*) verticalGridArrangement:(CGFloat) cellHeight
                                         columnCount:(NSUInteger) columnCount;


@end
