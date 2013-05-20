//
//  GtOrderedCollection.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/11/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtOrderedCollection.h"

#import "GtGridViewController.h"

@implementation GtOrderedCollection (GtGridViewController)

- (void) addOrReplaceCellsWithGridViewObjects:(NSArray*) itemArray 
                            itemArrayRange:(NSRange) inRange
                                   atIndex:(NSUInteger) atIndex
{
    for(NSUInteger i = inRange.location; i < MIN(inRange.location + inRange.length, itemArray.count); i++)
    {
// TODO: add support for caching cells?

        id object = [itemArray objectAtIndex:i];
           
        GtGridViewCellController* cell = [object createGridViewCell];
        GtAssertNotNil(cell);

        if(self.count < (i + 1))
        {
            [self addObject:cell forKey:[object gridViewObjectID]];
        }
        else
        {
            [self replaceObjectAtIndex:i withObject:cell forKey:[object gridViewObjectID]];
        }
    }
}

- (void) addOrReplaceCellsWithGridViewObjects:(NSArray*) itemArray 
                        atIndex:(NSUInteger) atDestinationIndex
{
    NSRange range = { 0, itemArray.count };
    [self addOrReplaceCellsWithGridViewObjects:itemArray itemArrayRange:range atIndex:atDestinationIndex];
}

- (void) addCellWithItem:(id) object
{
    GtGridViewCellController* cell = [object createGridViewCell];
    GtAssertNotNil(cell);

    [self addObject:cell forKey:[object gridViewObjectID]];
}

@end
