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


@interface FLToolbarItemGroup : NSObject  {
@private
    FLToolbarItemAlignment _viewAlignment;
    __weak FLToolbarView* _parentToolbarView;
    NSMutableArray* _items;
    FLRect _frame;
    FLArrangement* _itemArrangement;
}

@property (readwrite, strong, nonatomic) FLArrangement* itemArrangement;

@property (readonly, weak, nonatomic) FLToolbarView* parentToolbarView;
@property (readonly, assign, nonatomic) NSUInteger count;

@property (readwrite, assign, nonatomic) FLToolbarItemAlignment viewAlignment;
@property (readwrite, assign, nonatomic) FLRect frame;

- (id) initWithToolbarView:(FLToolbarView*) view alignment:(FLToolbarItemAlignment) alignment;

- (void) addToolbarItem:(FLToolbarItem*) item;
- (void) removeToolbarItem:(FLToolbarItem*) item;
- (void) removeAllToolbarItems;

- (void) updateSizeInBounds:(FLRect) bounds;

- (void) visitToolbarItems:(FLToolbarViewBlock) visitor;

- (void) addImageButton:(UIImage*) image 
            buttonPress:(FLButtonPress) buttonPress;

- (void) addImageButtonByName:(NSString*) imageName 
                   imageColor:(FLImageColor) colorOfImageInFile
                  buttonPress:(FLButtonPress) buttonPress;

- (void) addEmptyItem:(FLSize) size;
@end