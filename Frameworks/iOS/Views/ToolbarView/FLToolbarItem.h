//
//  FLToolbarItem.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/6/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLFrame.h"

// TODO: this needs to be abstracted out of here.
typedef enum {
    FLImageColorWhite,
    FLImageColorLightGray,
    FLImageColorGray,
    FLImageColorBlack,
} FLImageColor;

@class FLToolbarView;
@class FLToolbarItemGroup;

typedef void (^FLToolbarViewBlock)(id item);

typedef enum {
    FLToolbarItemAlignmentNone,
    FLToolbarItemAlignmentLeft,
    FLToolbarItemAlignmentRight,
    FLToolbarItemAlignmentCenter
} FLToolbarItemAlignment;

@interface FLToolbarItem : FLFrame  {
@private
    FLToolbarViewBlock _onChosen;
    __weak FLToolbarView* _toolbar;
    CGFloat _horizontalPadding;
    FLSize _minSize;
    FLToolbarItemAlignment _viewAlignment;
    id _view;
}

- (id) initWithView:(id) aView onChosenBlock:(FLToolbarViewBlock) onChosenBlock;

@property (readwrite, assign, nonatomic) FLToolbarItemAlignment viewAlignment;
@property (readwrite, strong, nonatomic) id view;
@property (readwrite, assign, nonatomic) FLSize minSize;
@property (readwrite, assign, nonatomic) CGFloat horizontalPadding;

@property (readwrite, copy, nonatomic) FLToolbarViewBlock onChosen;

@property (readonly, weak, nonatomic) FLToolbarView* parentToolbar;

- (void) wasAddedToToolbarView:(FLToolbarView*) view;
- (void) wasRemovedFromToolbarView:(FLToolbarView*) view;

- (void) drawRect:(CGRect) rect;




- (void) toolbarTitleDidChange:(NSString*) title;

- (FLSize) subviewSizeThatFitsInBounds:(CGRect) bounds;
- (void) setSubviewSize:(FLSize) size;

- (void) updateSizeInBounds:(CGRect) bounds;

- (void) updateLayout;

@end