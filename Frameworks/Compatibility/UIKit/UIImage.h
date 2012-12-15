//
//  UIImage.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/13/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "UIKitRequired.h"

#if OSX

#define UIImage NSImage

@interface NSImage (UIKit)
- (CGImageRef) CGImage;
- (id) initWithCGImage:(CGImageRef) image;
+ (NSImage*) imageWithCGImage:(CGImageRef) image;
+ (NSImage*) imageWithData:(NSData*) data;
@end

#endif

