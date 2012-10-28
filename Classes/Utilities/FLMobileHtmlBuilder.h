//
//	FLMobileHtmlBuilder.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/23/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLHtmlStringBuilder.h"

@interface FLXmlElement (FLMobileHtmlBuilder)

- (void) addStyleFont:(UIFont*) font;
- (void) addStyleColor:(UIColor*) color;

@end
