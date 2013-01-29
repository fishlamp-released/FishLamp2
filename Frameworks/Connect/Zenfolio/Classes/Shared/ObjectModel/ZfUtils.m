//
//	ZFUtils.m
//	MyZen
//
//	Created by Mike Fullerton on 8/25/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "ZFUtils.h"

#import "FLUserDefaults.h"
#import "ZFUploadGallery.h"
#import "FLDisplayFormatters.h"
#import "NSFileManager+FLExtras.h"
#import "FLCachedImageCacheBehavior.h"
#import "FLObjectCacheBehavior.h"
#import "ZFExifTags.h"
#import "ZFBrowserViewOptions.h"
#import "NSString+GUID.h"
#import "NSString+Lists.h"


#define FILENAME @"IMG_"


void ZFOrangeColorizer(FLGradientButtonBaseClass* button)
{

FLAssertFailed_v(@"wrong kind of button");

//	UIColor* orange = ZenfolioOrange;
//	UIColor* lightOrange = [UIColor colorWithColorValues:FLColorValuesLighten(orange.rgbColorValues, .8)];
//
//	[button.backgroundWidget.topGradient setGradientColors:lightOrange endColor:orange];
//	[button.backgroundWidget.bottomGradient setGradientColors:orange endColor:lightOrange];
//
//	[button setLightText];
}

#if IOS
#import "FLOldUserNotificationView.h"
#import "FLGradientButton.h"
#import "FLLegacyDataSource.h"
#import "FLMultiLineTextEditCell.h"

void ShowOfflineAlert(NSString* action)
{	
	FLOldUserNotificationView* view = [[FLOldUserNotificationView alloc] initAsWarningNotification];;
	view.title = action;
	view.shouldAutoCloseAfterDelay = YES;
	
	view.text = NSLocalizedString(@"No network connection is available. Please try again when you have a network connection.", nil);
	[view showNotification];
	FLReleaseWithNil(view);
}


@implementation ZFUtils

+ (void) addCommonDisplayRowsToHandler:(FLTableViewLayoutBuilder*) builder 
	class:(Class) class
	optionsTab:(int) optionsTab
	dataSourceKey:(NSString*) dataSourceKey
	objectType:(NSString*) objectType
{
	[builder addSection:@"common"];

	BOOL connected = [FLReachableNetwork instance].isReachable;

	if([class respondsToSelector:@selector(TitleKey)])
	{
		[builder addCell:[FLMultiLineTextEditCell multiLineTextEditCell:NSLocalizedString(@"Title", nil)] forKey:FLKeyPathStringMake(dataSourceKey, [class TitleKey])
            configureCell:^(id cell) {
                [cell setMaxDataSize:TitleSize]; 
                [cell setHelpText: connected ? 
                    [NSString stringWithFormat:(NSLocalizedString(@"Enter a title for your %@", nil)), objectType] : 
                    [NSString stringWithFormat:(NSLocalizedString(@"This %@ has no title", nil)), objectType]];
                [cell setDisallowReturnKey:YES];
            }
        
        ];
	}
	
	if([class respondsToSelector:@selector(CaptionKey)])
	{
		[builder addCell:[FLMultiLineTextEditCell multiLineTextEditCell:NSLocalizedString(@"Caption", nil)] forKey:FLKeyPathStringMake(dataSourceKey, [class CaptionKey])];
		builder.cell.maxDataSize = CaptionSize; 
		builder.cell.helpText = connected ?  [NSString stringWithFormat:(NSLocalizedString(@"Enter a caption for your %@", nil)), objectType] : 
                                            [NSString stringWithFormat:(NSLocalizedString(@"This %@ has no caption", nil)), objectType];;
		builder.cell.formatterClass = [FLSimpleHtmlFormatter class];
	}
	
	if([class respondsToSelector:@selector(KeywordsKey)])
	{
		[builder addCell:[FLMultiLineTextEditCell multiLineTextEditCell:NSLocalizedString(@"Keywords", nil)] forKey:FLKeyPathStringMake(dataSourceKey, [class KeywordsKey])];
		builder.cell.maxDataSize = KeywordsSize; 
		builder.cell.helpText = connected ?  NSLocalizedString(@"Use quotation marks around multiple words", nil) : 
                                            [NSString stringWithFormat:(NSLocalizedString(@"This %@ has no keywords", nil)), objectType];
		builder.cell.formatterClass = [FLKeywordListFormatter class];
	}
	
	
	if([class respondsToSelector:@selector(CopyrightKey)])
	{
		[builder addCell:[FLMultiLineTextEditCell multiLineTextEditCell:NSLocalizedString(@"Copyright", nil)] forKey:FLKeyPathStringMake(dataSourceKey, [class CopyrightKey])
            configureCell:^(id cell) {
                [cell setMaxDataSize:CopyrightSize]; 
                [cell setHelpText: connected ?  
                    [NSString stringWithFormat:(NSLocalizedString(@"Enter a copyright for your	%@", nil)), objectType] : 
                    [NSString stringWithFormat:(NSLocalizedString(@"This %@ has no copyright", nil)), objectType]];
                [cell setDisallowReturnKey:YES];
            }
        ];
	}
}

@end

#endif





#define KILO (1 << 10)
#define MEGA (1 << 20)
#define GIGA ((unsigned)1 << 30)

//	convert a byte size into a string
NSString *ZFSizeString(long long size)
{
	if ( size < KILO ) {
		return [NSString stringWithFormat:@"%lld bytes", size];
	} else if ( size < MEGA ) {
		return [NSString stringWithFormat:@"%.1f KB", size /(float)KILO];
	} else if ( size < GIGA ) {
		return [NSString stringWithFormat:@"%.1f MB", size /(float)MEGA];
	} else {
		return [NSString stringWithFormat:@"%.1f GB", size /(float)GIGA];
	}
}

#if IOS

@implementation ZFPresentationModeOptions (Utils)

+ (ZFPresentationModeOptions*) defaultOptions
{
	ZFPresentationModeOptions* options = [ZFPresentationModeOptions presentationModeOptions];
	ZFLocalPreferences* prefs = [ZFLocalPreferences loadPreferences];
	options.slideshowOptions = prefs.defaultSlideshowOptions;
	options.browserViewOptions = prefs.defaultBrowserViewOptions;
	return options;
}

@end
#endif

@implementation ZFCachedCategories (Cache)
FLSynthesizeCachedObjectHandlerProperty(ZFCachedCategories);
@end


@implementation ZFBrowserViewOptions (Utils)

@end

#if IOS
#import "FLSlideshowOptions.h"

@implementation FLSlideshowOptions (Utils)
+ (FLSlideshowOptions*) defaultSlideshowOptions
{
	FLSlideshowOptions* input = [FLSlideshowOptions slideshowOptions];
	input.uid = [NSString zeroGuidString];
	FLSlideshowOptions* output = [[FLUserLoginService instance].documentsDatabase loadObject:input];
	if(!output)
	{
		output = input;
		output.speedValue = 5.0;
	}
	
	return output;
}
- (void) saveAsDefault
{
	self.uid = [NSString zeroGuidString];
	[[FLUserLoginService instance].documentsDatabase saveObject:self];
}
@end
#endif
