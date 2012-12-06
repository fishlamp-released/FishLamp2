//
//  SDKImage.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FishLampCore.h"

#if IOS
#define SDKImage                    UIImage
#else
#define SDKImage                    NSImage
#endif

#if OSX
@interface NSImage (SDKCompatibility)
- (CGImageRef) CGImage;
- (id) initWithCGImage:(CGImageRef) image;
+ (NSImage*) imageWithCGImage:(CGImageRef) image;
+ (NSImage*) imageWithData:(NSData*) data;
@end
#endif
