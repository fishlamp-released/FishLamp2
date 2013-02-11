//
//  FLZenfolioGroupElement+Selection.m
//  FishLampConnect
//
//  Created by Mike Fullerton on 1/29/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLZenfolioGroup+Selection.h"

@implementation FLZenfolioGroupElement (Selection)

- (void) addSelectionsToIndexedSet:(NSMutableIndexSet*) set 
                     fromSelection:(NSSet*) selection 
                     currentIndex:(NSUInteger*) currentIndex {
    
    if([selection containsObject:self]) {
        [set addIndex:*currentIndex];
    }
    
    ++(*currentIndex);
    
    for(FLZenfolioGroupElement* element in self.elements) {
        [element addSelectionsToIndexedSet:set fromSelection:selection currentIndex:currentIndex];
    }
}     

- (FLZenfolioGroupElement*) elementAtIndex:(NSInteger) elementIndex counter:(NSInteger*) counter {
    if(elementIndex == (*counter)++) {
        return self;
    }
    
    for(FLZenfolioGroupElement* element in self.elements) {
        FLZenfolioGroupElement* found = [element elementAtIndex:elementIndex counter:counter];
        if(found) {
            return found;
        }
    }
    
    return nil;
}

@end

@implementation FLZenfolioGroup (Selection) 

- (NSIndexSet*) indexSetForSelection:(NSSet*) selection {
    NSMutableIndexSet* set = [NSMutableIndexSet indexSet];
    NSUInteger index = 0;
    [self addSelectionsToIndexedSet:set fromSelection:selection currentIndex:&index];
    return set;
}

- (NSArray *) photoSetsInSelection:(NSSet*) selection {
	NSMutableArray *selectedSets = [NSMutableArray array];
    [self visitAllElements:^(FLZenfolioGroupElement* element, BOOL* stop) {
        if(!element.isGroupElement && [selection containsObject:element]) {
            [selectedSets addObject:element];
        }
    }];
	return selectedSets;
}

- (long long) selectedPhotoBytesInSelection:(NSSet*) selection {

	NSArray *elem = [self photoSetsInSelection:selection];
	return elem ? [[elem valueForKeyPath:@"@sum.photoBytes"] longLongValue] : 0;
}

- (int)selectedPhotoCountInSelection:(NSSet*) selection {
	return [[[self photoSetsInSelection:selection] valueForKeyPath:@"@sum.photoCount"] intValue];
}

- (FLZenfolioGroupElement*) elementAtIndex:(NSInteger) index {
    NSInteger counter = 0;
    return [self elementAtIndex:index counter:&counter];
}




@end