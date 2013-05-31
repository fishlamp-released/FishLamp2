//
//	FLAssetsLibraryPhotoBrowserController.h
//	FishLamp
//
//	Created by Mike Fullerton on 7/22/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#import <Foundation/Foundation.h>

#import "FLAssetsLibraryBrowserBase.h"
#import "FLImageAssetCellWidget.h"
#import "FLAssetQueue.h"

@class FLAssetsLibraryPhotoBrowserController;


@interface FLAssetsLibraryPhotoBrowserController : FLAssetsLibraryBrowserBase<FLImageAssetCellWidgetDelegate> {
@private
	ALAssetsGroup* _group;
	NSArray* _assets;
    
    BOOL _rangeSelectMode;
    NSUInteger _rangedSelectedCount;
    NSUInteger _rangeStartIndex;
    
    UIView* _notificationView;
}

@property (readwrite, retain, nonatomic) NSArray* assets;

@property (readwrite, retain, nonatomic) ALAssetsGroup* group;

- (void) beginLoadingAssets;

- (id) initWithAssetQueue:(FLAssetQueue*) queue  withGroup:(ALAssetsGroup*) group;

+ (FLAssetsLibraryPhotoBrowserController*) assetsLibraryPhotoBrowserController:(FLAssetQueue*) assetsQueue withGroup:(ALAssetsGroup*) group;

@end


