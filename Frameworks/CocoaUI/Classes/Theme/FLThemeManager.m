//
//  FLThemeManager.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLThemeManager.h"
#import "FLXmlParser.h"
#import "FLParsedItem.h"
#import "FLObjectDescriber.h"
#import "FLXmlObjectBuilder.h"
#import "FLObjcRuntime.h"
#import "NSObject+FLTheme.h"
#import "FLJsonParser.h"
#import "FLJsonObjectBuilder.h"

NSString* FLThemeChangedNotificationKey = @"FLThemeChangedNotificationKey";
NSString* FLCurrentThemeKey = @"FLCurrentThemeKey";

@interface FLThemeManager ()
@property (readwrite, strong, nonatomic) NSArray* themes;
@end    
    
@implementation NSObject (FLThemeManager)
- (void) newAwakeFromNib {
    [self newAwakeFromNib]; // call original awakeFromNib
    if([self isThemable]) {
        [self themeDidChange:[FLTheme currentTheme]];
    }
}
@end        
    
@implementation FLThemeManager 

FLSynthesizeSingleton(FLThemeManager)

@synthesize currentTheme = _currentTheme;
@synthesize themes = _themes;

- (id) init {
    self = [super init];
    if(self) {
        _themes = [[NSMutableArray alloc] init];
        FLSwizzleInstanceMethod([NSObject class],@selector(awakeFromNib), @selector(newAwakeFromNib));
	}
	return self;
}


#if FL_MRC
- (void) dealloc {
    [_themes release];
    [_currentTheme release];
	[super dealloc];
}
#endif

- (void) setCurrentTheme:(FLTheme*) theme {

    if(theme != _currentTheme) {
        FLSetObjectWithRetain(_currentTheme, theme);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:FLThemeChangedNotificationKey 
                                                            object:self 
                                                          userInfo:[NSDictionary dictionaryWithObject:theme forKey:FLCurrentThemeKey]];
    }
}

- (void) addThemesWithArray:(NSArray*) themes {
    [_themes addObjectsFromArray:themes];
}

- (void) addTheme:(FLTheme*) theme {
    [_themes addObject:theme];
}

- (NSArray*) loadThemesFromBundleXmlFile:(NSString*) fileName  themeClass:(Class) themeClass {

    NSURL* fileURL = [[NSBundle mainBundle] URLForResource:fileName withExtension:@"json"];
    
    id object = [[FLJsonParser jsonParser] parseFileAtURL:fileURL];
    if(object) {
    
        FLJsonObjectBuilder* builder = [FLJsonObjectBuilder jsonObjectBuilder];
    
        NSArray* outThemes = [builder arrayOfObjectsFromJSON:[object objectForKey:@"themes"] expectedRootObjectClass:themeClass];
    
//        NSArray* themes = [object objectForKey:@"themes"];
//        NSMutableArray* outThemes = [NSMutableArray array];
//        FLObjectDescriber* themeType = [FLObjectDescriber objectDescriber:@"theme" objectClass:themeClass];
//        
//        for(NSDictionary* themeDictionary in themes) {
//            [outThemes addObject:[builder objectFromJSON:themeDictionary withObjectType:themeType]];
//        }
        
        
        return outThemes;
    }   


//    FLParsedItem* xml = [[FLXmlParser xmlParser] parseFileAtURL:fileURL];
//    if(xml) {
//        
//        FLObjectDescriber* themeType = [FLObjectDescriber objectDescriber:@"theme" objectClass:themeClass];
//        
//        return [[FLXmlObjectBuilder xmlObjectBuilder] objectsFromXML:xml withObjectType:themeType];
//    }   
//    
    return nil;
}

#pragma GCC diagnostic ignored "-Warc-performSelector-leaks"

- (void) applyThemeToObject:(id) object {
    SEL selector = [object themeSelector];
    if(selector) {
        [self performSelector:selector withObject:object];
    }
}


@end

//@implementation FLThemeHandler
//
//- (NSString*) fontFamilyName {
//    return @"Verdana";
//}
//
//- (NSFont*) applicationFont:(CGFloat) fontSize {
//    SDKFont* font = [SDKFont fontWithName:@"Verdana-Regular" size:fontSize];
//    FLAssertNotNil(font);
//    return font;
//}
//
//- (SDKFont *)boldApplicationFont:(CGFloat)fontSize {
//    SDKFont* font = [SDKFont fontWithName:@"Verdand-Bold" size:fontSize];
//    FLAssertNotNil(font);
//    return font;
//}
//
//- (NSNumber*) smallFontSize {
//    return [NSNumber numberWithInt:10];
//}
//- (NSNumber*) applicationFontSize {
//    return [NSNumber numberWithInt:12];
//}
//
//- (NSNumber*) header1FontSize{
//    return [NSNumber numberWithInt:14];
//}
//- (NSNumber*) header2FontSize {
//    return [NSNumber numberWithInt:16];
//}
//
//
//@end




