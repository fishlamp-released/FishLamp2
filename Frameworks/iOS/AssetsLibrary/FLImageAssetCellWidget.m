//
//  FLAssetLibraryBrowserCellWidget.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/14/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLImageAssetCellWidget.h"
#import "UIColor+FLMoreColors.h"

@implementation FLImageAssetCellWidget

@synthesize imageAssetCellDelegate = _imageAssetCellDelegate;
@synthesize asset = _asset;
@synthesize assetIndex = _assetIndex;

- (void) _wasTouched
{
	[_imageAssetCellDelegate imageAssetCellWidgetWasSelected:self];			
}

- (void) touchableObjectTouchDown:(FLWidget*) widget
{
	[_imageAssetCellDelegate imageAssetCellWidgetWasSelected:self];			
}

- (void) touchableObjectTouchEntered:(FLWidget*) widget
{
	if([[FLSelectOnTouchUpHandler touchedObject] isSelected] != widget.isSelected)
	{
		((FLSelectOnTouchUpHandler*) [widget touchHandler]).didChangeStateOnTouch = YES;
		[_imageAssetCellDelegate imageAssetCellWidgetWasSelected:self];
	}
}

- (void) applyTheme:(FLTheme*) theme 
{
    [super applyTheme:theme];
    
//    			_itemNumber.themeAction = @selector(applyThemeToTableViewCellValueLabel:);


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
			_imageFrame = [[FLImageFrameWidget alloc] initWithFrame:CGRectMake(0,0, 82, 82)];
			_imageFrame.imageContentMode = FLWidgetImageContentModeScaleAspectFill;
			_imageFrame.imageWidget = [FLImageWidget widget];
//			_imageFrame.imageWidget.highlighter = FLWidgetBlueTintImageHighlighter;
			_imageFrame.showFrame = YES;
			_imageFrame.showStack = NO;
            _imageFrame.touchHandler = touchHandler;
			[self addWidget:_imageFrame];
					
			_itemNumber = [[FLLabelWidget alloc] init];
			_itemNumber.textAlignment = UITextAlignmentCenter;
			[self addWidget:_itemNumber];
		}
		else
		{
			_thumbnailImageWidget = [[FLThumbnailWidget alloc] initWithFrame:FLRectSetSize(_thumbnailImageWidget.frame, 78, 78)];
			_thumbnailImageWidget.touchHandler = touchHandler;
            [self addWidget:_thumbnailImageWidget];

		}
		_processedImage = [[FLImageWidget alloc] init];
		_processedImage.hidden = YES;
		[self addWidget:_processedImage];

		_selectedImage = [[FLImageWidget alloc] init];
		_selectedImage.hidden = YES;
		[self addWidget:_selectedImage];
		
	}
	
	return self;
}

- (void) dealloc
{
	FLRelease(_itemNumber);
	FLRelease(_processedImage);
	FLRelease(_selectedImage);
	FLRelease(_asset);
	FLRelease(_imageFrame);
	FLRelease(_thumbnailImageWidget);
	FLSuperDealloc();
}

- (void) setAsset:(id<FLImageAsset>) asset
{
	FLAssertIsNotNil(asset);
	
	FLSetObjectWithRetain(_asset, asset);
	
	[asset.thumbnail readFromStorage];
	
	if(DeviceIsPad())
	{
		_imageFrame.imageWidget.image = asset.thumbnail.image;
	}
	else
	{
		_thumbnailImageWidget.foregroundThumbnail = asset.thumbnail.image;
	}
	
	
	[self updateState];
}

- (void) setBackgroundThumbnail:(UIImage*) image
{
	if(DeviceIsPad())
	{
		_imageFrame.imageWidget.image = image;
	}
	else
	{
		_thumbnailImageWidget.backgroundThumbnail = image;
	}
}

- (void) setSelectedImage:(UIImage*) image
{
	_selectedImage.image = image;
	[_selectedImage resizeToImageSize];
}

- (void) setProcessedImage:(UIImage*) image
{
	_processedImage.image = image;
	[_processedImage resizeToImageSize];
}

- (void) setAssetIndex:(NSUInteger) num
{	
    _assetIndex = num;
	_itemNumber.text = [NSString stringWithFormat:@"%d", num];
	_itemNumber.hidden = num == 0;
}

- (void) updateState
{
	self.selected = [_imageAssetCellDelegate imageAssetCellWidgetIsSelected:self];
	_selectedImage.hidden = !self.selected;
	
	self.disabled = [_imageAssetCellDelegate imageAssetCellWidgetIsDisabled:self];
	
	if(DeviceIsPad())
	{
		_imageFrame.frameColor = 
			/*[_imageAssetCellDelegate imageAssetCellWidgetWasProcessed:self] ||*/ self.disabled ? 
				[UIColor gray50Color] :
				[UIColor whiteColor];
				
	}
	
	_processedImage.hidden = ![_imageAssetCellDelegate imageAssetCellWidgetWasProcessed:self];
	
	[self setNeedsDisplay];
}

- (void) layoutSubWidgets 
{
	[super layoutSubWidgets];
	
	if(DeviceIsPad())
	{
		_imageFrame.frameOptimizedForSize = FLRectCenterRectInRect(self.frame, _imageFrame.frame);
		
		_itemNumber.frameOptimizedForLocation = CGRectMake(self.frame.origin.x, _imageFrame.frame.origin.y - 18.f, self.frame.size.width, 18.f);
		
		_selectedImage.frameOptimizedForSize = FLRectCenterOnPoint(_selectedImage.frame, 
			FLRectGetTopRight(_imageFrame.imageWidget.frame));
		_processedImage.frameOptimizedForSize = FLRectCenterOnPoint(_selectedImage.frame, FLRectGetTopLeft(_imageFrame.imageWidget.frame));
	}
	else
	{

		_thumbnailImageWidget.frameOptimizedForSize = FLRectCenterRectInRect(self.frame, CGRectInset(self.frame, 1, 1));
		
		_selectedImage.frameOptimizedForSize = FLRectJustifyRectInRectTopRight(_thumbnailImageWidget.frame, _selectedImage.frame);
		_processedImage.frameOptimizedForSize = FLRectJustifyRectInRectTopLeft(_thumbnailImageWidget.frame, _selectedImage.frame);
	}
}

@end

