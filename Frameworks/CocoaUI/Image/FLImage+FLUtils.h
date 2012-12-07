//
//  FLColor+FLUtils.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//
#import "FLImage.h"

@interface FLImage (FLUtils)
- (void) shrinkImage:(FLImage**) outImage maxLongSide:(float) maxLongSize makeSquare:(BOOL) makeSquare;
- (void) convertToJpegData:(CGFloat) compression outData:(NSData**) outData;

- (void) rotate90Degrees:(BOOL) clockWise 
	outImage:(FLImage**) outImage;

- (void) rotate:(CGFloat) degrees
	outImage:(FLImage**) outImage;

- (void) flip:(FLImage**) outImage;

+(FLImage *)makeRoundCornerImage : (FLImage*) img : (int) cornerWidth : (int) cornerHeight;

@end

