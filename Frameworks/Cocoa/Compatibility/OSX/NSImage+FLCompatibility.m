//
//  SDKImage.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/13/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#if OSX
#import "NSImage+FLCompatibility.h"

@implementation NSImage (FLCompatibility)

- (id) initWithCGImage:(CGImageRef) image {
    NSSize size;
    size.height = CGImageGetHeight(image);
    size.width = CGImageGetWidth(image);
    return [self initWithCGImage:image size:size];
}

+ (SDKImage*) imageWithCGImage:(CGImageRef) image {
    return FLAutorelease([[[self class] alloc] initWithCGImage:image]);
}

- (CGImageRef) CGImage {
    return [self CGImageForProposedRect:nil context:nil hints:nil];
}

+ (id) imageWithData:(NSData*) data {
    return FLAutorelease([[[self class] alloc] initWithData:data]);
}

@end
#endif