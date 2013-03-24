//
//	SDKLabel+FLExtras.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/15/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLCocoaUIRequired.h"
#import "SDKView+FLViewGeometry.h"

@interface SDKLabel (FLExtras)
- (CGSize) sizeThatFitsText:(CGSize) size;
- (CGSize) sizeThatFitsText;
- (CGSize) sizeToFitText;
- (CGSize) sizeToFitText:(CGSize) size;
- (void) drawUnderline:(CGRect) inRect 
	withColor:(SDKColor*) color
	withLineWidth:(CGFloat) width; 
	
- (void)sizeToFitWidth:(CGFloat)fixedWidth;
- (CGSize)sizeThatFitsWidth:(CGFloat)fixedWidth;

- (void) addGlow;

@end