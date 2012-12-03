//
//  FLAsyncThumbnailToolBar.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/4/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLTouchableStringView.h"

typedef enum {
    FLIconColorWhite,
    FLIconColorBlack,
    FLIconColorGray
} FLIconColor;

@interface FLAsyncThumbnailToolBar : UIView {
@private
    FLOrderedCollection* _buttons;
    UIView* _backgroundView;
    UIButton* _thumbnailButton;
    UIActivityIndicatorView* _spinner;
    FLTouchableStringView* _titleLabel;
}

@property (readwrite, retain, nonatomic) UIView* backgroundView;

@property (readwrite, retain, nonatomic) UIImage* thumbnail;

@property (readwrite, retain, nonatomic) FLTouchableStringView* title;

- (void) addButtonForKey:(NSString*) key
    imageName:(NSString*) imageName
    iconColor:(FLIconColor) iconColor
    target:(id) target
    action:(SEL) action;

- (void) startSpinner;
- (void) stopSpinner;

@end
