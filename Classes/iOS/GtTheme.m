//
//  GtTheme.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/7/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTheme.h"
#import <objc/runtime.h>

@implementation GtTheme : NSObject

@synthesize fontSize = m_textSize;
@synthesize name = m_name;

- (id) init
{
	return [self initWithSavedThemeInfo:nil];
}

- (id) initWithSavedThemeInfo:(GtSavedThemeInfo*) info
{
	if((self = [super init]))
	{
		if(info)
		{
			self.fontSize = info.fontSizeValue;
		}
	}
	
	return self;
}

- (void) dealloc
{
	GtRelease(m_name);
	GtSuperDealloc();
}



@end
