//
//  FLGridCellView.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/3/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLWidgetView.h"
#import "FLGridCellAware.h"

@class FLGridCell;

@interface UIView (FLGridCellAware)
- (void) didMoveToGridCell:(FLGridCell*) cell;
@property (readonly, weak, nonatomic) id gridCell;
@end

@interface FLGridCellView : FLWidgetView<FLGridCellAware> {
@private
    __weak FLGridCell* _gridViewCell;
}

@end

