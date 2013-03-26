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

NSString* FLThemeChangedNotificationKey = @"FLThemeChangedNotificationKey";
NSString* FLCurrentThemeKey = @"FLCurrentThemeKey";

@interface FLThemeManager ()
@property (readwrite, strong, nonatomic) NSArray* themes;
@end    
    
@implementation NSTextField (FLThemeManager)

- (void) newViewWillMoveToSuperview:(NSView*) newSuperview {

    if(newSuperview) {
        self.textColor = [NSColor redColor];
    }
    
    [self newViewWillMoveToSuperview:newSuperview];
}

@end    

@implementation FLTestTextField
- (void) viewWillMoveToSuperview:(NSView *)newSuperview {
    
   
    
    [super viewWillMoveToSuperview:newSuperview];
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
        
        FLSwizzleInstanceMethod([NSTextField class],@selector(viewWillMoveToSuperview:), @selector(newViewWillMoveToSuperview:));
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

- (void) setCurrentTheme:(id) theme {

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

    NSURL* fileURL = [[NSBundle mainBundle] URLForResource:fileName withExtension:@"xml"];

    FLParsedItem* xml = [[FLXmlParser xmlParser] parseFileAtURL:fileURL];
    if(xml) {
        
        FLObjectDescriber* themeType = [FLObjectDescriber objectDescriber:@"theme" objectClass:themeClass];
        
        return [[FLXmlObjectBuilder xmlObjectBuilder] objectsFromXML:xml withObjectType:themeType];
    }   
    
    return nil;
}


@end

@implementation FLThemeHandler

- (NSString*) fontFamilyName {
    return @"Verdana";
}

- (NSFont*) applicationFont:(CGFloat) fontSize {
    SDKFont* font = [SDKFont fontWithName:@"Verdana-Regular" size:fontSize];
    FLAssertNotNil(font);
    return font;
}

- (SDKFont *)boldApplicationFont:(CGFloat)fontSize {
    SDKFont* font = [SDKFont fontWithName:@"Verdand-Bold" size:fontSize];
    FLAssertNotNil(font);
    return font;
}

- (NSNumber*) smallFontSize {
    return [NSNumber numberWithInt:10];
}
- (NSNumber*) applicationFontSize {
    return [NSNumber numberWithInt:12];
}

- (NSNumber*) header1FontSize{
    return [NSNumber numberWithInt:14];
}
- (NSNumber*) header2FontSize {
    return [NSNumber numberWithInt:16];
}


@end




