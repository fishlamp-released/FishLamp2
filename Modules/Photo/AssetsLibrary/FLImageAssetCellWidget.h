//
//  FLAssetLibraryBrowserCellWidget.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/14/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
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
	FLThumbnailWidget* m_thumbnailImageWidget;
	id<FLImageAsset> m_asset;
	id<FLImageAssetCellWidgetDelegate> m_imageAssetCellDelegate;
	FLImageWidget* m_selectedImage;
	FLImageWidget* m_processedImage;
	FLImageFrameWidget* m_imageFrame;
	FLLabelWidget* m_itemNumber;
    NSUInteger m_assetIndex;
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