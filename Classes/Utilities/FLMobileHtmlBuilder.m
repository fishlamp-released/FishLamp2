//
//	FLMobileHtmlBuilder.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/23/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLMobileHtmlBuilder.h"



@implementation FLMobileHtmlBuilder
- (void) addStyleFont:(UIFont*) font 
{
	[self appendAttributeWithFormat:@"font-family:'%@'; ", font.familyName];
	[self appendAttributeWithFormat:@"font-size:%dpt; ", (int) (font.pointSize-2) ];
	[self appendAttributeWithString:@"-webkit-text-size-adjust: none; "];
			
	if([font.fontName rangeOfString:@"Bold" options:NSCaseInsensitiveSearch].length > 0)
	{
		[self appendAttributeWithString:@"font-weight:bold; "];
	}
}

- (void) addStyleColor:(UIColor*) color 
{
	[self appendAttributeWithFormat:@"color: %@; ", [color toHexString:YES]];
}
@end
