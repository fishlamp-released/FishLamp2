//
//  GtOrderedCollection.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/11/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtOrderedCollection.h"

@interface GtOrderedCollection (GtGridViewController)

// creates cells for all the items in the array
- (void) addOrReplaceCellsWithGridViewObjects:(NSArray*) itemArray 
                                      atIndex:(NSUInteger) atDestinationIndex;

// creates cells for the range of cells
- (void) addOrReplaceCellsWithGridViewObjects:(NSArray*) itemArray 
                               itemArrayRange:(NSRange) inRange
                                      atIndex:(NSUInteger) atDestinationIndex;

- (void) addCellWithItem:(id) object;
@end
