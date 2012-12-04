//
//	FLMobileHtmlBuilder.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/23/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLMobileHtmlBuilder.h"

@implementation FLXmlElement (FLMobileHtmlBuilder)

- (void) addStyleFont:(UIFont*) font 
{
	[self appendAttribute:[NSString stringWithFormat:@"font-family:'%@'; ", font.familyName] forKey:@"style"];
	[self appendAttribute:[NSString stringWithFormat:@"font-size:%dpt; ", (int) (font.pointSize-2) ] forKey:@"style"];
	[self appendAttribute:[NSString stringWithFormat:@"-webkit-text-size-adjust: none; "] forKey:@"style"];
			
	if([font.fontName rangeOfString:@"Bold" options:NSCaseInsensitiveSearch].length > 0) {
		[self appendAttribute:@"font-weight:bold; " forKey:@"style"];
	}
}

- (void) addStyleColor:(UIColor*) color  {
	[self appendAttribute:[NSString stringWithFormat:@"color: %@; ", [color toHexString:YES]] forKey:@"Style"];
}
@end
