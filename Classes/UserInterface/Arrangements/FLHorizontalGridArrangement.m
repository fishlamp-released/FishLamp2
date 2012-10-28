//
//  FLHorizontalCellLayout.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/18/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLHorizontalGridArrangement.h"

@implementation FLHorizontalGridArrangement

+ (FLHorizontalGridArrangement*) horizontalCellLayout
{
    return FLReturnAutoreleased([[[self class] alloc] init]);
}

//- (FLSize) performArrangement:(NSArray*) views 
//                         inBounds:(FLRect) bounds
//{
////	CGFloat colWidth = bounds.size.width;
////
////// TODO: Not sure how the margins and innerInsets should work here.
////
//////    FLRect frame = bounds;
//////    bounds.origin.x += self.innerInsets.left;
//////    bounds.origin.y += self.innerInsets.top;
//////    bounds.size.width -= (self.innerInsets.left + self.innerInsets.right);
//////    bounds.size.height -= (self.innerInsets.top + self.innerInsets.bottom);
////
////    FLRect containerBounds = bounds;
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
//////        FLRect frame = containerBounds;
//////        bounds.origin.x += self.innerInsets.left;
//////        bounds.origin.y += self.innerInsets.top;
//////        bounds.size.width -= (self.innerInsets.left + self.innerInsets.right);
//////        bounds.size.height -= (self.innerInsets.top + self.innerInsets.bottom);
////
//////		FLEdgeInsets adjustedMargins = [self addouterInsetsToInsets:view];
//////		origin.x += adjustedMargins.left;
////		[view setLayoutFrame:containerBounds];
////    }
////    return FLSizeMake(FLRectGetRight(containerBounds), bounds.size.height);
//}

- (FLSize) layoutArrangeableObjects:(NSArray*) objects
                         inBounds:(FLRect) bounds {

/*
    FLSize cellSize = [self.delegate cellViewLayoutGetCellSize:self inBounds:bounds];

    NSInteger itemCount = views.count;
    NSInteger rowCount = bounds.size.height / cellSize.height;

    NSInteger columnCount = ((itemCount / rowCount) + (((itemCount % rowCount) > 0) ? 1 : 0));
    
    bounds.origin.x += self.innerInsets.left;
    bounds.origin.y += self.innerInsets.top;
    bounds.size.width = (columnCount * cellSize.width) + (self.innerInsets.left + self.innerInsets.right);
    bounds.size.height = (rowCount * cellSize.height) + self.innerInsets.top + self.innerInsets.bottom;

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
            
            
            FLRect frame = FLRectMake(  bounds.origin.x + (col * cellSize.width), 
                                        bounds.origin.y + (row * cellSize.height), 
                                        cellSize.width, 
                                        cellSize.height);

            FLEdgeInsets adjustedMargins = [self addouterInsetsToInsets:view];
            frame.origin.x += adjustedMargins.left;
            frame.origin.y += adjustedMargins.top;
            frame.size.width -= (adjustedMargins.left + adjustedMargins.right);
            frame.size.height -= (adjustedMargins.top + adjustedMargins.bottom);
            [view setFrame:frame];            
        }
    }
*/

    
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
////            FLEdgeInsets adjustedMargins = [self addouterInsetsToInsets:view];
//            
//            FLRect frame = FLRectMake(bounds.origin.x + (j * cellSize.width), top, cellSize.width, cellSize.height);
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
