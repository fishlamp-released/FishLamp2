//
//	FLImageUtilities.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/21/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

// TODO: move to core?


@interface CocoaImage (Utils)
- (void) shrinkImage:(CocoaImage**) outImage maxLongSide:(float) maxLongSize makeSquare:(BOOL) makeSquare;
- (void) convertToJpegData:(CGFloat) compression outData:(NSData**) outData;

- (void) rotate90Degrees:(BOOL) clockWise 
	outImage:(CocoaImage**) outImage;

- (void) rotate:(CGFloat) degrees
	outImage:(CocoaImage**) outImage;

- (void) flip:(CocoaImage**) outImage;

+(CocoaImage *)makeRoundCornerImage : (CocoaImage*) img : (int) cornerWidth : (int) cornerHeight;

@end

