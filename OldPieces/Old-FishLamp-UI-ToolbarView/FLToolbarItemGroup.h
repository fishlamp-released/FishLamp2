//
//  FLToolbarItemGroup.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/6/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaUIRequired.h"

#import "FLToolbarItem.h"
#if REFACTOR
#if IOS
#import "FLButton.h"
#endif
#endif

#import "FLArrangement.h"

typedef void (^FLButtonPress)(id button);

@class FLToolbarView;

@interface FLToolbarItemGroup : NSObject  {
@private
    FLToolbarItemAlignment _viewAlignment;
    __unsafe_unretained FLToolbarView* _parentToolbarView;
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

- (void) addImageButton:(SDKImage*) image 
            buttonPress:(FLButtonPress) buttonPress;

- (void) addImageButtonByName:(NSString*) imageName 
                   imageColor:(FLImageColor) colorOfImageInFile
                  buttonPress:(FLButtonPress) buttonPress;

- (void) addEmptyItem:(CGSize) size;
@end