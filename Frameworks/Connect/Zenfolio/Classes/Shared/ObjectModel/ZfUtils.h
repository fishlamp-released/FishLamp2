//
//	ZFUtils.h
//	MyZen
//
//	Created by Mike Fullerton on 8/25/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FishLampCocoa.h"



#import "ZFErrors.h"
#import "ZFCachedCategories.h"
#import "ZFGroupElementSyncInfo.h"
#import "ZFCachedCategories.h"
#import "ZFPhotoInfo.h"
#import "ZFPhoto+More.h"
#import "ZFUploadGallery+More.h"
#import "ZFPreferences.h"
#import "ZFAccessUpdater.h"
#import "ZFAccessDescriptor.h"

#import "FLSlideshowOptions.h"
#import "ZFLocalPreferences.h"

#import "FLServiceRequest.h"
#import "FLServiceKeys.h"

#import "ZFGroup+More.h"
#import "ZFPhotoSet+More.h"
#import "ZFGroupElement+More.h"
#import "ZFAccessDescriptor+More.h"


#if IOS
// TODO: ARG
    #import "FLPhotoExif.h"
    #import "ZFPresentationModeOptions.h"
    #import "ZFBrowserViewOptions.h"
    #import "FLTableViewLayoutBuilder.h"

    #define ZFBrowserLandscapeColumnCount 6
    #define ZFBrowserPortaitColumnCount 4

    #define ZFBrowserCellLandscapeSize_iPad CGSizeMake(170.5, 190.5)
    #define ZFBrowserCellPortaitSize_iPad CGSizeMake(192.0, 212.0)

    #define ZFPhotoSetCellSize_iPhone CGSizeMake(80, 80)
    #define ZFGroupElementListCellSize_iPhone CGSizeMake(0, 60)
    #define ZFGroupElementListModeCellSize_iPad CGSizeMake(0, 140)

    #define CaptionOpacity 0.60

    #define UploadLargeSize 800
    #define UploadMediumSize 580

    #define kBackgroundColor [UIColor gray15Color]

    #define AUTO_DISMISS_INTERVAL 8.0


    extern void ShowOfflineAlert(NSString* action);

    #define PHOTOSET_CELL_HEIGHT 80
    #define GROUP_ROW_HEIGHT 63

    #define kLongDownloadTimeout 180.0f

#endif

extern NSString* const ZFCacheServiceType;
extern NSString* const ZFWebServerServiceType;
extern NSString* const ZFWebAPIServiceType;
extern NSString* const ZFSyncServiceType;
extern NSString* const ZFPrefsServiceType;

#define ZFRootGroupIDKey @"ROOTGROUPID"

// these are the max sizes in bytes for the fields
#define CaptionSize 10000
#define TitleSize 200
#define KeywordsSize 4000
#define CopyrightSize 100
#define FileNameSize 250

#define ZenfolioOrange FLColorCreateWithRGBColorValues(203, 102, 10,1.0)
@class FLGradientButtonBaseClass;
extern void ZFOrangeColorizer(FLGradientButtonBaseClass* button);
extern NSString *ZFSizeString(long long size);


#if IOS
// TODO: FOR PETES SAKE - move this to app

@interface ZFUtils : NSObject {
}

+ (void) addCommonDisplayRowsToHandler:(FLTableViewLayoutBuilder*) builder
	class:(Class) class
	optionsTab:(int) optionsTab
	dataSourceKey:(NSString*) dataSourceKey
	objectType:(NSString*) objectType;

@end

@interface ZFPresentationModeOptions (Utils)
+ (ZFPresentationModeOptions*) defaultOptions;
@end

@interface ZFBrowserViewOptions (Utils)
+ (ZFBrowserViewOptions*) defaultBrowserViewOptions;
- (void) saveAsDefault;
@end

@interface FLSlideshowOptions (Utils)
+ (FLSlideshowOptions*) defaultSlideshowOptions;
- (void) saveAsDefault;
@end
#endif

