//
//	FLImageInImageWidget.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/9/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLImageInImageWidget.h"


@implementation FLImageInImageWidget

@synthesize topImageWidget = _topImageWidget;
@synthesize topImageScale = _topImageScale;

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		_topImageScale = 1.0;
	}
	return self;
}

+ (FLImageInImageWidget*) imageInImageWidget:(CGRect) frame
{
	return FLAutorelease([[FLImageInImageWidget alloc] initWithFrame:frame]);
}

- (void) setTopImageWidget:(FLImageWidget*) widget
{
	if(_topImageWidget)
	{
		[_topImageWidget removeFromParent];
	}
	FLSetObjectWithRetain(_topImageWidget, widget);
	[self addWidget:widget];
	[self setNeedsLayout];
}

- (void) dealloc
{
	FLRelease(_topImageWidget);
	FLSuperDealloc();
}

- (void) clear
{
	[super clear];
	[_topImageWidget clear];
}

- (void) layoutSubWidgets
{
	[super layoutSubWidgets];
//	  switch(self.contentMode)
//	  {
//		  case FLWidgetImageContentModeScaleToFill:
//		  case FLWidgetImageContentModeScaleAspectFit:
//			  _topImageWidget.frameOptimizedForSize = FLRectCenterRectInRect(self.frame, [_topImageWidget resizeToImageSizeWithMaxSize:self.frame.size]);
//		  break;
//		  case FLWidgetImageContentModeScaleAspectFill:
//		  break;
//		  case FLWidgetImageContentModeScaleAspectFitOptimalSize:
//			  [_topImageWidget resizeToImageSize];
//		  break;
//	  }
	
	if(_topImageWidget.image)
	{
		[_topImageWidget resizeToImageSize];
		_topImageWidget.frame = 
			FLRectPositionRectInRectWithContentMode(self.frame, FLRectScale(_topImageWidget.frame, _topImageScale), _topImageWidget.contentMode);
	}
}

@end
