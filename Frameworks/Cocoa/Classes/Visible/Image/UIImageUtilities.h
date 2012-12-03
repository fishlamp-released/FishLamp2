//
//	UIImageUtilities.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/21/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLCore.h"
#import "FLCocoaCompatibility.h"

@interface UIImage_ (Utils)
- (void) shrinkImage:(NSImage_**) outImage maxLongSide:(float) maxLongSize makeSquare:(BOOL) makeSquare;
- (void) convertToJpegData:(CGFloat) compression outData:(NSData**) outData;

- (void) rotate90Degrees:(BOOL) clockWise 
	outImage:(NSImage_**) outImage;

- (void) rotate:(CGFloat) degrees
	outImage:(NSImage_**) outImage;

- (void) flip:(NSImage_**) outImage;

+(NSImage_ *)makeRoundCornerImage : (NSImage_*) img : (int) cornerWidth : (int) cornerHeight;

@end

