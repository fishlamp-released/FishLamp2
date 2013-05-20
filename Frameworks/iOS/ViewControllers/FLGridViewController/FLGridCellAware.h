//
//  FLGridCellAware.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/13/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

@class FLGridCell;

@protocol FLGridCellAware <NSObject> 
- (void) didMoveToGridCell:(FLGridCell*) cell;
@property (readonly, weak, nonatomic) id gridCell;
@end
