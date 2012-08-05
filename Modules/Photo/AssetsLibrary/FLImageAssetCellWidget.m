//
//  FLAssetLibraryBrowserCellWidget.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/14/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLImageAssetCellWidget.h"
#import "CocoaColor+FLMoreColors.h"

@implementation FLImageAssetCellWidget

@synthesize imageAssetCellDelegate = m_imageAssetCellDelegate;
@synthesize asset = m_asset;
@synthesize assetIndex = m_assetIndex;

- (void) _wasTouched
{
	[m_imageAssetCellDelegate imageAssetCellWidgetWasSelected:self];			
}

- (void) touchableObjectTouchDown:(FLWidget*) widget
{
	[m_imageAssetCellDelegate imageAssetCellWidgetWasSelected:self];			
}

- (void) touchableObjectTouchEntered:(FLWidget*) widget
{
	if([[FLSelectOnTouchUpHandler touchedObject] isSelected] != widget.isSelected)
	{
		((FLSelectOnTouchUpHandler*) [widget touchHandler]).didChangeStateOnTouch = YES;
		[m_imageAssetCellDelegate imageAssetCellWidgetWasSelected:self];
	}
}

- (void) applyTheme:(FLTheme*) theme 
{
    [super applyTheme:theme];
    
//    			m_itemNumber.themeAction = @selector(applyThemeToTableViewCellValueLabel:);


}


- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
        self.wantsApplyTheme = YES;
    
        FLSelectOnTouchUpHandler* touchHandler = [FLSelectOnTouchUpHandler selectOnTouchUpHandler];
        touchHandler.exclusiveTouchMode = NO;
        touchHandler.highlightOnTouch = NO;
        touchHandler.touchDownCallback = FLCallbackMake(self, @selector(touchableObjectTouchDown:));
        touchHandler.touchEnteredCallback = FLCallbackMake(self, @selector(touchableObjectTouchEntered:));

		if(DeviceIsPad())
		{
			m_imageFrame = [[FLImageFrameWidget alloc] initWithFrame:CGRectMake(0,0, 82, 82)];
			m_imageFrame.imageContentMode = FLWidgetImageContentModeScaleAspectFill;
			m_imageFrame.imageWidget = [FLImageWidget widget];
//			m_imageFrame.imageWidget.highlighter = FLWidgetBlueTintImageHighlighter;
			m_imageFrame.showFrame = YES;
			m_imageFrame.showStack = NO;
            m_imageFrame.touchHandler = touchHandler;
			[self addWidget:m_imageFrame];
					
			m_itemNumber = [[FLLabelWidget alloc] init];
			m_itemNumber.textAlignment = UITextAlignmentCenter;
			[self addWidget:m_itemNumber];
		}
		else
		{
			m_thumbnailImageWidget = [[FLThumbnailWidget alloc] initWithFrame:FLRectSetSize(m_thumbnailImageWidget.frame, 78, 78)];
			m_thumbnailImageWidget.touchHandler = touchHandler;
            [self addWidget:m_thumbnailImageWidget];

		}
		m_processedImage = [[FLImageWidget alloc] init];
		m_processedImage.hidden = YES;
		[self addWidget:m_processedImage];

		m_selectedImage = [[FLImageWidget alloc] init];
		m_selectedImage.hidden = YES;
		[self addWidget:m_selectedImage];
		
	}
	
	return self;
}

- (void) dealloc
{
	FLRelease(m_itemNumber);
	FLRelease(m_processedImage);
	FLRelease(m_selectedImage);
	FLRelease(m_asset);
	FLRelease(m_imageFrame);
	FLRelease(m_thumbnailImageWidget);
	FLSuperDealloc();
}

- (void) setAsset:(id<FLImageAsset>) asset
{
	FLAssertIsNotNil(asset);
	
	FLAssignObject(m_asset, asset);
	
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

- (void) layoutWidgets 
{
	[super layoutWidgets];
	
	if(DeviceIsPad())
	{
		m_imageFrame.frameOptimizedForSize = FLRectCenterRectInRect(self.frame, m_imageFrame.frame);
		
		m_itemNumber.frameOptimizedForLocation = CGRectMake(self.frame.origin.x, m_imageFrame.frame.origin.y - 18.f, self.frame.size.width, 18.f);
		
		m_selectedImage.frameOptimizedForSize = FLRectCenterOnPoint(m_selectedImage.frame, 
			FLRectGetTopRight(m_imageFrame.imageWidget.frame));
		m_processedImage.frameOptimizedForSize = FLRectCenterOnPoint(m_selectedImage.frame, FLRectGetTopLeft(m_imageFrame.imageWidget.frame));
	}
	else
	{

		m_thumbnailImageWidget.frameOptimizedForSize = FLRectCenterRectInRect(self.frame, CGRectInset(self.frame, 1, 1));
		
		m_selectedImage.frameOptimizedForSize = FLRectJustifyRectInRectTopRight(m_thumbnailImageWidget.frame, m_selectedImage.frame);
		m_processedImage.frameOptimizedForSize = FLRectJustifyRectInRectTopLeft(m_thumbnailImageWidget.frame, m_selectedImage.frame);
	}
}

@end

