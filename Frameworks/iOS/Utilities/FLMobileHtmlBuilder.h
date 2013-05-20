//
//	FLMobileHtmlBuilder.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/23/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "FLHtmlStringBuilder.h"

@interface FLXmlElement (FLMobileHtmlBuilder)

- (void) addStyleFont:(UIFont*) font;
- (void) addStyleColor:(UIColor*) color;

@end
