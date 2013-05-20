//
//	GtThumbnailBar.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/6/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtImageThumbnailBarView.h"

@interface GtPhotoThumbnailToolbar : UIToolbar {
@private
	UIBarButtonItem* m_previousButton;
	UIBarButtonItem* m_nextButton;
	UIBarButtonItem* m_thumbnailBarItem;
	GtImageThumbnailBarView* m_thumbnailBar;
	BOOL m_enabled;
}

@property (readonly, assign, nonatomic) UIBarButtonItem* previousButton;
@property (readonly, assign, nonatomic) UIBarButtonItem* nextButton;
@property (readonly, assign, nonatomic) GtImageThumbnailBarView* thumbnailBarView;

@property (readwrite, assign, nonatomic) BOOL enabled;
	

@end