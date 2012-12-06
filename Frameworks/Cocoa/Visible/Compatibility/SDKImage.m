//
//  SDKImage.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "SDKImage.h"

#if OSX
@implementation NSImage (SDKCompatibility)

- (id) initWithCGImage:(CGImageRef) image {
    NSSize size;
    size.height = CGImageGetHeight(image);
    size.width = CGImageGetWidth(image);
    return [self initWithCGImage:image size:size];
}

+ (SDKImage*) imageWithCGImage:(CGImageRef) image {
    return autorelease_([[[self class] alloc] initWithCGImage:image]);
}

- (CGImageRef) CGImage {
FIXME("issues with context??")
    return nil;
}

+ (id) imageWithData:(NSData*) data {
    return autorelease_([[[self class] alloc] initWithData:data]);
}

@end
#endif