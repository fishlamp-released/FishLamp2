//
//  FLObjcTypeIndex.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/13/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcTypeIndex.h"
#import "FLObjcKnownTypes.h"

#import "FLObjcType.h"
#import "FLObjcNamedObjectCollection.h"
#import "FLObjcObject.h"
#import "FLObjcFileHeader.h"
#import "FLObjcName.h"
#import "FLObjcEnum.h"

#import "FLCodeProject.h"
#import "FLCodeDataTypeCollection.h"
#import "FLCodeEnumType.h"
#import "FLCodeTypeDefinition.h"
#import "FLCodeGeneratorOptions.h"
#import "FLCodeObject.h"
#import "FLCodeMethod.h"
#import "FLCodeGeneratorErrors.h"

@interface FLObjcTypeIndex ()
@property (readwrite, strong, nonatomic) NSDictionary* parseableTypes;
@property (readwrite, strong, nonatomic) FLCodeProject* project;
- (void) addKnownTypes;
- (void) addTypesFromProject;
@end

@implementation FLObjcTypeIndex
@synthesize parseableTypes = _parseableTypes;
@synthesize project = _project;

- (id) initWithCodeProject:(FLCodeProject*) project {	
	self = [super init];
	if(self) {
        _typeIndex = [[FLObjcNamedObjectCollection alloc] init];
    
		self.project = project;
        [self addKnownTypes];
        [self addTypesFromProject];
	}
	return self;
}

+ (id) objcTypeIndex:(FLCodeProject*) codeProject {
    return FLAutorelease([[[self class] alloc] initWithCodeProject:codeProject]);
}

- (NSString*) classPrefix {
    return FLEmptyStringOrString(self.project.generatorOptions.typePrefix);
}

- (void) setObjcType:(FLObjcType*) type {
    [_typeIndex setObject:type forKey:type.typeName];
}

- (FLObjcType*) objcTypeForTypeName:(NSString*) typeName {
   typeName = [typeName stringByReplacingOccurrencesOfString:@"*" withString:@""];
   
   FLObjcType* type = [_typeIndex objectForKey:typeName];
   if(type == nil) {
        NSString* newType = [_parseableTypes objectForKey:[typeName lowercaseString]];
        if(newType) {
            type = [_typeIndex objectForKey:newType];
        }
   }
   
   if(!type) {
        FLThrowCodeGeneratorError(FLCodeGeneratorErrorCodeUnknownType, @"Unknown type \"%@\"", typeName);
   }
   
   return type;
}

- (FLObjcType*) objcTypeForClass:(Class) aClass {
    return [self objcTypeForTypeName:NSStringFromClass(aClass)];
}

- (void) addKnownTypes {
    self.parseableTypes = [FLObjcKnownTypes parseableTypes];

    NSArray* knownTypes = [FLObjcKnownTypes loadKnownTypes];
    for(FLObjcType* type in knownTypes) {
        [self setObjcType:type];
    }
}

- (void) addTypesFromProject {

    for(FLCodeTypeDefinition* def in self.project.typeDefinitions) {
    
        if(FLStringIsEmpty(def.typeName)) {
            FLThrowCodeGeneratorError(FLCodeGeneratorErrorCodeMissingName, @"Type definition does not have 'typeName'");
        }
    
        FLObjcImportedName* name = [FLObjcImportedName objcImportedName:def.typeName];
    
        switch(def.dataTypeAsEnum) {
            case FLCodeDataTypeObject:
                [self setObjcType:[FLObjcObjectType objcObjectType:name importFileName:def.import]];
            break;
            
            case FLCodeDataTypeValue:
                [self setObjcType:[FLObjcValueType objcValueType:name importFileName:def.import]];
            break;
            
            case FLCodeTypeEnum:
                [self setObjcType:[FLObjcEnumType objcEnumType:name importFileName:def.import]];
            break;
            
            case FLCodeDataTypeImmuteable:
                // not sure what this is
            break;
        }
    }
    
    NSString* prefix = [self classPrefix];
    
// we're adding REFERENCES to these only right now    
	for(FLCodeEnumType* aEnum in self.project.enumTypes) {
        if(FLStringIsEmpty(aEnum.typeName)) {
            FLThrowCodeGeneratorError(FLCodeGeneratorErrorCodeMissingName, @"Enum does not have 'typeName'");
        }

        FLObjcEnumName* name = [FLObjcEnumName objcEnumName:aEnum.typeName prefix:prefix];
        [self setObjcType:[FLObjcEnumType objcEnumType:name importFileName:nil]];
	}   
    for(FLCodeObject* object in self.project.objects) {
        
        if(FLStringIsEmpty(object.className)) {
            FLThrowCodeGeneratorError(FLCodeGeneratorErrorCodeMissingName, @"Object does not have 'className'");
        }
    
        FLObjcClassName* name = [FLObjcClassName objcClassName:object.className prefix:prefix];
        [self setObjcType:[FLObjcObjectType objcObjectType:name importFileName:nil]];
    } 
}



#if FL_MRC
- (void) dealloc {
    [_typeIndex release];
    [_project release];
	[_parseableTypes release];
	[super dealloc];
}
#endif

@end
