//
//  FLObjcEnumRegistry.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 6/1/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcEnumRegistry.h"
#import "FLObjcCodeGeneratorHeaders.h"

@implementation FLObjcEnumRegistry

+ (id) objcEnumRegistry {
    return FLAutorelease([[[self class] alloc] init]);
}

- (BOOL) hasEnum:(FLObjcEnum*) theEnum {
    return [self hasObjcName:theEnum.enumName];
}

- (void) addEnum:(FLObjcEnum*) theEnum {
    [self addObject:theEnum forObjcName:theEnum.enumName];
}

- (void) replaceEnum:(FLObjcEnum*) theEnum {
    [self replaceObject:theEnum forObjcName:theEnum.enumName];
}

- (id) enumForKey:(NSString*) key {
    return [self objectForKey:key];
}

- (id) enumForName:(FLObjcName*) name {
    return [self objectForObjcName:name];
}


@end
