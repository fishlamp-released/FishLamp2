//
//	FLLegacyButton.h
//	FishLamp
//
//	Created by Mike Fullerton on 7/26/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLWidgetView.h"
#import "FLLabel.h"

//typedef enum { 
//	FLButtonImageLayoutModeCentered,
//	  FLButtonImageLayoutModeCenteredSmallText,
//	  FLButtonImageLayoutModeAlignLeft,
//	  FLButtonImageLayoutModeToolbar
//} FLButtonImageLayoutMode;

@class FLLegacyButton;

@interface FLLegacyButton : FLWidgetView {
@private
	UIImage* _disabledImage;
    FLLabel* _titleLabel;
    FLCallback_t _buttonWasPressedCallback;
    CGFloat _cornerRadius;
    UIImage* _image;
    UIImageView* _imageView;

	NSTimeInterval _startTap;
	struct {
		unsigned int isTranslucent : 1;
		unsigned int isHighlighted: 1;
		unsigned int isEnabled: 1;
		unsigned int isTouching:1;
	} _buttonFlags;
}

//@property (readwrite, assign, nonatomic) FLButtonImageLayoutMode contentMode;
//@property (readwrite, retain, nonatomic) UIColor* borderColor;
@property (readwrite, assign, nonatomic) CGFloat cornerRadius;
//@property (readwrite, assign, nonatomic) CGFloat borderWidth;

@property(nonatomic,readwrite,assign,getter=isEnabled) BOOL enabled;
@property(nonatomic,readwrite,assign,getter=isHighlighted) BOOL highlighted; 
@property (readwrite, assign, nonatomic, getter=isTranslucent) BOOL translucent;

@property(nonatomic,readonly,retain) FLLabel*	titleLabel;
@property (readwrite, retain, nonatomic) NSString* title;

@property(nonatomic,readonly,retain) UIImageView* imageView;
@property (readwrite, retain, nonatomic) UIImage* image;

- (void) addImageShadow:(UIColor*) withColor;

@property(readwrite, assign, nonatomic) FLCallback_t callback;
- (void)setCallback:(id)target action:(SEL)action;

- (void) setLightText;
- (void) setDarkText;

// override these
- (UIFont*) titleFont;
- (CGRect) rectUsedForCenteringSubviews;
- (void) updateImageAndTextViewPositions;
- (CGSize) defaultSize;
@end

