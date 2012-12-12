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
	UIBarButtonItem* _previousButton;
	UIBarButtonItem* _nextButton;
	UIBarButtonItem* _thumbnailBarItem;
	FLImageThumbnailBarView* _thumbnailBar;
	BOOL _enabled;
}

@property (readonly, strong, nonatomic) UIBarButtonItem* previousButton;
@property (readonly, strong, nonatomic) UIBarButtonItem* nextButton;
@property (readonly, strong, nonatomic) FLImageThumbnailBarView* thumbnailBarView;

@property (readwrite, assign, nonatomic) BOOL enabled;
	

@end