//
//	GtThumbnailFrameView.h
//	FishLamp
//
//	Created by Mike Fullerton on 1/21/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtThumbnailButton.h"
#import "GtWidget.h"

extern CGFloat kFrameSize;

@interface GtThumbnailFrameView : UIView {
@private
	GtThumbnailButton* m_thumbnailButton;
	UIImageView* m_scaledForegroundThumbnail;
	UIImage* m_backgroundThumbnail;
	UIImage* m_foregroundThumbnail;

	struct {	
		unsigned int showFrame: 1;
		unsigned int showBothThumbnails: 1; 
		unsigned int showStack:1;
	} m_frameViewFlags;
	
	CGFloat m_foregoundThumbnailScale;
	CGPoint m_scaledForegroundThumbnailOffset;
	CGSize m_maxSize;
}

@property (readwrite, assign, nonatomic) BOOL showFrame;
@property (readwrite, assign, nonatomic) BOOL showStack;

@property (readonly, retain, nonatomic) GtThumbnailButton* thumbnailButton;

@property (readwrite, retain, nonatomic) UIImage* foregroundThumbnail;
@property (readwrite, retain, nonatomic) UIImage* backgroundThumbnail;

@property (readwrite, assign, nonatomic) CGSize maxSize;
	   
- (void) clearThumbnails;

- (void) addTarget:(id)target action:(SEL)action;
- (BOOL) ownsSenderOfEvent:(id) sender;
	
- (CGRect) thumbnailImageFrame;	   

@property (readwrite, assign, nonatomic) BOOL showBothThumbnails;

- (void) setShowBothThumbnails:(BOOL) showBoth foregroundThumbnailScale:(CGFloat) scale positionOffset:(CGPoint) offset;

@end

