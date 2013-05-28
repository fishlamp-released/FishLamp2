//
//  SDKColor+FLUtils.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/5/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#import "FLCocoaRequired.h"
@interface SDKImage (FLUtils)
- (void) shrinkImage:(SDKImage**) outImage maxLongSide:(float) maxLongSize makeSquare:(BOOL) makeSquare;
- (void) convertToJpegData:(CGFloat) compression outData:(NSData**) outData;

- (void) rotate90Degrees:(BOOL) clockWise 
	outImage:(SDKImage**) outImage;

- (void) rotate:(CGFloat) degrees
	outImage:(SDKImage**) outImage;

- (void) flip:(SDKImage**) outImage;

+(SDKImage *)makeRoundCornerImage : (SDKImage*) img : (int) cornerWidth : (int) cornerHeight;

@end

