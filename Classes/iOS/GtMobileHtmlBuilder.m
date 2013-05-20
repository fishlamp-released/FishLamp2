//
//	GtMobileHtmlBuilder.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/23/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtMobileHtmlBuilder.h"



@implementation GtMobileHtmlBuilder
- (void) addStyleFont:(UIFont*) font 
{
	[self addDataWithFormatToAttribute:@"font-family:'%@'; ", font.familyName];
	[self addDataWithFormatToAttribute:@"font-size:%dpt; ", (int) (font.pointSize-2) ];
	[self addDataToAttribute:@"-webkit-text-size-adjust: none; "];
			
	if([font.fontName rangeOfString:@"Bold" options:NSCaseInsensitiveSearch].length > 0)
	{
		[self addDataToAttribute:@"font-weight:bold; "];
	}
}

- (void) addStyleColor:(UIColor*) color 
{
	[self addDataWithFormatToAttribute:@"color: %@; ", [color toHexString:YES]];
}
@end
