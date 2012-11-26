//
//	FLThemeManager.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/9/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLThemeManager.h"
#import "FLSavedThemeInfo.h"
#import "NSString+GUID.h"
#import "FLUserSession.h"
#import "NSObject+XML.h"

#import "FLTheme.h"

NSString* const FLThemeDidChangeNotification = @"FLThemeDidChangeNotification";

@implementation FLThemeManager

FLSynthesizeSingleton(FLThemeManager);
@synthesize themeFileNameList = _themes;

- (void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	super_dealloc_();
}

- (FLSavedThemeInfo*) loadSavedThemeInfo
{
//	FLSavedThemeInfo* input = [FLSavedThemeInfo savedThemeInfo];
//	input.uid = [NSString zeroGuidString];
//
//	FLSavedThemeInfo* output = [[FLUserSession instance].documentsDatabase loadObject:input];
//	if(!output)
//	{
//		output = autorelease_([[FLSavedThemeInfo alloc] init]);
//		output.fontSizeValue = s_theme.fontSize;
//		output.name = s_theme.name;
//		output.className = NSStringFromClass([s_theme class]);
//		output.uid = input.uid;
//		[[FLUserSession instance].documentsDatabase saveObject:output];
//	}
	
//	return output;

    return nil;
}

- (void) saveThemeInfo:(FLSavedThemeInfo*) themeInfo
{	
//	themeInfo.uid = [NSString zeroGuidString];
//	[[FLUserSession instance].documentsDatabase saveObject:themeInfo];
}

- (void) setThemeWithThemeInfo:(FLSavedThemeInfo*) themeInfo
{
//	FLLegacyTheme* theme = autorelease_([[NSClassFromString(themeInfo.className) alloc] initWithSavedThemeInfo:themeInfo]);
//	[self setCurrentTheme:theme];
}

- (void) userSessionDidOpen:(id) sender
{
//	FLSavedThemeInfo* themeInfo = [self loadSavedThemeInfo];
//	if(themeInfo)
//	{
//		FLTheme* theme = autorelease_([[NSClassFromString(themeInfo.className) alloc] initWithSavedThemeInfo:themeInfo]);
//		[self setCurrentTheme:theme];
//	}
}

- (void) beginListeningToSessionChanges
{
//	[[NSNotificationCenter defaultCenter] addObserver:self 
//				selector:@selector(userSessionDidOpen:) 
//				name:FLUserSessionOpenedNotification
//				object:[FLUserSession instance]];
}

- (NSString*) themePathForName:(NSString*) name {
    NSString* bundlePath = [[NSBundle mainBundle] bundlePath];
    return [bundlePath stringByAppendingPathComponent:name];
}

- (void) setThemeWithFileName:(NSString*) fileName {
//    FLTheme* theme = [FLTheme objectWithContentsOfFile:[self themePathForName:fileName]];
//    [FLTheme setCurrentTheme:theme];
//
//    [[NSNotificationCenter defaultCenter] postNotification:
//		[NSNotification notificationWithName:FLThemeDidChangeNotification object:self]];
}

- (void) setDefaultTheme {
//    [self setThemeWithFileName:FLDefaultThemeFileName];
}


- (void) loadThemeList
{
    release_(_themes);

//    NSArray* paths = [[NSBundle mainBundle] pathsForResourcesOfType:@"flt" inDirectory:nil];
//    _themes = [[NSMutableArray alloc] initWithCapacity:paths.count];
//    for(NSString* path in paths) {
//        [_themes addObject:[path lastPathComponent]];
//    }

    


//    NSMutableArray* themes = [NSMutableArray arrayWithCapacity:paths.count];
//
//    for(NSString* path in paths)
//    {
//        FLTheme* theme = [FLTheme objectWithContentsOfFile:path];
//        [themes addObject:theme];
//    }
}

@end