//
//  UIColor+FLUtils.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//
#import "FLCocoaRequired.h"
@interface UIImage (FLUtils)
- (void) shrinkImage:(UIImage**) outImage maxLongSide:(float) maxLongSize makeSquare:(BOOL) makeSquare;
- (void) convertToJpegData:(CGFloat) compression outData:(NSData**) outData;

- (void) rotate90Degrees:(BOOL) clockWise 
	outImage:(UIImage**) outImage;

- (void) rotate:(CGFloat) degrees
	outImage:(UIImage**) outImage;

- (void) flip:(UIImage**) outImage;

+(UIImage *)makeRoundCornerImage : (UIImage*) img : (int) cornerWidth : (int) cornerHeight;

@end

