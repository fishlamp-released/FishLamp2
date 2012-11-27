//
//  FLOSXCompatibility.m
//  Downloader
//
//  Created by Mike Fullerton on 11/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLOSXCompatibility.h"

#if OSX
@implementation NSImage_ (FLCompatibility)

- (id) initWithCGImage:(CGImageRef) image {
    NSSize size;
    size.height = CGImageGetHeight(image);
    size.width = CGImageGetWidth(image);
    return [self initWithCGImage:image size:size];
}

+ (NSImage_*) imageWithCGImage:(CGImageRef) image {
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