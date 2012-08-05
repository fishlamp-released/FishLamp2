//
//  FLGridViewCellView.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/3/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLWidgetView.h"
#import "FLGridViewCellAware.h"

@class FLGridViewCell;

@interface UIView (FLGridViewCellAware)
- (void) didMoveToGridViewCell:(FLGridViewCell*) cell;
@property (readonly, weak, nonatomic) id gridViewCell;
@end

@interface FLGriddableView : FLWidgetView<FLGridViewCellAware> {
@private
    FLGridViewCell* _gridViewCell;
}

@end

