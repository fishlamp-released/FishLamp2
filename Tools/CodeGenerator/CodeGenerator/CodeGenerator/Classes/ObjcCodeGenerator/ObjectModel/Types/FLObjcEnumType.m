//
//  FLObjcEnumType.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/31/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcEnumType.h"
#import "FLObjcCodeGeneratorHeaders.h"

@implementation FLObjcEnumType

+ (id) objcEnumType:(FLObjcName*) typeName 
       importFileName:(NSString*) importFileName {
    return FLAutorelease([[[self class] alloc] initWithTypeName:typeName importFileName:importFileName]);
}

- (void) objcObject:(FLObjcObject*) object didConfigureProperty:(FLObjcProperty *)property  {
    FLObjcEnum* theEnum = [object.project.generatedEnums objectForObjcName:property.propertyType.typeName];
    [theEnum objcObject:object didConfigureProperty:property];
}


- (NSString*) generatedReference {
    return @"NSString*";
}

- (BOOL) canForwardReference {
    return NO;
}

@end
