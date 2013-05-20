//
//  GtAsyncThumbnailToolBar.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/4/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtAttributedStringView.h"

typedef enum {
    GtIconColorWhite,
    GtIconColorBlack,
    GtIconColorGray
} GtIconColor;

@interface GtAsyncThumbnailToolBar : UIView {
@private
    GtOrderedCollection* m_buttons;
    UIView* m_backgroundView;
    UIButton* m_thumbnailButton;
    UIActivityIndicatorView* m_spinner;
    GtAttributedStringView* m_titleLabel;
}

@property (readwrite, retain, nonatomic) UIView* backgroundView;

@property (readwrite, retain, nonatomic) UIImage* thumbnail;

@property (readwrite, retain, nonatomic) GtAttributedStringView* title;

- (void) addButtonForKey:(NSString*) key
    imageName:(NSString*) imageName
    iconColor:(GtIconColor) iconColor
    target:(id) target
    action:(SEL) action;

- (void) startSpinner;
- (void) stopSpinner;

@end
