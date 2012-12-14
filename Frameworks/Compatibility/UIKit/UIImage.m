//
//  UIImage.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/13/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "UIImage.h"


#if OSX
@implementation NSImage (UIKit)

- (id) initWithCGImage:(CGImageRef) image {
    NSSize size;
    size.height = CGImageGetHeight(image);
    size.width = CGImageGetWidth(image);
    return [self initWithCGImage:image size:size];
}

+ (UIImage*) imageWithCGImage:(CGImageRef) image {
    return FLAutorelease([[[self class] alloc] initWithCGImage:image]);
}

- (CGImageRef) CGImage {
FIXME("issues with context??")
    return nil;
}

+ (id) imageWithData:(NSData*) data {
    return FLAutorelease([[[self class] alloc] initWithData:data]);
}

@end
#endif