//
//  FLObjcProject.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 6/1/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcProject.h"
#import "FLObjcCodeGeneratorHeaders.h"

#import "FLCodeProject.h"
#import "FLCodeMethod.h"
#import "FLCodeObject.h"
#import "FLCodeEnum.h"
#import "FLCodeProjectLocation.h"


@interface FLObjcProject ()
@property (readwrite, strong, nonatomic) FLObjcFileManager* fileManager;
@property (readwrite, strong, nonatomic) FLObjcTypeRegistry* typeRegistry;
@property (readwrite, strong, nonatomic) FLCodeProject* inputProject;

@property (readwrite, strong, nonatomic) FLObjcNamedObjectCollection* generatedEnums;
@property (readwrite, strong, nonatomic) FLObjcNamedObjectCollection* generatedObjects;

- (void) addKnownTypes;
@end

@implementation FLObjcProject
@synthesize fileManager = _fileManager;
@synthesize typeRegistry = _typeRegistry;
@synthesize inputProject = _inputProject;
@synthesize generatedObjects = _generatedObjects;
@synthesize generatedEnums = _generatedEnums;


- (id) init {	
	self = [super init];
	if(self) {
	}
	return self;
}

+ (id) objcProject {
    return FLAutorelease([[[self class] alloc] init]);
}

#if FL_MRC
- (void) dealloc {
	[_inputProject release];
    [_fileManager release];
    [_generatedObjects release];
    [_generatedEnums release];
    [_typeRegistry release];
	[super dealloc];
}
#endif

- (void) addKnownTypes {

    NSArray* knownTypes = [FLObjcKnownTypes loadKnownTypes];
    for(FLObjcType* type in knownTypes) {
        [self.typeRegistry addType:type];
    }
    
    NSDictionary* knownTypeAliases = [FLObjcKnownTypes knownTypeAliases];
    for(NSString* alias in knownTypeAliases) {
    
        FLObjcType* typeForAlias = [self.typeRegistry typeForKey:[knownTypeAliases objectForKey:alias]];
        
        [self.typeRegistry addAlias:alias forObjcName:typeForAlias.typeName];
    }

}

- (void) addForwardDeclarationsForTypesFromInputProject:(FLCodeProject*) project {

// we're adding REFERENCES to the enums and objects only right now    
// we're also doing a bit of error checking and preflighting the code generation
// we will replace these in the next step

    for(FLCodeTypeDefinition* def in project.typeDefinitions) {
    
        if(FLStringIsEmpty(def.typeName)) {
            FLThrowCodeGeneratorError(FLCodeGeneratorErrorCodeMissingName, @"Type definition does not have 'typeName'");
        }
    
        FLObjcImportedName* name = [FLObjcImportedName objcImportedName:def.typeName];
    
        switch(def.dataTypeAsEnum) {
            case FLCodeDataTypeObject:
                [self.typeRegistry addType:[FLObjcObjectType objcObjectType:name importFileName:def.import]];
            break;
            
            case FLCodeDataTypeValue:
                [self.typeRegistry addType:[FLObjcValueType objcValueType:name importFileName:def.import]];
            break;
            
            case FLCodeTypeEnum:
                [self.typeRegistry addType:[FLObjcEnumType objcEnumType:name importFileName:def.import]];
            break;
            
            case FLCodeDataTypeImmuteable:
                // not sure what this is
            break;
        }
    }
    
    NSString* prefix = [project.generatorOptions typePrefix];
    
	for(FLCodeEnumType* aEnum in project.enumTypes) {
        if(FLStringIsEmpty(aEnum.typeName)) {
            FLThrowCodeGeneratorError(FLCodeGeneratorErrorCodeMissingName, @"Enum does not have 'typeName'");
        }

        FLObjcEnumName* name = [FLObjcEnumName objcEnumName:aEnum.typeName prefix:prefix];
        [self.typeRegistry addType:[FLObjcEnumType objcEnumType:name importFileName:nil]];
	}   
    
    for(FLCodeObject* object in project.objects) {
        
        if(FLStringIsEmpty(object.className)) {
            FLThrowCodeGeneratorError(FLCodeGeneratorErrorCodeMissingName, @"Object does not have 'className'");
        }
    
        FLObjcClassName* name = [FLObjcClassName objcClassName:object.className prefix:prefix];
        [self.typeRegistry addType:[FLObjcObjectType objcObjectType:name importFileName:nil]];
    } 
}

