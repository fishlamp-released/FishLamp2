//
//  FLGridViewCellView.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/3/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLGriddableView.h"
#import "FLGridViewController.h"
#import "FLGridViewCell.h"
#import "FLWidget.h"

#import <objc/runtime.h>

static void * const kAssociatedObjectKey = (void*)&kAssociatedObjectKey;

@implementation UIView (FLGridViewCell)

- (void) didMoveToGridViewCell:(FLGridViewCell*) cell {
    objc_setAssociatedObject(self, kAssociatedObjectKey, cell, OBJC_ASSOCIATION_ASSIGN);
    for(UIView* view in self.subviews) {
        [view didMoveToGridViewCell:cell];
    }
}

- (id) gridViewCell {
    return objc_getAssociatedObject(self, kAssociatedObjectKey);
}

- (void) objectCacheWillCacheObject:(FLObjectCache*) cache {
    self.hidden = YES;
    [self didMoveToGridViewCell:nil];
}

- (void) objectCacheWillUncacheObject:(FLObjectCache*) cache {
    [self setNeedsDisplay];
}

- (void) objectCacheWillPurgeObject:(FLObjectCache*) cache {
    [self removeFromSuperview];
}

@end


@implementation FLGriddableView

@synthesize gridViewCell = _gridViewCell;

- (id) initWithFrame:(CGRect) frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void) didMoveToGridViewCell:(FLGridViewCell*) cell {
    _gridViewCell = cell;
    for(UIView* view in self.subviews) {
        [view didMoveToGridViewCell:cell];
    }   
    
    [self.rootWidget didMoveToGridViewCell:cell];
}

- (void) widgetWasTouched:(FLWidget*) widget {
    [_gridViewCell gridViewCellView:self objectWasTouched:widget];
}

@end
