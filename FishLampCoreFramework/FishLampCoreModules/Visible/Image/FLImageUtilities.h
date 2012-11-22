//
//	FLImageUtilities.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/21/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

// TODO: move to core?
#import "FLImage.h"

@interface FLImage (Utils)
- (void) shrinkImage:(FLImage**) outImage maxLongSide:(float) maxLongSize makeSquare:(BOOL) makeSquare;
- (void) convertToJpegData:(CGFloat) compression outData:(NSData**) outData;

- (void) rotate90Degrees:(BOOL) clockWise 
	outImage:(FLImage**) outImage;

- (void) rotate:(CGFloat) degrees
	outImage:(FLImage**) outImage;

- (void) flip:(FLImage**) outImage;

+(FLImage *)makeRoundCornerImage : (FLImage*) img : (int) cornerWidth : (int) cornerHeight;

@end

