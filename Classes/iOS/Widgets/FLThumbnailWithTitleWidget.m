//
//  FLThumbnailWithTitleWidget.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/12/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLThumbnailWithTitleWidget.h"

@implementation FLThumbnailWithTitleWidget

@synthesize imageFrameWidget = _imageFrame;
@synthesize titleLabelWidget = _label;

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		CGFloat thumbheight = MIN(80, frame.size.height - 20);
		
		_imageFrame = [[FLImageFrameWidget alloc] initWithFrame:CGRectMake(0,0, thumbheight, thumbheight)];
		_imageFrame.imageWidget = [FLImageWidget widget];
		_imageFrame.imageWidget.imageContentMode = FLWidgetImageContentModeScaleAspectFill;
//		_imageFrame.imageWidget.highlighter = FLWidgetBlueTintImageHighlighter;
				
		_imageFrame.showFrame = YES;
		_imageFrame.showStack = YES;
		[self addWidget:_imageFrame];
		
		_label = [[FLLabelWidget alloc] initWithFrame:CGRectMake(0,0,frame.size.width, 18)];
		_label.textAlignment = UITextAlignmentCenter;
	//	_label.themeAction = @selector(applyThemeToTableViewCellTitleLabel:);
	//	_label.viewLayoutMargins = UIEdgeInsetsMake((frame.size.height / 2.0f) - 10.0f, 10.0f, 0, 0);
		[self addWidget:_label];
	}
	
	return self;
}

- (void) dealloc
{
	FLRelease(_imageFrame);
	FLRelease(_label);
	FLSuperDealloc();
}

- (void) setTitle:(NSString*) title
{
	_label.text = title;
	[self setNeedsLayout];
}
- (void) setThumbnail:(UIImage*) image
{
	_imageFrame.imageWidget.image = image;
}

- (void) layoutSubWidgets 
{
	[super layoutSubWidgets];
	
//	if(DeviceIsPad())
	{
		CGRect layoutFrame = DeviceIsPad() ? 
			CGRectInset(self.frame, 10, 10) :
			CGRectInset(self.frame, 0,0);
	
		_imageFrame.frameOptimizedForSize = FLRectCenterRectInRectHorizontally(layoutFrame, FLRectJustifyRectInRectTop(layoutFrame,_imageFrame.frame));
		
		
		_label.frameOptimizedForSize = FLRectCenterRectInRectHorizontally(layoutFrame, FLRectJustifyRectInRectBottom(layoutFrame, CGRectMake(0,0, self.frame.size.width, 18)));
	}
//	else
//	{
//
//	}
}

@end
