//
//  FLImage.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/25/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#if IOS

#define FLImage UIImage

#else

#define FLImage NSImage

@interface FLImage (FLCompatibility)
- (CGImageRef) CGImage;
- (id) initWithCGImage:(CGImageRef) image;
+ (FLImage*) imageWithCGImage:(CGImageRef) image;
@end

#endif
