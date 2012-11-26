// FLImage+RoundedCorner.h
// Created by Trevor Harmon on 9/20/09.
// Free for personal or commercial use, with or without modification.
// No warranty is expressed or implied.

// Extends the FLImage class to support making rounded corners
#import "FLCore.h"
#import "FLImage.h"
#import "FLGeometry.h"

@interface FLImage (RoundedCorner)
- (FLImage *)roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize;
@end
