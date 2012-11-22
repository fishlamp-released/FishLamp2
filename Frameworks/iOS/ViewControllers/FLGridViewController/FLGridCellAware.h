//
//  FLGridCellAware.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/13/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FLGridCell;

@protocol FLGridCellAware <NSObject> 
- (void) didMoveToGridCell:(FLGridCell*) cell;
@property (readonly, weak, nonatomic) id gridCell;
@end
