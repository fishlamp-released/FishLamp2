//
//  GtImageUtilities.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/21/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#if IPHONE

@interface UIImage (Utils)
- (void) shrinkImage:(UIImage**) outImage  maxLongSide:(float) maxLongSize makeSquare:(BOOL) makeSquare;
- (void) convertToJpegData:(CGFloat) compression outData:(NSData**) outData;

- (void) resizeImageToMinimumSize:(CGSize) minSize;

- (void) rotate90Degrees:(BOOL) clockWise 
	outImage:(UIImage**) outImage;

- (void) rotate:(CGFloat) degrees
	outImage:(UIImage**) outImage;

- (void) flip:(UIImage**) outImage;

@end

#endif