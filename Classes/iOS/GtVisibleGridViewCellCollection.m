//
//  GtVisibleGridViewCellCollection.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/11/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtVisibleGridViewCellCollection.h"
#import "GtGridViewController.h"

#if DEBUG
#define HARDCORE_DEBUG 0
#define TRACE 0
#endif

@implementation GtContiguousVisibleGridViewCellCollection

@synthesize delegate = m_delegate;

- (NSInteger) count
{
    return m_visibleRange.length;
}

- (void) removeAllCells
{
    m_visibleRange.location = 0;
    m_visibleRange.length = 0;
    [m_delegate visibleGridViewCellCollectionVisibleCellsDidChange:self];
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id *)stackbuf count:(NSUInteger)len
{
    NSInteger lastIndex = GtRangeLastIndex(m_visibleRange);

    GtOrderedCollection* cells = [m_delegate visibleGridViewCellCollectionGetCellCollection:self];

    if(state->state == 0)
    {
        NSUInteger cellCount = cells.count;
        
        if( m_visibleRange.length <= 0 ||
            m_visibleRange.location >= cellCount)
        {
            return 0;
        }

        state->state = m_visibleRange.location;
        
        if(lastIndex >= (NSInteger) cellCount)
        {
            m_visibleRange.length = cells.count - m_visibleRange.location;
        }
    }

	if( state->state > (unsigned long) lastIndex)
	{
		return 0;
	}
	
	NSRange range = NSMakeRange(state->state, len);
	if(GtRangeLastIndex(range) > lastIndex)
	{
		range.length = lastIndex - range.location + 1;
	}
	
	[cells.objectArray getObjects:stackbuf range:range];
	
	state->state = GtRangeLastIndex(range) + 1;
	state->itemsPtr = stackbuf;
	state->mutationsPtr = (unsigned long*) self;

	return range.length;
}

- (NSInteger) _findFirstIndexInVisibleBounds:(CGRect) bounds forCellCollection:(GtOrderedCollection*) cells
{
    NSInteger newFirstIndex = NSNotFound;
    
    NSUInteger count = cells.count;
    if(count > 0)
    {
        // make sure we have a valid startIndex;
        NSInteger startIndex = m_visibleRange.location;
        
        if(startIndex == NSNotFound || startIndex >= (NSInteger) count)
        {
            startIndex = 0;
        }

#if TRACE
        static unsigned long long s_count = 0;
        static unsigned long long s_searchTally = 0;
        NSInteger thisSearch = 0;
        ++s_count;
#endif
        
        NSArray* array = cells.objectArray;
        
        NSInteger backwardIndex = startIndex;
        NSInteger forwardIndex = startIndex + 1;
        while(backwardIndex >= 0 || forwardIndex < (NSInteger) count)
        {
#if TRACE
            ++thisSearch;
#endif
        
            if(backwardIndex >= 0) 
            {
                if(CGRectIntersectsRect([[array objectAtIndex:backwardIndex] frame], bounds))
                {
                    for(NSInteger i = backwardIndex - 1; i >= 0; i--)
                    {
#if TRACE
                        ++thisSearch;
#endif

                        GtGridViewCellController* cell = [array objectAtIndex:i];
                        if(CGRectIntersectsRect(cell.frame, bounds))
                        {
                            backwardIndex = i;
                        }
                        else
                        {
                            break;
                        }
                    }
                    
                    newFirstIndex = backwardIndex;
                    break;
                }
                --backwardIndex;
            }
            
            if(forwardIndex < (NSInteger) count)
            {
                if(CGRectIntersectsRect([[array objectAtIndex:forwardIndex] frame], bounds))
                {
                    newFirstIndex = forwardIndex;
                    break;
                }
                
                ++forwardIndex;
            }
        }
        
        GtAssert(newFirstIndex != NSNotFound, @"didn't find first cell");
        
#if TRACE
        s_searchTally += thisSearch;
        GtLog(@"Average search: %f, this search: %d", ((float) s_searchTally) / ((float) s_count), thisSearch);
#endif        
    }
    return newFirstIndex;
}


- (NSInteger)  _findLastIndexFromNewFirstIndex:(NSInteger) firstIndex
                                 visibleBounds:(CGRect) visibleBounds
                             forCellCollection:(GtOrderedCollection*) cells
{
    NSUInteger count = cells.count;
    NSInteger lastMatching = NSNotFound;
    NSArray* array = cells.objectArray;
       
    for(NSInteger i = firstIndex; i < (NSInteger) count; i++)
    {
        GtGridViewCellController* cell = [array objectAtIndex:i];
        if(CGRectIntersectsRect(cell.frame, visibleBounds))
        {
            lastMatching = i;
        }
        else
        {
            break;
        }    
    }
    
    return lastMatching;
}

- (void) recalculateVisibleCellsInBounds:(CGRect) visibleBounds 
{
    [m_delegate visibleGridViewCellCollection:self updateCellVisiblityInBounds:visibleBounds];

    NSRange newRange = NSMakeRange(0,0);
    
    GtOrderedCollection* cells = [m_delegate visibleGridViewCellCollectionGetCellCollection:self];

    NSInteger firstIndex = [self _findFirstIndexInVisibleBounds:visibleBounds forCellCollection:cells];
    if(firstIndex != NSNotFound)
    {
        NSInteger lastIndex = [self _findLastIndexFromNewFirstIndex:firstIndex visibleBounds:visibleBounds forCellCollection:cells];
        if(lastIndex != NSNotFound)
        {
            newRange.location = firstIndex;
            newRange.length = lastIndex - firstIndex + 1;
        }
    }

    m_visibleRange = newRange;

    [m_delegate visibleGridViewCellCollection:self updateCellVisiblityInBounds:visibleBounds];
    
    [m_delegate visibleGridViewCellCollectionVisibleCellsDidChange:self];

#if HARDCORE_DEBUG
    NSUInteger count = cells.count;
    for(int i = 0; i < count; i++)
    {
        GtGridViewCell* cell = [cells cellAtIndex:i];
    
        GtAssert(cell.visible == CGRectIntersectsRect(cell.frame, visibleBounds), @"Rect visibility for cell %d is wrong", i);
    }
#endif

#if TRACE
    GtLog(@"Cells %d - %d visible", m_visibleRange.location, GtRangeLastIndex(m_visibleRange));
#endif
}


- (GtVisibleCellRanges) visibleRanges
{
    GtVisibleCellRanges ranges = { 1, &m_visibleRange };
    return ranges;
}



@end

