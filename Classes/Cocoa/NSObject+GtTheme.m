//
//	NSObject+GtTheme.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/9/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "NSObject+GtTheme.h"
#import "GtThemeManager.h"
#import <objc/runtime.h>
static void * const kThemeFunctionKey = (void*)&kThemeFunctionKey;

@implementation NSObject (GtTheme)

- (void) applyTheme
{
	if(!self.wasThemed)
	{	
		SEL sel = self.themeAction;
		if(sel)
		{
			[GtThemeManager applyThemeToObject:self themeAction:sel];
			self.wasThemed = YES;
		}
	}
}

- (BOOL) wasThemed
{
	return NO;
}

- (void) setWasThemed:(BOOL) wasThemed
{
	GtAssertFailed(@"a themed object needs to override this.");
}

- (SEL) themeAction
{
	return nil;
}

- (void) setThemeAction:(SEL) themeAction
{

}

- (void) themeDidChange
{

}


- (GtApplyThemeBlock) themeFunction
{
    return objc_getAssociatedObject(self, kThemeFunctionKey);
}

- (void) setThemeFunction:(GtApplyThemeBlock) themeFunction
{
    objc_setAssociatedObject(self, kThemeFunctionKey, themeFunction, OBJC_ASSOCIATION_ASSIGN);
}

@end