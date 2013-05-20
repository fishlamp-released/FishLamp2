//
//  GtHorizontalCellLayout.m
//  FishLamp-iOS-Lib
//
//  Created by Fullerton Mike on 1/18/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtHorizontalGridViewLayout.h"

@implementation GtHorizontalGridViewLayout

+ (GtHorizontalGridViewLayout*) horizontalCellLayout:(id<GtCellViewLayoutDelegate>) delegate
{
    return GtReturnAutoreleased([[GtHorizontalGridViewLayout alloc] initWithDelegate:delegate]);
}

//- (CGSize) layoutArrangeableViews:(NSArray*) views 
//                         inBounds:(CGRect) bounds
//{
////	CGFloat colWidth = bounds.size.width;
////
////// TODO: Not sure how the margins and padding should work here.
////
//////    CGRect frame = bounds;
//////    bounds.origin.x += self.padding.left;
//////    bounds.origin.y += self.padding.top;
//////    bounds.size.width -= (self.padding.left + self.padding.right);
//////    bounds.size.height -= (self.padding.top + self.padding.bottom);
////
////    CGRect containerBounds = bounds;
////
////    NSInteger count = 0;
////	for(id view in views)
////	{
////		if([view isHidden]) 
////		{
////			continue;
////		}
////
////        containerBounds.origin.x = (containerBounds.size.width * count++);
////
//////        CGRect frame = containerBounds;
//////        bounds.origin.x += self.padding.left;
//////        bounds.origin.y += self.padding.top;
//////        bounds.size.width -= (self.padding.left + self.padding.right);
//////        bounds.size.height -= (self.padding.top + self.padding.bottom);
////
//////		UIEdgeInsets adjustedMargins = [self adjustedMarginsForView:view];
//////		origin.x += adjustedMargins.left;
////		[view setLayoutFrame:containerBounds];
////    }
////    return CGSizeMake(GtRectGetRight(containerBounds), bounds.size.height);
//}

- (CGSize) layoutArrangeableViews:(NSArray*) views 
                         inBounds:(CGRect) bounds
{
    CGSize cellSize = [self.delegate cellViewLayoutGetCellSize:self];

    NSInteger itemCount = views.count;
    NSInteger rowCount = bounds.size.height / cellSize.height;

    NSInteger columnCount = ((itemCount / rowCount) + (((itemCount % rowCount) > 0) ? 1 : 0));
    
    bounds.origin.x += self.padding.left;
    bounds.origin.y += self.padding.top;
    bounds.size.width = (columnCount * cellSize.width) + (self.padding.left + self.padding.right);
    bounds.size.height = (rowCount * cellSize.height) + self.padding.top + self.padding.bottom;

    NSInteger itemIndex = 0;

    for(NSInteger col = 0; col < columnCount; col++)
    {
        for(NSInteger row = 0; row < rowCount; row++)
        {
            id view = [views objectAtIndex:itemIndex++];
            if([view isHidden])
            {
                row--;
                continue;
            }
            
            
            CGRect frame = CGRectMake(  bounds.origin.x + (col * cellSize.width), 
                                        bounds.origin.y + (row * cellSize.height), 
                                        cellSize.width, 
                                        cellSize.height);

            UIEdgeInsets adjustedMargins = [self adjustedMarginsForView:view];
            frame.origin.x += adjustedMargins.left;
            frame.origin.y += adjustedMargins.top;
            frame.size.width -= (adjustedMargins.left + adjustedMargins.right);
            frame.size.height -= (adjustedMargins.top + adjustedMargins.bottom);
            [view setFrame:frame];            
        }
    }
    
    
//    for(NSInteger i = 0; i < rowCount; i++)
//    {
//        for(int j = 0; j < columnCount && itemIndex < itemCount; j++)
//        {
//            id view = [views objectAtIndex:itemIndex++];
//            if([view isHidden])
//            {
//                j--;
//                continue;
//            }
////            UIEdgeInsets adjustedMargins = [self adjustedMarginsForView:view];
//            
//            CGRect frame = CGRectMake(bounds.origin.x + (j * cellSize.width), top, cellSize.width, cellSize.height);
//
////            frame.origin.x += adjustedMargins.left;
////            frame.origin.y += adjustedMargins.top;
////            frame.size.width -= (adjustedMargins.left + adjustedMargins.right);
////            frame.size.height -= (adjustedMargins.top + adjustedMargins.bottom);
//        
//            [view setLayoutFrame:frame];
//        }
//        
//        top += cellSize.height;
//    }
//    
    return bounds.size;
}



@end
