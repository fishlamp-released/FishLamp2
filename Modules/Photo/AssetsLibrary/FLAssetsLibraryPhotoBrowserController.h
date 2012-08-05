//
//	FLAssetsLibraryPhotoBrowserController.h
//	FishLamp
//
//	Created by Mike Fullerton on 7/22/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//
#import <Foundation/Foundation.h>

#import "FLAssetsLibraryBrowserBase.h"
#import "FLImageAssetCellWidget.h"
#import "FLAssetQueue.h"

@class FLAssetsLibraryPhotoBrowserController;


@interface FLAssetsLibraryPhotoBrowserController : FLAssetsLibraryBrowserBase<FLImageAssetCellWidgetDelegate> {
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

- (id) initWithAssetQueue:(FLAssetQueue*) queue  withGroup:(ALAssetsGroup*) group;

+ (FLAssetsLibraryPhotoBrowserController*) assetsLibraryPhotoBrowserController:(FLAssetQueue*) assetsQueue withGroup:(ALAssetsGroup*) group;

@end


