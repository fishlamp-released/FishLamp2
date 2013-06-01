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
    
//    {
//    FLObjcCustomProperty* newProperty = [FLObjcCustomProperty objcCustomProperty:object.typeIndex];
//    NSString* newName = [NSString stringWithFormat:@"%@Enum", property.propertyName.generatedName];
//    newProperty.propertyName = [[property propertyName] copyWithNewName:newName];
//    newProperty.propertyType = [FLObjcValueType objcValueType:[FLObjcImportedName objcImportedName:self.generatedName] importFileName:nil];
//    [object addProperty:newProperty];
//    
//    FLDocumentBuilder* 
//    
//    FLObjcStringStatement* getter = [FLObjcStringStatement objcStringStatement];
//    
//    
//    
//    newProperty.getter.statement
//    
//    }
//    
//    {
//    FLObjcCustomProperty* newProperty2 = [FLObjcCustomProperty objcCustomProperty:object.typeIndex];
//    NSString* newName2 = [NSString stringWithFormat:@"%@EnumSet", property.propertyName.generatedName];
//    newProperty2.propertyName = [[property propertyName] copyWithNewName:newName2];
//    newProperty2.propertyType = [FLObjcObjectType objcObjectType:[FLObjcImportedName objcImportedName:[NSString stringWithFormat:@"%@EnumSet", self.generatedName]] importFileName:nil];
//    [object addProperty:newProperty2];
//    }


}


- (NSString*) generatedReference {
    return @"NSString*";
}


@end
