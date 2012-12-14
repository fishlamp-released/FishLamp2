//
//	UILabel+FLExtras.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/15/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLCocoaUIRequired.h"
#import "UIView+FLViewGeometry.h"

@interface UILabel (FLExtras)
- (CGSize) sizeThatFitsText:(CGSize) size;
- (CGSize) sizeThatFitsText;
- (CGSize) sizeToFitText;
- (CGSize) sizeToFitText:(CGSize) size;
- (void) drawUnderline:(CGRect) inRect 
	withColor:(UIColor*) color
	withLineWidth:(CGFloat) width; 
	
- (void)sizeToFitWidth:(CGFloat)fixedWidth;
- (CGSize)sizeThatFitsWidth:(CGFloat)fixedWidth;

- (void) addGlow;

@end