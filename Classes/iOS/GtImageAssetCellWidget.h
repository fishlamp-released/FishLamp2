//
//  GtAssetLibraryBrowserCellWidget.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/14/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtWidget.h"
#import "GtThumbnailWidget.h"
#import "GtImageAsset.h"
#import "GtImageFrameWidget.h"
#import "GtLabelWidget.h"

@protocol GtImageAssetCellWidgetDelegate;

@interface GtImageAssetCellWidget : GtWidget {
//@private
	GtThumbnailWidget* m_thumbnailImageWidget;
	id<GtImageAsset> m_asset;
	id<GtImageAssetCellWidgetDelegate> m_imageAssetCellDelegate;
	GtImageWidget* m_selectedImage;
	GtImageWidget* m_processedImage;
	GtImageFrameWidget* m_imageFrame;
	GtLabelWidget* m_itemNumber;
    NSUInteger m_assetIndex;
}

@property (readwrite, assign, nonatomic) id<GtImageAssetCellWidgetDelegate> imageAssetCellDelegate;

@property (readwrite, retain, nonatomic) id<GtImageAsset> asset;

@property (readwrite, assign, nonatomic) NSUInteger assetIndex;

- (void) setBackgroundThumbnail:(UIImage*) image;
- (void) setSelectedImage:(UIImage*) image;
- (void) setProcessedImage:(UIImage*) image;

- (void) updateState;

@end

@protocol GtImageAssetCellWidgetDelegate <NSObject>
- (void) imageAssetCellWidgetWasSelected:(GtImageAssetCellWidget*) widget;
- (BOOL) imageAssetCellWidgetIsSelected:(GtImageAssetCellWidget*) widget;
- (BOOL) imageAssetCellWidgetIsDisabled:(GtImageAssetCellWidget*) widget;
- (BOOL) imageAssetCellWidgetWasProcessed:(GtImageAssetCellWidget*) widget;

@end