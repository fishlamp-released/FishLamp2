// FLImage+Alpha.h
// Created by Trevor Harmon on 9/20/09.
// Free for personal or commercial use, with or without modification.
// No warranty is expressed or implied.

#import "FLCore.h"
#import "FLImage.h"

// Helper methods for adding an alpha layer to an image
@interface FLImage (Alpha)
- (BOOL)hasAlpha;
- (FLImage *)imageWithAlpha;
- (FLImage *)transparentBorderImage:(NSUInteger)borderSize;
@end
