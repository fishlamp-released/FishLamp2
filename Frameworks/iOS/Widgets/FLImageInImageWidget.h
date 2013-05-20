//
//	FLImageInImageWidget.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/9/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLImageWidget.h"

@interface FLImageInImageWidget : FLImageWidget {
@private
	FLImageWidget* _topImageWidget;
	CGFloat _topImageScale;
}
@property (readwrite, assign, nonatomic) CGFloat topImageScale;
@property (readwrite, retain, nonatomic) FLImageWidget* topImageWidget; // use the widget's contentMode to position.

+ (FLImageInImageWidget*) imageInImageWidget:(CGRect) frame;

@end
