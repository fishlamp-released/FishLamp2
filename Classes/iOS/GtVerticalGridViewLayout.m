//
//  GtGridViewLayout.m
//  FishLamp-iOS-Lib
//
//  Created by Fullerton Mike on 1/18/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtVerticalGridViewLayout.h"

@implementation GtVerticalGridViewLayout

+ (GtVerticalGridViewLayout*) gridViewLayout:(id<GtCellViewLayoutDelegate>) delegate
{
    return GtReturnAutoreleased([[GtVerticalGridViewLayout alloc] initWithDelegate:delegate]);
}

- (CGSize) layoutArrangeableViews:(NSArray*) views 
                         inBounds:(CGRect) bounds
{
    CGSize cellSize = [self.delegate cellViewLayoutGetCellSize:self];

    NSInteger itemCount = views.count;
    NSInteger columnCount = bounds.size.width / cellSize.width;
    NSInteger rowCount = ((itemCount / columnCount) + (((itemCount % columnCount) > 0) ? 1 : 0));
    
    bounds.origin.x += self.padding.left;
    bounds.origin.y += self.padding.top;
    bounds.size.width = (columnCount * cellSize.width) + self.padding.left + self.padding.right;
    bounds.size.height = (rowCount * cellSize.height) + self.padding.top + self.padding.bottom;

    NSInteger itemIndex = 0;
    CGFloat top = bounds.origin.y;
    
    for(NSInteger i = 0; i < rowCount; i++)
    {
        for(int j = 0; j < columnCount && itemIndex < itemCount; j++)
        {
            id view = [views objectAtIndex:itemIndex++];
            if([view isHidden])
            {
                j--;
                continue;
            }

            UIEdgeInsets adjustedMargins = [self adjustedMarginsForView:view];
            CGRect frame = CGRectMake(bounds.origin.x + (j * cellSize.width), top, cellSize.width, cellSize.height);

            frame.origin.x += adjustedMargins.left;
            frame.origin.y += adjustedMargins.top;
            frame.size.width -= (adjustedMargins.left + adjustedMargins.right);
            frame.size.height -= (adjustedMargins.top + adjustedMargins.bottom);
        
            [view setFrame:frame];
        }
        
        top += cellSize.height;
    }
    
    return bounds.size;
}

@end

