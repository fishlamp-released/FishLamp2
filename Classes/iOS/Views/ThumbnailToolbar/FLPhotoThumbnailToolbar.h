//
//	FLThumbnailBar.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/6/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLImageThumbnailBarView.h"

@interface FLPhotoThumbnailToolbar : UIToolbar {
@private
	UIBarButtonItem* _backButton;
	UIBarButtonItem* _nextButton;
	UIBarButtonItem* _thumbnailBarItem;
	FLImageThumbnailBarView* _thumbnailBar;
	BOOL _enabled;
}

@property (readonly, strong, nonatomic) UIBarButtonItem* backButton;
@property (readonly, strong, nonatomic) UIBarButtonItem* nextButton;
@property (readonly, strong, nonatomic) FLImageThumbnailBarView* thumbnailBarView;

@property (readwrite, assign, nonatomic) BOOL enabled;
	

@end