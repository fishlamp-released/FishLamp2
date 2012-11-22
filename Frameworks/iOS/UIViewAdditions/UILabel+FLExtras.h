//
//	UILabel+FLExtras.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/15/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UILabel (FLExtras)
- (FLSize) sizeThatFitsText:(FLSize) size;
- (FLSize) sizeThatFitsText;
- (FLSize) sizeToFitText;
- (FLSize) sizeToFitText:(FLSize) size;
- (void) drawUnderline:(FLRect) inRect 
	withColor:(UIColor*) color
	withLineWidth:(CGFloat) width; 
	
- (void)sizeToFitWidth:(CGFloat)fixedWidth;
- (FLSize)sizeThatFitsWidth:(CGFloat)fixedWidth;

- (void) addGlow;

@end