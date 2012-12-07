//
//  FLImage.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCore.h"

#if IOS
#define FLImage                    UIImage
#define NSImage                     UIImage
#else
#define FLImage                    NSImage
#define UIImage                     NSImage
#endif

#if OSX
@interface NSImage (FLCompatibility)
- (CGImageRef) CGImage;
- (id) initWithCGImage:(CGImageRef) image;
+ (NSImage*) imageWithCGImage:(CGImageRef) image;
+ (NSImage*) imageWithData:(NSData*) data;
@end
#endif
