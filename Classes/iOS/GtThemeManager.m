//
//	GtThemeManager.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/9/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtThemeManager.h"
#import "GtSavedThemeInfo.h"
#import "NSString+GUID.h"
#import "GtTheme.h"
#import "GtUserSession.h"
#import "GtThemeDescriptor.h"
#import "GtXmlParser.h"
#import "NSObject+XML.h"

NSString* const GtThemeDidChangeNotification = @"GtThemeDidChangeNotification";

@implementation GtThemeManager

static GtTheme* s_theme = nil;

GtSynthesizeSingleton(GtThemeManager);

- (id) init
{
	if((self = [super init]))
	{
        [self loadThemeList];
	}
	return self;
}

- (void) dealloc
{
	GtReleaseWithNil(s_theme);
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	GtSuperDealloc();
}

- (void) _themeDidChange
{
	[[NSNotificationCenter defaultCenter] postNotification:
		[NSNotification notificationWithName:GtThemeDidChangeNotification object:nil]];
}

+ (id) theme
{
    return s_theme;
}

- (void) setTheme:(GtTheme*) theme;
{
	if(s_theme)
	{
		if(s_theme != theme)
		{
			GtAssignObject(s_theme, theme);
			[self _themeDidChange];
		}
	}
	else
	{
		GtAssignObject(s_theme, theme);
	}
}

+ (BOOL) applyThemeToObject:(id) object themeAction:(SEL) themeAction
{
	if([s_theme respondsToSelector:themeAction])
	{
		[s_theme  performSelector:themeAction withObject:object];
		return YES;
	}
	
	return NO;
}

+ (id) queryTheme:(SEL) themeQuery
{
	if([s_theme respondsToSelector:themeQuery])
	{
		return [s_theme  performSelector:themeQuery];
	}

	return nil;
}

- (GtSavedThemeInfo*) loadSavedThemeInfo
{
	GtSavedThemeInfo* input = [GtSavedThemeInfo savedThemeInfo];
	input.uid = [NSString zeroGuidString];

	GtSavedThemeInfo* output = [[GtUserSession instance].documentsDatabase loadObject:input];
	if(!output)
	{
		output = GtReturnAutoreleased([[GtSavedThemeInfo alloc] init]);
		output.fontSizeValue = s_theme.fontSize;
		output.name = s_theme.name;
		output.className = NSStringFromClass([s_theme class]);
		output.uid = input.uid;
		[[GtUserSession instance].documentsDatabase saveObject:output];
	}
	
	return output;
}

- (void) saveThemeInfo:(GtSavedThemeInfo*) themeInfo
{	
	themeInfo.uid = [NSString zeroGuidString];
	[[GtUserSession instance].documentsDatabase saveObject:themeInfo];
}

- (void) setThemeWithThemeInfo:(GtSavedThemeInfo*) themeInfo
{
	GtTheme* theme = GtReturnAutoreleased([[NSClassFromString(themeInfo.className) alloc] initWithSavedThemeInfo:themeInfo]);
	[self setTheme:theme];
}

- (void) userSessionDidOpen:(id) sender
{
//	GtSavedThemeInfo* themeInfo = [self loadSavedThemeInfo];
//	if(themeInfo)
//	{
//		GtTheme* theme = GtReturnAutoreleased([[NSClassFromString(themeInfo.className) alloc] initWithSavedThemeInfo:themeInfo]);
//		[self setTheme:theme];
//	}
}

- (void) beginListeningToSessionChanges
{
	[[NSNotificationCenter defaultCenter] addObserver:self 
				selector:@selector(userSessionDidOpen:) 
				name:GtUserSessionOpenedNotification
				object:[GtUserSession instance]];
}
//+ (NSArray *)pathsForResourcesOfType:(NSString *)ext inDirectory:(NSString *)bundlePath
- (void) loadThemeList
{
    NSArray* paths = [[NSBundle mainBundle] pathsForResourcesOfType:@"xml" inDirectory:@"ThemeFiles"];

    NSMutableArray* themes = [NSMutableArray arrayWithCapacity:paths.count];

    for(NSString* path in paths)
    {
        GtThemeDescriptor* theme = [GtThemeDescriptor objectWithContentsOfFile:path];
        [themes addObject:theme];
        
//        GtThemeDescriptor* theme = [GtThemeDescriptor themeDescriptor];
        
    }


    GtLog(@"%@", paths);
    
}

@end