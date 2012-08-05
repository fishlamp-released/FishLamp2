//
//	FLThumbnailBar.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/6/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLImageThumbnailBarView.h"

@interface FLPhotoThumbnailToolbar : UIToolbar {
@private
	UIBarButtonItem* m_previousButton;
	UIBarButtonItem* m_nextButton;
	UIBarButtonItem* m_thumbnailBarItem;
	FLImageThumbnailBarView* m_thumbnailBar;
	BOOL m_enabled;
}

@property (readonly, assign, nonatomic) UIBarButtonItem* previousButton;
@property (readonly, assign, nonatomic) UIBarButtonItem* nextButton;
@property (readonly, assign, nonatomic) FLImageThumbnailBarView* thumbnailBarView;

@property (readwrite, assign, nonatomic) BOOL enabled;
	

@end