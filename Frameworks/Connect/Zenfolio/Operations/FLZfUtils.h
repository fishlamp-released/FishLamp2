//
//	FLZfUtils.h
//	FishLamp
//
//	Created by Mike Fullerton on 8/25/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FishLampCocoa.h"



#import "FLZfErrors.h"
#import "FLZfCachedCategories.h"
#import "FLZfGroupElementSyncInfo.h"
#import "FLZfCachedCategories.h"
#import "FLZfPhotoInfo.h"
#import "FLZfPhoto+More.h"
#import "FLZfUploadGallery+More.h"
#import "FLZfPreferences.h"
#import "FLZfAccessUpdater.h"
#import "FLZfAccessDescriptor.h"

#import "FLSlideshowOptions.h"
#import "FLZfLocalPreferences.h"

#import "FLServiceRequest.h"
#import "FLServiceKeys.h"

#import "FLZfGroup+More.h"
#import "FLZfPhotoSet+More.h"
#import "FLZfGroupElement+More.h"
#import "FLZfAccessDescriptor+More.h"


#if IOS
// TODO: ARG
    #import "FLPhotoExif.h"
    #import "FLZfPresentationModeOptions.h"
    #import "FLZfBrowserViewOptions.h"
    #import "FLTableViewLayoutBuilder.h"

    #define FLZfBrowserLandscapeColumnCount 6
    #define FLZfBrowserPortaitColumnCount 4

    #define FLZfBrowserCellLandscapeSize_iPad CGSizeMake(170.5, 190.5)
    #define FLZfBrowserCellPortaitSize_iPad CGSizeMake(192.0, 212.0)

    #define FLZfPhotoSetCellSize_iPhone CGSizeMake(80, 80)
    #define FLZfGroupElementListCellSize_iPhone CGSizeMake(0, 60)
    #define FLZfGroupElementListModeCellSize_iPad CGSizeMake(0, 140)

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

extern NSString* const FLZfCacheServiceType;
extern NSString* const FLZfWebServerServiceType;
extern NSString* const FLZfWebAPIServiceType;
extern NSString* const FLZfSyncServiceType;
extern NSString* const FLZfPrefsServiceType;

#define FLZfRootGroupIDKey @"ROOTGROUPID"

// these are the max sizes in bytes for the fields
#define CaptionSize 10000
#define TitleSize 200
#define KeywordsSize 4000
#define CopyrightSize 100
#define FileNameSize 250

#define ZenfolioOrange FLColorCreateWithRGBColorValues(203, 102, 10,1.0)
@class FLGradientButtonBaseClass;
extern void FLZfOrangeColorizer(FLGradientButtonBaseClass* button);
extern NSString *FLZfSizeString(long long size);


#if IOS
// TODO: FOR PETES SAKE - move this to app

@interface FLZfUtils : NSObject {
}

+ (void) addCommonDisplayRowsToHandler:(FLTableViewLayoutBuilder*) builder
	class:(Class) class
	optionsTab:(int) optionsTab
	dataSourceKey:(NSString*) dataSourceKey
	objectType:(NSString*) objectType;

@end

@interface FLZfPresentationModeOptions (Utils)
+ (FLZfPresentationModeOptions*) defaultOptions;
@end

@interface FLZfBrowserViewOptions (Utils)
+ (FLZfBrowserViewOptions*) defaultBrowserViewOptions;
- (void) saveAsDefault;
@end

@interface FLSlideshowOptions (Utils)
+ (FLSlideshowOptions*) defaultSlideshowOptions;
- (void) saveAsDefault;
@end
#endif

