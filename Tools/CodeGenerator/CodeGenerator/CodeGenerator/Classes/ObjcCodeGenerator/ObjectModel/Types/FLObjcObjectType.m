//
//  FLObjcObjectType.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/31/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcObjectType.h"

@implementation FLObjcObjectType

+ (id) objcObjectType:(FLObjcName*) typeName 
       importFileName:(NSString*) importFileName {

    return FLAutorelease([[[self class] alloc] initWithTypeName:typeName importFileName:importFileName]);
}

- (NSString*) generatedReference {
    return [NSString stringWithFormat:@"%@*", [super generatedReference]];
}

- (BOOL) isObject {
    return YES;
}

@end