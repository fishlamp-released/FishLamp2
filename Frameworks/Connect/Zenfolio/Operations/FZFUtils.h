//
//	FLZenfolioUtils.h
//	FishLamp
//
//	Created by Mike Fullerton on 8/25/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLZenfolioErrors.h"
#import "FLZenfolioCachedCategories.h"
#import "FLZenfolioGroupElementSyncInfo.h"
#import "FLZenfolioCachedCategories.h"
#import "FLZenfolioPhotoInfo.h"


#if IOS

//#import "FLSlideshowOptions.h"
//#import "FLZenfolioPreferences.h"
//#import "FLZenfolioLocalPreferences.h"
// TODO: ARG
    #import "FLPhotoExif.h"
    #import "FLZenfolioPresentationModeOptions.h"
    #import "FLZenfolioBrowserViewOptions.h"
    #import "FLTableViewLayoutBuilder.h"

    #define FLZenfolioBrowserLandscapeColumnCount 6
    #define FLZenfolioBrowserPortaitColumnCount 4

    #define FLZenfolioBrowserCellLandscapeSize_iPad CGSizeMake(170.5, 190.5)
    #define FLZenfolioBrowserCellPortaitSize_iPad CGSizeMake(192.0, 212.0)

    #define FLZenfolioPhotoSetCellSize_iPhone CGSizeMake(80, 80)
    #define FLZenfolioGroupElementListCellSize_iPhone CGSizeMake(0, 60)
    #define FLZenfolioGroupElementListModeCellSize_iPad CGSizeMake(0, 140)

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

extern NSString* const FLZenfolioCacheServiceType;
extern NSString* const FLZenfolioWebServerServiceType;
extern NSString* const FLZenfolioWebAPIServiceType;
extern NSString* const FLZenfolioSyncServiceType;
extern NSString* const FLZenfolioPrefsServiceType;

#define FLZenfolioRootGroupIDKey @"ROOTGROUPID"

// these are the max sizes in bytes for the fields
#define CaptionSize 10000
#define TitleSize 200
#define KeywordsSize 4000
#define CopyrightSize 100
#define FileNameSize 250

#define ZenfolioOrange FLColorCreateWithRGBColorValues(203, 102, 10,1.0)
@class FLGradientButtonBaseClass;
extern void FLZenfolioOrangeColorizer(FLGradientButtonBaseClass* button);
extern NSString *FLZenfolioSizeString(long long size);


#if IOS
// TODO: FOR PETES SAKE - move this to app

@interface FLZenfolioUtils : NSObject {
}

+ (void) addCommonDisplayRowsToHandler:(FLTableViewLayoutBuilder*) builder
	class:(Class) class
	optionsTab:(int) optionsTab
	dataSourceKey:(NSString*) dataSourceKey
	objectType:(NSString*) objectType;

@end

@interface FLZenfolioPresentationModeOptions (Utils)
+ (FLZenfolioPresentationModeOptions*) defaultOptions;
@end

@interface FLZenfolioBrowserViewOptions (Utils)
+ (FLZenfolioBrowserViewOptions*) defaultBrowserViewOptions;
- (void) saveAsDefault;
@end

@interface FLSlideshowOptions (Utils)
+ (FLSlideshowOptions*) defaultSlideshowOptions;
- (void) saveAsDefault;
@end
#endif

