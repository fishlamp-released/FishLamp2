//
//	NSObject+GtTheme.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/9/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#define GtThemeSelectorNameFor(className) applyTo##className
#define GtThemeSelectorForName(className) @selector(GtThemeSelectorNameFor(className):)

@protocol GtThemedObject <NSObject>
@optional
@property (readwrite, assign, nonatomic) BOOL wasThemed;
@property (readwrite, assign, nonatomic) SEL themeAction; 
- (void) applyTheme;
- (void) themeDidChange;
@end

typedef void (^GtApplyThemeBlock)(id object); 

@interface NSObject (GtTheme)

@property (readwrite, assign, nonatomic) BOOL wasThemed;
@property (readwrite, assign, nonatomic) SEL themeAction; 
- (void) applyTheme;
- (void) themeDidChange;

@property (readwrite, assign, nonatomic) GtApplyThemeBlock themeFunction;

@end

typedef struct {
	SEL themeAction;
	unsigned int wasThemed: 1;
} GtThemeState;

/*
GtSynthesizeStructProperty(wasThemed, setWasThemed, BOOL, m_themeState);
GtSynthesizeStructProperty(themeAction, setThemeAction, SEL, m_themeState);
*/

#define GtSetThemeAction(name) self.themeAction = @selector(GtThemeSelectorNameFor(name):)