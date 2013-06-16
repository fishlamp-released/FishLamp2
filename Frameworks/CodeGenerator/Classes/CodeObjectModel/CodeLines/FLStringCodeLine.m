//
//  FLStringCodeLine.m
//  FishLampCodeGenerator
//
//  Created by Mike Fullerton on 6/15/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLStringCodeLine.h"

@implementation FLStringCodeLine

+ (id) stringCodeLine:(id) codeLine {
    return FLAutorelease([[[self class] alloc] initWithCodeLine:codeLine]);
}


@end
