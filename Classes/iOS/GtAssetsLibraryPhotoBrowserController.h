//
//	GtAssetsLibraryPhotoBrowserController.h
//	FishLamp
//
//	Created by Mike Fullerton on 7/22/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#import <Foundation/Foundation.h>

#import "GtAssetsLibraryBrowserBase.h"
#import "GtImageAssetCellWidget.h"
#import "GtAssetQueue.h"

@class GtAssetsLibraryPhotoBrowserController;

@protocol GtAssetsLibraryPhotoBrowserControllerTheme <NSObject>
- (void) applyThemeToAssetsLibraryPhotoBrowserController:(GtAssetsLibraryPhotoBrowserController*) viewController;
@end

@interface GtAssetsLibraryPhotoBrowserController : GtAssetsLibraryBrowserBase<GtImageAssetCellWidgetDelegate> {
@private
	ALAssetsGroup* m_group;
	NSArray* m_assets;
    
    BOOL m_rangeSelectMode;
    NSUInteger m_rangedSelectedCount;
    NSUInteger m_rangeStartIndex;
    
    UIView* m_notificationView;
}

@property (readwrite, retain, nonatomic) NSArray* assets;

@property (readwrite, retain, nonatomic) ALAssetsGroup* group;

- (void) beginLoadingAssets;

- (id) initWithAssetQueue:(GtAssetQueue*) queue  withGroup:(ALAssetsGroup*) group;

+ (GtAssetsLibraryPhotoBrowserController*) assetsLibraryPhotoBrowserController:(GtAssetQueue*) assetsQueue withGroup:(ALAssetsGroup*) group;

@end