- (void) generateEnums:(FLCodeProject*) inputProject {

//    FLLog(@"%@", self.typeRegistry);

// add generated enums.
// these need to come first because other objects need them to be in the registry
// when the objects themeselves are generated
    for(FLCodeEnumType* codeEnum in inputProject.enumTypes) {
        FLAssert(codeEnum.enums.count > 0);
        
        FLObjcEnum* anEnum = [FLObjcEnum objcEnum:self];
        [anEnum configureWithCodeEnumType:codeEnum];

        if([self.typeRegistry hasType:anEnum.enumType]) {
            [self.typeRegistry replaceType:anEnum.enumType];
        }
        else {
            [self.typeRegistry addType:anEnum.enumType];
        }

        [self.generatedEnums addObject:anEnum forObjcName:anEnum.enumName];

        NSString* className = [NSString stringWithFormat:@"%@EnumSet", anEnum.enumType.generatedName];
        
        [self.typeRegistry addType:[FLObjcObjectType objcObjectType:[FLObjcImportedName objcImportedName:className] 
                                                 importFileName:[NSString stringWithFormat:@"%@.h", anEnum.enumType.generatedName]]];
    }

}

- (void) updateTypeReferences:(FLCodeProject*) inputProject {
// update the objects with a input file name
    for(FLCodeObject* object in inputProject.objects) {
        FLObjcClassName* className = [FLObjcClassName objcClassName:object.className prefix:self.classPrefix];
        FLObjcType* forwardDecl = [FLObjcObjectType objcObjectType:className importFileName:[NSString stringWithFormat:@"%@.h", className.generatedName]];
        [self.typeRegistry replaceType:forwardDecl];
    }

// add arrays to type registry - these are placeholders - object will replace these with objc arrays
    for(FLCodeArray* codeArray in inputProject.arrays) {
        FLObjcClassName* className = [FLObjcClassName objcClassName:codeArray.name prefix:self.classPrefix];
        FLObjcType* forwardDecl = [FLObjcArrayType objcArrayType:className importFileName:[NSString stringWithFormat:@"%@.h", className.generatedName]];
        [self.typeRegistry addType:forwardDecl];
    }
}

- (void) generateObjects:(FLCodeProject*) inputProject {
// now actually generate the objects - now that all of the dependencies 
// and arrays and enums are ready to go.

    for(FLCodeObject* object in inputProject.objects) {
        FLObjcObject* objcObject = [FLObjcObject objcObject:self];
        [objcObject configureWithCodeObject:object];

        [self.generatedObjects addObject:objcObject forObjcName:objcObject.objectName];
    }

}


- (void) configureWithProjectInput:(FLCodeProject*) inputProject {

    self.inputProject = inputProject;

// create registries and lists of objects use by code generator
    self.fileManager = [FLObjcFileManager objcFileManager:self];
    self.typeRegistry  = [FLObjcTypeRegistry objcTypeRegistry];
    self.generatedObjects = [FLObjcNamedObjectCollection objcNamedObjectCollection];
    self.generatedEnums = [FLObjcNamedObjectCollection objcNamedObjectCollection];

// add all the known types (like NSObject, NSString, NSArray, etc..)
    [self addKnownTypes];
    
// add the types declared in the input project - this is adding placeholders to the type
// registry so we have all the types declared we need to generate all the objects    
    [self addForwardDeclarationsForTypesFromInputProject:inputProject];

    [self generateEnums:inputProject];

    [self updateTypeReferences:inputProject];

    [self generateObjects:inputProject];

// add the objects and enums to the file manager, who writes the files.
    [self.fileManager addFilesWithArrayOfCodeElements:self.generatedObjects.allValues];
    [self.fileManager addFilesWithArrayOfCodeElements:self.generatedEnums.allValues];

// add a all includes file if needed
    if(inputProject.generatorOptions.generateAllIncludesFile) {
        [self.fileManager addFile:[FLObjcAllIncludesHeaderFile allIncludesHeaderFile:self fileName:inputProject.schemaName]];
    }
}

- (FLCodeGeneratorResult*) generateFiles {
    return [self.fileManager writeFilesToDisk];
}

- (NSString*) classPrefix {
    return FLEmptyStringOrString(self.inputProject.generatorOptions.typePrefix);
}




@end
