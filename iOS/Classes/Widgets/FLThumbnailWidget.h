//
//	FLThumbnailWidget.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/7/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLWidget.h"
#import "FLImageWidget.h"
#import "FLTwoImageWidget.h"

@interface FLThumbnailWidget : FLTwoImageWidget {
	UIImageView* _highlightedView;
}

@property (readwrite, retain, nonatomic) UIImage* foregroundThumbnail;
@property (readwrite, retain, nonatomic) UIImage* backgroundThumbnail;

@end
