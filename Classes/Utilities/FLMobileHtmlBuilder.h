//
//	FLMobileHtmlBuilder.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/23/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLHtmlBuilder.h"

@interface FLMobileHtmlBuilder : FLHtmlBuilder {
}

- (void) addStyleFont:(UIFont*) font;
- (void) addStyleColor:(UIColor*) color;

@end
