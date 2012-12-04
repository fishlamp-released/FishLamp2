// UIImage+Alpha.h
// Created by Trevor Harmon on 9/20/09.
// Free for personal or commercial use, with or without modification.
// No warranty is expressed or implied.

#import "FLCore.h"
#import "FLCocoaCompatibility.h"
#import "FLGeometry.h"

// Helper methods for adding an alpha layer to an image
@interface UIImage_ (Alpha)
- (BOOL)hasAlpha;
- (UIImage_ *)imageWithAlpha;
- (UIImage_ *)transparentBorderImage:(NSUInteger)borderSize;
@end
