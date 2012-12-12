//
//  FLToolbarItemGroup.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/6/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLToolbarItemGroup.h"
#import "FLSingleRowColumnArrangement.h"
#import "FLToolbarItemView.h"
#import "SDKImage+Colorize.h"
#import "SDKImage+Resize.h"
#import "FLImageButtonToolbarItem.h"

@interface FLToolbarItemGroup ()
@property (readwrite, retain, nonatomic) NSMutableArray* items;
@property (readwrite, assign, nonatomic) FLToolbarView* parentToolbarView;
@end

@implementation FLToolbarItemGroup

@synthesize frame = _frame;
@synthesize parentToolbarView = _parentToolbarView;
@synthesize items = _items;
@synthesize viewAlignment = _viewAlignment;
@synthesize itemArrangement = _itemArrangement;

- (id) initWithToolbarView:(FLToolbarView*) view  alignment:(FLToolbarItemAlignment) alignment {
    if((self = [super init])) {
        self.parentToolbarView = view;
        _items = [[NSMutableArray alloc] init];
        self.viewAlignment = alignment;
        self.itemArrangement = [FLSingleRowColumnArrangement arrangement];
        self.itemArrangement.outerInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    }
    
    return self;
}

- (NSUInteger) count {
    return _items.count;
}

- (void) addToolbarItem:(FLToolbarItem*) item{
    if(item.viewAlignment == FLToolbarItemAlignmentNone) {
        item.viewAlignment = self.viewAlignment;
    }
    [_items addObject:item];
    [item wasAddedToToolbarView:self.parentToolbarView];
}

- (void) removeToolbarItem:(FLToolbarItem*) item {
    [item wasRemovedFromToolbarView:self.parentToolbarView];
    [_items removeObject:item];
}

- (void) removeAllToolbarItems {
    for(FLToolbarItem* item in _items) {
        [item wasRemovedFromToolbarView:self.parentToolbarView];
    }   
    [_items removeAllObjects];
}

- (void) visitToolbarItems:(FLToolbarViewBlock) visitor {
    for(FLToolbarItem* item in _items) {
        visitor(item);
    }
}

- (void) dealloc {
    [self removeAllToolbarItems];
    FLRelease(_items);
    FLRelease(_itemArrangement);
    super_dealloc_();
}

- (void) updateSizeInBounds:(CGRect) bounds {
    
    _frame = bounds;

    for(FLToolbarItem* item in _items) {
        [item updateSizeInBounds:_frame];
    }
    
    _frame.size = [self.itemArrangement performArrangement:_items inBounds:_frame];
    
    for(FLToolbarItem* item in _items) {
        [item updateLayout];
    }
}

- (void) setFrame:(CGRect) frame {
    _frame = frame;
    [self.itemArrangement performArrangement:_items inBounds:_frame];
    for(FLToolbarItem* item in _items) {
        [item updateLayout];
    }
}

- (void) addImageButton:(SDKImage*) image buttonPress:(FLButtonPress) buttonPress
{
    FLAssertIsNotNil_(image);
    FLAssertIsNotNil_(buttonPress);

	[self addToolbarItem:[FLImageButtonToolbarItem imageButtonToolbarItemWithImage:image onChosenBlock:buttonPress]];
}


- (void) addImageButtonByName:(NSString*) imageName 
                   imageColor:(FLImageColor) colorOfImageInFile
                  buttonPress:(FLButtonPress) buttonPress {
    SDKImage* image = nil;
    switch(colorOfImageInFile)
    {
        case FLImageColorBlack:
        case FLImageColorGray:
            image = [SDKImage whiteImageNamed:imageName];
        break;

        case FLImageColorLightGray:
            image = [[SDKImage imageNamed:imageName] colorizeImage:[SDKColor lightGrayColor] blendMode:kCGBlendModeOverlay];
        break;

        case FLImageColorWhite:
            image = [SDKImage imageNamed:imageName];
        break;
    }
    
    [self addToolbarItem:[FLImageButtonToolbarItem imageButtonToolbarItemWithImage:image onChosenBlock:buttonPress]];
}

- (void) addEmptyItem:(CGSize) size {
    FLToolbarItem* item = [[FLToolbarItem alloc] initWithFrame:FLRectMakeWithSize(size)];
    [self addToolbarItem:item];
    FLRelease(item);
}

@end
