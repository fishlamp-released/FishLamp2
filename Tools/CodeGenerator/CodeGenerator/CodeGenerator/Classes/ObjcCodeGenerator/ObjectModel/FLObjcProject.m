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
- (void) addKnownTypes;
@end

@implementation FLObjcProject
@synthesize fileManager = _fileManager;
@synthesize typeRegistry = _typeRegistry;
@synthesize inputProject = _inputProject;

- (id) init {	
	self = [super init];
	if(self) {
	}
	return self;
}

+ (id) objcProject {
    return FLAutorelease([[[self class] alloc] init]);
}

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

- (void) addTypesFromInputProject:(FLCodeProject*) project {
    
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
    
// we're adding REFERENCES to these only right now    
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



- (void) configureWithProjectInput:(FLCodeProject*) inputProject {

    self.inputProject = inputProject;

    self.fileManager = [FLObjcFileManager objcFileManager:self];
    self.typeRegistry  = [FLObjcTypeRegistry objcTypeRegistry];

    [self addKnownTypes];
    [self addTypesFromInputProject:inputProject];

    NSMutableArray* enums = [NSMutableArray array];
    for(FLCodeEnumType* codeEnum in inputProject.enumTypes) {
        FLAssert(codeEnum.enums.count > 0);
        
        FLObjcEnum* anEnum = [FLObjcEnum objcEnum:self];
        [anEnum configureWithCodeEnumType:codeEnum];
        [enums addObject:anEnum];
        
        [self.typeRegistry addType:anEnum.enumType];
        
        NSString* className = [NSString stringWithFormat:@"%@EnumSet", anEnum.enumType.generatedName];
        
        [self.typeRegistry addType:[FLObjcObjectType objcObjectType:[FLObjcImportedName objcImportedName:className] 
                                                 importFileName:[NSString stringWithFormat:@"%@.h", anEnum.enumType.generatedName]]];
    }
    [self.fileManager addFilesWithArrayOfCodeElements:enums];

    for(FLCodeObject* object in inputProject.objects) {
        FLObjcClassName* className = [FLObjcClassName objcClassName:object.className prefix:self.classPrefix];
        FLObjcType* forwardDecl = [FLObjcObjectType objcObjectType:className importFileName:[NSString stringWithFormat:@"%@.h", className.generatedName]];
        [self.typeRegistry replaceType:forwardDecl];
    }

    for(FLCodeArray* codeArray in inputProject.arrays) {
        FLObjcClassName* className = [FLObjcClassName objcClassName:codeArray.name prefix:self.classPrefix];
        FLObjcType* forwardDecl = [FLObjcArrayType objcArrayType:className importFileName:[NSString stringWithFormat:@"%@.h", className.generatedName]];
        [self.typeRegistry addType:forwardDecl];
    }


    NSMutableArray* objects = [NSMutableArray array];
    for(FLCodeObject* object in inputProject.objects) {
        FLObjcObject* objcObject = [FLObjcObject objcObject:self];
        [objcObject configureWithCodeObject:object];
        [objects addObject:objcObject];
    }

    [self.fileManager addFilesWithArrayOfCodeElements:objects];

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


#if FL_MRC
- (void) dealloc {
	[_inputProject release];
    [_fileManager release];
    
	[super dealloc];
}
#endif

@end
