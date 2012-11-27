//
//	NSImage_+FLColorize.h
//	Milton_iOS
//
//	Created by Mike Fullerton on 12/26/10.
//	Copyright 2010 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLCore.h"
#import "FLCocoaCompatibility.h"

@interface UIImage_ (Colorize)

-(NSImage_ *)colorizeImage:(UIColor_ *)theColor blendMode:(CGBlendMode) blendMode;

- (NSImage_ *)imageTintedWithColor:(UIColor_ *)color fraction:(CGFloat)fraction;


+ (NSImage_*) imageNamed:(NSString*) name withColor:(UIColor_*) color blendMode:(CGBlendMode) blendMode; 
	// kCGBlendModeOverlay, kCGBlendModeMultiply work well.
	
+ (NSImage_*) whiteImageNamed:(NSString*) name;	// kCGBlendModeOverlay	  
@end
