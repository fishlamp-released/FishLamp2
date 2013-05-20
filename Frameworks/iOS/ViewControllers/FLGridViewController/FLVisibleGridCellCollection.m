//
//  FLVisibleGridCellCollection.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/11/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLVisibleGridCellCollection.h"
#import "FLGridViewController.h"

#if DEBUG
#define HARDCORE_DEBUG 0
#define TRACE 0
#endif

@implementation FLContiguousVisibleGridCellCollection

@synthesize delegate = _delegate;

- (NSInteger) count {
    return _visibleRange.length;
}

- (void) removeAllCells {
    _visibleRange.location = 0;
    _visibleRange.length = 0;
    [_delegate visibleGridCellCollectionVisibleCellsDidChange:self];
}

FIXME("MF: This looks ass slow. Self, try again.")

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state 
                                  objects:(__unsafe_unretained id *)stackbuf
                                    count:(NSUInteger)len {

    NSInteger lastIndex = FLRangeLastIndex(_visibleRange);

    // wtf - this is bad to be calling here!!
    // can we cache this or something for the duration of the iteration?
    FLOrderedCollection* cells = [_delegate visibleGridCellCollectionGetCellCollection:self];

    if(state->state == 0) {
        NSUInteger cellCount = cells.count;
        
        if( _visibleRange.length <= 0 ||
            _visibleRange.location >= cellCount) {
            return 0;
        }

        state->state = _visibleRange.location;
        
        if(lastIndex >= cellCount) {
            _visibleRange.length = cells.count - _visibleRange.location;
        }
    }

	if( state->state > lastIndex) {
		return 0;
	}
	
	NSRange range = NSMakeRange(state->state, len);
	if(FLRangeLastIndex(range) > lastIndex) {
		range.length = lastIndex - range.location + 1;
	}
	
    // it'd be nice if we could just set itemsPtr here?
	[cells.objectArray getObjects:stackbuf range:range];
	
	state->state = FLRangeLastIndex(range) + 1;
	state->itemsPtr = stackbuf;
    
    // TODO should use a real mutations count here.
	state->mutationsPtr = bridge_(void*, self);

	return range.length;
}

- (NSString*) description {

    NSMutableString* string = [NSMutableString string];
    
    [string appendFormat:@"Visible range start: %d, length: %d", _visibleRange.location, _visibleRange.length];
    
    return string;
}


- (NSInteger) _findFirstIndexInVisibleBounds:(CGRect) bounds 
                           forCellCollection:(FLOrderedCollection*) cells {
    
    NSInteger newFirstIndex = NSNotFound;
    
    NSUInteger count = cells.count;
    if(count > 0) {
        // make sure we have a valid startIndex;
        NSInteger startIndex = _visibleRange.location;
        
        if(startIndex == NSNotFound || startIndex >= count) {
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
        while(backwardIndex >= 0 || forwardIndex < count) {
#if TRACE
            ++thisSearch;
#endif
        
            if(backwardIndex >= 0) {
                if(CGRectIntersectsRect([[array objectAtIndex:backwardIndex] frame], bounds)) {
                
// ug. a loop within a loop is never good.                
                    for(NSInteger i = backwardIndex - 1; i >= 0; i--) {
#if TRACE
                        ++thisSearch;
#endif

                        FLGridCell* cell = [array objectAtIndex:i];
                        if(CGRectIntersectsRect(cell.frame, bounds)){
                            backwardIndex = i;
                        }
                        else {
                            break;
                        }
                    }
                    
                    newFirstIndex = backwardIndex;
                    break;
                }
                --backwardIndex;
            }
            
            if(forwardIndex < count) {
                if(CGRectIntersectsRect([[array objectAtIndex:forwardIndex] frame], bounds)) {
                    newFirstIndex = forwardIndex;
                    break;
                }
                
                ++forwardIndex;
            }
        }
        
        FLAssertWithComment(newFirstIndex != NSNotFound, @"didn't find first cell");
        
#if TRACE
        s_searchTally += thisSearch;
        FLLog(@"Average search: %f, this search: %d", ((float) s_searchTally) / ((float) s_count), thisSearch);
#endif        
    }
    return newFirstIndex;
}


- (NSInteger)  _findLastIndexFromNewFirstIndex:(NSInteger) firstIndex
                                 visibleBounds:(CGRect) visibleBounds
                             forCellCollection:(FLOrderedCollection*) cells {
    NSUInteger count = cells.count;
    NSInteger lastMatching = NSNotFound;
    NSArray* array = cells.objectArray;
       
    for(NSInteger i = firstIndex; i < count; i++) {
        FLGridCell* cell = [array objectAtIndex:i];
        if(CGRectIntersectsRect(cell.frame, visibleBounds)) {
            lastMatching = i;
        }
        else {
            break;
        }    
    }
    
    return lastMatching;
}

- (void) recalculateVisibleCellsInBounds:(CGRect) visibleBounds  {
    
    [_delegate visibleGridCellCollection:self updateCellVisiblityInBounds:visibleBounds];

    NSRange newRange = NSMakeRange(0,0);
    
    FLOrderedCollection* cells = [_delegate visibleGridCellCollectionGetCellCollection:self];

    NSInteger firstIndex = [self _findFirstIndexInVisibleBounds:visibleBounds forCellCollection:cells];
    if(firstIndex != NSNotFound) {
        NSInteger lastIndex = [self _findLastIndexFromNewFirstIndex:firstIndex visibleBounds:visibleBounds forCellCollection:cells];
        if(lastIndex != NSNotFound) {
            newRange.location = firstIndex;
            newRange.length = lastIndex - firstIndex + 1;
        }
    }

    _visibleRange = newRange;

    [_delegate visibleGridCellCollection:self updateCellVisiblityInBounds:visibleBounds];
    
    [_delegate visibleGridCellCollectionVisibleCellsDidChange:self];

#if HARDCORE_DEBUG
    NSUInteger count = cells.count;
    for(int i = 0; i < count; i++) {
        FLGridCell* cell = [cells cellAtIndex:i];
    
        FLAssertWithComment(cell.visible == CGRectIntersectsRect(cell.frame, visibleBounds), @"Rect visibility for cell %d is wrong", i);
    }
#endif

#if TRACE
    FLLog(@"Cells %d - %d visible", _visibleRange.location, FLRangeLastIndex(_visibleRange));
#endif
}


- (FLVisibleCellRanges) visibleRanges {
    FLVisibleCellRanges ranges = { 1, &_visibleRange };
    return ranges;
}

@end

