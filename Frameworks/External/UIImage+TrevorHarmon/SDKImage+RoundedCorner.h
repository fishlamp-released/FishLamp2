// SDKImage+RoundedCorner.h
// Created by Trevor Harmon on 9/20/09.
// Free for personal or commercial use, with or without modification.
// No warranty is expressed or implied.

// Extends the SDKImage class to support making rounded corners
#import "FLCore.h"
#import "FLGeometry.h"
#import "SDKImage.h"

@interface SDKImage (RoundedCorner)
- (SDKImage *)roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize;
@end
