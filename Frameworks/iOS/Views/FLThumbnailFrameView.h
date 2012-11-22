//
//	FLThumbnailFrameView.h
//	FishLamp
//
//	Created by Mike Fullerton on 1/21/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLThumbnailButton.h"
#import "FLWidget.h"

extern CGFloat kFrameSize;

@interface FLThumbnailFrameView : UIView {
@private
	FLThumbnailButton* _thumbnailButton;
	UIImageView* _scaledForegroundThumbnail;
	UIImage* _backgroundThumbnail;
	UIImage* _foregroundThumbnail;

	struct {	
		unsigned int showFrame: 1;
		unsigned int showBothThumbnails: 1; 
		unsigned int showStack:1;
	} _frameViewFlags;
	
	CGFloat _foregoundThumbnailScale;
	FLPoint _scaledForegroundThumbnailOffset;
	FLSize _maxSize;
}

@property (readwrite, assign, nonatomic) BOOL showFrame;
@property (readwrite, assign, nonatomic) BOOL showStack;

@property (readonly, retain, nonatomic) FLThumbnailButton* thumbnailButton;

@property (readwrite, retain, nonatomic) UIImage* foregroundThumbnail;
@property (readwrite, retain, nonatomic) UIImage* backgroundThumbnail;

@property (readwrite, assign, nonatomic) FLSize maxSize;
	   
- (void) clearThumbnails;

- (void) addTarget:(id)target action:(SEL)action;
- (BOOL) ownsSenderOfEvent:(id) sender;
	
- (FLRect) thumbnailImageFrame;	   

@property (readwrite, assign, nonatomic) BOOL showBothThumbnails;

- (void) setShowBothThumbnails:(BOOL) showBoth foregroundThumbnailScale:(CGFloat) scale positionOffset:(FLPoint) offset;

@end

