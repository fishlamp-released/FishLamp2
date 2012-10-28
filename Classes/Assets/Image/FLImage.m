//
//  FLImage.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/25/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLImage.h"

#if !IOS

@implementation FLImage (FLCompatibility)

- (id) initWithCGImage:(CGImageRef) image {

    return nil;
}

+ (FLImage*) imageWithCGImage:(CGImageRef) image {

    return nil;
}

- (CGImageRef) CGImage {

    return nil;
}

@end
#endif