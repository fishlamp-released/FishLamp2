//
//  FLReturnCodeLine.m
//  FishLampCodeGenerator
//
//  Created by Mike Fullerton on 6/15/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLReturnCodeLine.h"

@implementation FLReturnCodeLine

+ (id) returnCodeLine:(id) codeLine {
    return FLAutorelease([[[self class] alloc] initWithCodeLine:codeLine]);
}

@end
