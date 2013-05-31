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

- (void) addAdditionalStuffToObject:(FLObjcObject*) object forProperty:(FLObjcProperty*) property {
    
//    NSString* newName = [NSString stringWithFormat:@"%@AsEnum", property.propertyName.identifierName];
//    
//    FLObjcProperty* property = [FLObjcProperty objcProperty:object.typeIndex];
//    
//    property.propertyName = [[property propertyName] copyWithNewName:newName];
//    property.propertyType =
//    
//    [object addProperty:property];
//
//    
//    
    
    

}



@end
