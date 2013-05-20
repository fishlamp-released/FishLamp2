//
//  GtAssetLibraryBrowserCellWidget.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/14/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtImageAssetCellWidget.h"
#import "UIColor+GtMoreColors.h"

@implementation GtImageAssetCellWidget

@synthesize imageAssetCellDelegate = m_imageAssetCellDelegate;
@synthesize asset = m_asset;
@synthesize assetIndex = m_assetIndex;

- (void) _wasTouched
{
	[m_imageAssetCellDelegate imageAssetCellWidgetWasSelected:self];			
}

- (void) touchableObjectTouchDown:(GtWidget*) widget
{
	[m_imageAssetCellDelegate imageAssetCellWidgetWasSelected:self];			
}

- (void) touchableObjectTouchEntered:(GtWidget*) widget
{
	if([[GtSelectOnTouchUpHandler touchedObject] isSelected] != widget.isSelected)
	{
		((GtSelectOnTouchUpHandler*) [widget touchHandler]).didChangeStateOnTouch = YES;
		[m_imageAssetCellDelegate imageAssetCellWidgetWasSelected:self];
	}
}

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
        GtSelectOnTouchUpHandler* touchHandler = [GtSelectOnTouchUpHandler selectOnTouchUpHandler];
        touchHandler.exclusiveTouchMode = NO;
        touchHandler.highlightOnTouch = NO;
        touchHandler.touchDownCallback = GtCallbackMake(self, @selector(touchableObjectTouchDown:));
        touchHandler.touchEnteredCallback = GtCallbackMake(self, @selector(touchableObjectTouchEntered:));

		if(DeviceIsPad())
		{
			m_imageFrame = [[GtImageFrameWidget alloc] initWithFrame:CGRectMake(0,0, 82, 82)];
			m_imageFrame.contentMode = GtWidgetContentModeScaleAspectFill;
			m_imageFrame.imageWidget = [GtImageWidget widget];
//			m_imageFrame.imageWidget.highlighter = GtWidgetBlueTintImageHighlighter;
			m_imageFrame.showFrame = YES;
			m_imageFrame.showStack = NO;
            m_imageFrame.touchHandler = touchHandler;
			[self addSubwidget:m_imageFrame];
					
			m_itemNumber = [[GtLabelWidget alloc] init];
			m_itemNumber.textAlignment = UITextAlignmentCenter;
			m_itemNumber.themeAction = @selector(applyThemeToTableViewCellValueLabel:);
			[self addSubwidget:m_itemNumber];
		}
		else
		{
			m_thumbnailImageWidget = [[GtThumbnailWidget alloc] initWithFrame:GtRectSetSize(m_thumbnailImageWidget.frame, 78, 78)];
			m_thumbnailImageWidget.touchHandler = touchHandler;
            [self addSubwidget:m_thumbnailImageWidget];

		}
		m_processedImage = [[GtImageWidget alloc] init];
		m_processedImage.hidden = YES;
		[self addSubwidget:m_processedImage];

		m_selectedImage = [[GtImageWidget alloc] init];
		m_selectedImage.hidden = YES;
		[self addSubwidget:m_selectedImage];
		
	}
	
	return self;
}

- (void) dealloc
{
	GtRelease(m_itemNumber);
	GtRelease(m_processedImage);
	GtRelease(m_selectedImage);
	GtRelease(m_asset);
	GtRelease(m_imageFrame);
	GtRelease(m_thumbnailImageWidget);
	GtSuperDealloc();
}

- (void) setAsset:(id<GtImageAsset>) asset
{
	GtAssertNotNil(asset);
	
	GtAssignObject(m_asset, asset);
	
	[asset.thumbnail readFromStorage];
	
	if(DeviceIsPad())
	{
		m_imageFrame.imageWidget.image = asset.thumbnail.image;
	}
	else
	{
		m_thumbnailImageWidget.foregroundThumbnail = asset.thumbnail.image;
	}
	
	
	[self updateState];
}

- (void) setBackgroundThumbnail:(UIImage*) image
{
	if(DeviceIsPad())
	{
		m_imageFrame.imageWidget.image = image;
	}
	else
	{
		m_thumbnailImageWidget.backgroundThumbnail = image;
	}
}

- (void) setSelectedImage:(UIImage*) image
{
	m_selectedImage.image = image;
	[m_selectedImage resizeToImageSize];
}

- (void) setProcessedImage:(UIImage*) image
{
	m_processedImage.image = image;
	[m_processedImage resizeToImageSize];
}

- (void) setAssetIndex:(NSUInteger) num
{	
    m_assetIndex = num;
	m_itemNumber.text = [NSString stringWithFormat:@"%d", num];
	m_itemNumber.hidden = num == 0;
}

- (void) updateState
{
	self.selected = [m_imageAssetCellDelegate imageAssetCellWidgetIsSelected:self];
	m_selectedImage.hidden = !self.selected;
	
	self.disabled = [m_imageAssetCellDelegate imageAssetCellWidgetIsDisabled:self];
	
	if(DeviceIsPad())
	{
		m_imageFrame.frameColor = 
			/*[m_imageAssetCellDelegate imageAssetCellWidgetWasProcessed:self] ||*/ self.disabled ? 
				[UIColor gray50Color] :
				[UIColor whiteColor];
				
	}
	
	m_processedImage.hidden = ![m_imageAssetCellDelegate imageAssetCellWidgetWasProcessed:self];
	
	[self setNeedsDisplay];
}

- (void) layoutSubwidgets 
{
	[super layoutSubwidgets];
	
	if(DeviceIsPad())
	{
		m_imageFrame.frameOptimizedForSize = GtRectCenterRectInRect(self.frame, m_imageFrame.frame);
		
		m_itemNumber.frameOptimizedForLocation = CGRectMake(self.frame.origin.x, m_imageFrame.frame.origin.y - 18.f, self.frame.size.width, 18.f);
		
		m_selectedImage.frameOptimizedForSize = GtRectCenterOnPoint(m_selectedImage.frame, 
			GtRectGetTopRight(m_imageFrame.imageWidget.frame));
		m_processedImage.frameOptimizedForSize = GtRectCenterOnPoint(m_selectedImage.frame, GtRectGetTopLeft(m_imageFrame.imageWidget.frame));
	}
	else
	{

		m_thumbnailImageWidget.frameOptimizedForSize = GtRectCenterRectInRect(self.frame, CGRectInset(self.frame, 1, 1));
		
		m_selectedImage.frameOptimizedForSize = GtRectJustifyRectInRectTopRight(m_thumbnailImageWidget.frame, m_selectedImage.frame);
		m_processedImage.frameOptimizedForSize = GtRectJustifyRectInRectTopLeft(m_thumbnailImageWidget.frame, m_selectedImage.frame);
	}
}

@end

