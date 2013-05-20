//
//	GtThumbnailWidget.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/7/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtWidget.h"
#import "GtImageWidget.h"
#import "GtTwoImageWidget.h"

@interface GtThumbnailWidget : GtTwoImageWidget {
	UIImageView* m_highlightedView;
}

@property (readwrite, retain, nonatomic) UIImage* foregroundThumbnail;
@property (readwrite, retain, nonatomic) UIImage* backgroundThumbnail;

@end
