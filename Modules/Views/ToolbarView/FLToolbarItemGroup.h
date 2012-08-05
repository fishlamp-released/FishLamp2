//
//  FLToolbarItemGroup.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/6/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLToolbarItem.h"
#import "FLButton.h"

@class FLToolbarView;

typedef enum {
    FLImageColorWhite,
    FLImageColorLightGray,
    FLImageColorGray,
    FLImageColorBlack,
} FLImageColor;

@interface FLToolbarItemGroup : NSObject  {
@private
    FLToolbarItemAlignment _viewAlignment;
    __weak FLToolbarView* _parentToolbarView;
    NSMutableArray* _items;
    CGRect _frame;
    FLArrangement* _itemArrangement;
}

@property (readwrite, strong, nonatomic) FLArrangement* itemArrangement;

@property (readonly, assign, nonatomic) FLToolbarView* parentToolbarView;
@property (readonly, assign, nonatomic) NSUInteger count;

@property (readwrite, assign, nonatomic) FLToolbarItemAlignment viewAlignment;
@property (readwrite, assign, nonatomic) CGRect frame;

- (id) initWithToolbarView:(FLToolbarView*) view alignment:(FLToolbarItemAlignment) alignment;

- (void) addToolbarItem:(FLToolbarItem*) item;
- (void) removeToolbarItem:(FLToolbarItem*) item;
- (void) removeAllToolbarItems;

- (void) updateSizeInBounds:(CGRect) bounds;

- (void) visitToolbarItems:(FLToolbarViewBlock) visitor;

- (void) addImageButton:(UIImage*) image 
            buttonPress:(FLButtonPress) buttonPress;

- (void) addImageButtonByName:(NSString*) imageName 
                   imageColor:(FLImageColor) colorOfImageInFile
                  buttonPress:(FLButtonPress) buttonPress;

- (void) addEmptyItem:(CGSize) size;
@end