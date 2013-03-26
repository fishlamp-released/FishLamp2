//
//  FLColorUtilities.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/13/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLColorUtilities.h"
#import "FLColorValues.h"



#if OSX
@implementation CIColor (FLColorConversions)
 -(CGColorRef) copyCGColorRef {
    CGColorSpaceRef colorSpace = [self colorSpace];
    const CGFloat *components = [self components];
    
    return CGColorCreate (colorSpace, components);
}
@end

@implementation NSColor (FLColorConversions)

- (CGColorRef) copyCGColorRef {
    return [FLAutorelease([[CIColor alloc] initWithColor: self]) copyCGColorRef];
}

+(NSColor *) colorWithCGColorRef: (CGColorRef) cgColor {
    return [NSColor colorWithCIColor: [CIColor colorWithCGColor: cgColor]];
}
@end
#endif



