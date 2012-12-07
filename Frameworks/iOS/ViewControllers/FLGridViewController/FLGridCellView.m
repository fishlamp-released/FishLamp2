//
//  FLGridCellView.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/3/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLGridCellView.h"
#import "FLGridViewController.h"
#import "FLGridCell.h"
#import "FLWidget.h"


@implementation UIView (FLGridCell)

FLSynthesizeAssociatedProperty(assign_nonatomic, gridCell, setGridCell, id);

- (void) didMoveToGridCell:(FLGridCell*) cell {
    self.gridCell = cell;
    for(UIView* view in self.subviews) {
        [view didMoveToGridCell:cell];
    }
}

- (void) wasCachedInCache:(FLObjectCache*) cache {
    self.hidden = YES;
}

- (void) wasUncachedFromCache:(FLObjectCache*) cache {
    [self setNeedsDisplay];
}

- (void) willBePurgedFromCache:(FLObjectCache*) cache {
    [self removeFromSuperview];
}

@end


@implementation FLGridCellView

@synthesize gridCell = _gridViewCell;

- (id) initWithFrame:(CGRect) frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void) didMoveToGridCell:(FLGridCell*) cell {
//    _gridViewCell = cell;
    self.gridCell = cell;
    for(UIView* view in self.subviews) {
        [view didMoveToGridCell:cell];
    }   
    
    [self.rootWidget didMoveToGridCell:cell];
    
}

- (void) widgetWasTouched:(FLWidget*) widget {
    id cell = _gridViewCell;
    if(cell) {
        [cell objectWasTouched:widget];
    }
}

@end
