//
//	GtButton.h
//	FishLamp
//
//	Created by Mike Fullerton on 7/26/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtWidgetView.h"
#import "GtLabel.h"

//typedef enum { 
//	GtButtonImageLayoutModeCentered,
//	  GtButtonImageLayoutModeCenteredSmallText,
//	  GtButtonImageLayoutModeAlignLeft,
//	  GtButtonImageLayoutModeToolbar
//} GtButtonImageLayoutMode;

@class GtButton;

@interface GtButton : GtWidgetView {
@private
	UIImage* m_image;
	UIImage* m_disabledImage;
	GtLabel* m_titleLabel;
	UIImageView* m_imageView;
	GtCallback m_buttonWasPressedCallback;
	CGFloat m_cornerRadius;
	NSTimeInterval m_startTap;
	struct {
		unsigned int isTranslucent : 1;
		unsigned int isHighlighted: 1;
		unsigned int isEnabled: 1;
		unsigned int isTouching:1;
	} m_buttonFlags;
}

//@property (readwrite, assign, nonatomic) GtButtonImageLayoutMode layoutMode;
//@property (readwrite, retain, nonatomic) UIColor* borderColor;
@property (readwrite, assign, nonatomic) CGFloat cornerRadius;
//@property (readwrite, assign, nonatomic) CGFloat borderWidth;

@property(nonatomic,readwrite,assign,getter=isEnabled) BOOL enabled;
@property(nonatomic,readwrite,assign,getter=isHighlighted) BOOL highlighted; 
@property (readwrite, assign, nonatomic, getter=isTranslucent) BOOL translucent;

@property(nonatomic,readonly,retain) GtLabel*	titleLabel;
@property (readwrite, retain, nonatomic) NSString* title;

@property(nonatomic,readonly,retain) UIImageView* imageView;
@property (readwrite, retain, nonatomic) UIImage* image;

- (void) addImageShadow:(UIColor*) withColor;

@property(readwrite, assign, nonatomic) GtCallback callback;
- (void)setCallback:(id)target action:(SEL)action;

- (void) setLightText;
- (void) setDarkText;

// override these
- (UIFont*) titleFont;
- (CGRect) rectUsedForCenteringSubviews;
- (void) updateImageAndTextViewPositions;
- (CGSize) defaultSize;
@end

