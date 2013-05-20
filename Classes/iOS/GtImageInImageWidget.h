//
//	GtImageInImageWidget.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/9/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtImageWidget.h"

@interface GtImageInImageWidget : GtImageWidget {
@private
	GtImageWidget* m_topImageWidget;
	CGFloat m_topImageScale;
}
@property (readwrite, assign, nonatomic) CGFloat topImageScale;
@property (readwrite, retain, nonatomic) GtImageWidget* topImageWidget; // use the widget's layoutMode to position.

+ (GtImageInImageWidget*) imageInImageWidget:(CGRect) frame;

@end
