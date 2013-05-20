//
//	GtImageUtilities.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/21/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

// TODO: move to core?


@interface UIImage (Utils)
- (void) shrinkImage:(UIImage**) outImage maxLongSide:(float) maxLongSize makeSquare:(BOOL) makeSquare;
- (void) convertToJpegData:(CGFloat) compression outData:(NSData**) outData;

- (void) rotate90Degrees:(BOOL) clockWise 
	outImage:(UIImage**) outImage;

- (void) rotate:(CGFloat) degrees
	outImage:(UIImage**) outImage;

- (void) flip:(UIImage**) outImage;

+(UIImage *)makeRoundCornerImage : (UIImage*) img : (int) cornerWidth : (int) cornerHeight;

@end

