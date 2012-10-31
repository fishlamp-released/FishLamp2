//
//	FLTwoImageWidget.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/6/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLTwoImageWidget.h"

@implementation FLTwoImageWidget

@synthesize topImageWidget = _topImageWidget;
@synthesize bottomImageWidget = _bottomImageWidget;

- (id) initWithFrame:(FLRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		_topImageWidget = [[FLImageWidget alloc] initWithFrame:frame];
		_topImageWidget.contentMode = FLContentModeCentered;
		_topImageWidget.imageContentMode = FLWidgetImageContentModeScaleAspectFit;
		
		_bottomImageWidget = [[FLImageWidget alloc] initWithFrame:frame];
		_bottomImageWidget.contentMode = FLContentModeCentered;
		_bottomImageWidget.imageContentMode = FLWidgetImageContentModeScaleAspectFit;
		
		[self addWidget:_bottomImageWidget];
		[self addWidget:_topImageWidget];
	}
	return self;
}

- (void) dealloc
{
	mrc_release_(_topImageWidget);
	mrc_release_(_bottomImageWidget);
	mrc_super_dealloc_();
}

- (void) releaseImages
{
	_topImageWidget.image = nil;
	_bottomImageWidget = nil;
}

@end
