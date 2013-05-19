//
//  FLAssetLibraryBrowserCellWidget.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/14/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLWidget.h"
#import "FLThumbnailWidget.h"
#import "FLImageAsset.h"
#import "FLImageFrameWidget.h"
#import "FLLabelWidget.h"

@protocol FLImageAssetCellWidgetDelegate;

@interface FLImageAssetCellWidget : FLWidget {
//@private
	FLThumbnailWidget* _thumbnailImageWidget;
	id<FLImageAsset> _asset;
	__unsafe_unretained id<FLImageAssetCellWidgetDelegate> _imageAssetCellDelegate;
	FLImageWidget* _selectedImage;
	FLImageWidget* _processedImage;
	FLImageFrameWidget* _imageFrame;
	FLLabelWidget* _itemNumber;
    NSUInteger _assetIndex;
}

@property (readwrite, assign, nonatomic) id<FLImageAssetCellWidgetDelegate> imageAssetCellDelegate;

@property (readwrite, retain, nonatomic) id<FLImageAsset> asset;

@property (readwrite, assign, nonatomic) NSUInteger assetIndex;

- (void) setBackgroundThumbnail:(UIImage*) image;
- (void) setSelectedImage:(UIImage*) image;
- (void) setProcessedImage:(UIImage*) image;

- (void) updateState;

@end

@protocol FLImageAssetCellWidgetDelegate <NSObject>
- (void) imageAssetCellWidgetWasSelected:(FLImageAssetCellWidget*) widget;
- (BOOL) imageAssetCellWidgetIsSelected:(FLImageAssetCellWidget*) widget;
- (BOOL) imageAssetCellWidgetIsDisabled:(FLImageAssetCellWidget*) widget;
- (BOOL) imageAssetCellWidgetWasProcessed:(FLImageAssetCellWidget*) widget;

@end