//
//	GtThumbnailView.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/15/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

@interface GtThumbnailView : UIImageView {
@private
	UIImage* m_backgroundImage;
	UIImage* m_image;
	UIView* m_disabledView;
	BOOL m_enabled;
}

@property (readwrite, assign, nonatomic) BOOL enabled;

- (void) clearImages;

@property (readwrite, retain, nonatomic) UIImage* backgroundImage;
@property (readwrite, retain, nonatomic) UIImage* foregroundImage;

@end