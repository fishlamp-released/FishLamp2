//
//  FLObjcEnum.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/13/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcEnum.h"
#import "FLObjcCodeGeneratorHeaders.h"

#import "FLCodeEnumType.h"
#import "FLCodeEnum.h"

#import "FLTypeSpecificEnumSet.h"

@implementation FLObjcEnum
@synthesize enumType = _enumType;
@synthesize enumValues = _enumValues;
@synthesize enumName = _enumName;

- (id) initWithProject:(FLObjcProject*) project {	
	self = [super initWithProject:project];
	if(self) {
		_enumValues = [[NSMutableArray alloc] init];
        _defines = [[NSMutableDictionary alloc] init];
	}
	return self;
}


#if FL_MRC
- (void) dealloc {
    [_enumName release];
    [_enumType release];
    [_enumValues release];
    [_defines release];
	[super dealloc];
}
#endif


+ (id) objcEnum:(FLObjcProject*) project {
    return FLAutorelease([[[self class] alloc] initWithProject:project]);
}

- (void) addValue:(FLObjcEnumValueType*) enumValueType {
    [_enumValues addObject:enumValueType];
}


- (void) configureWithCodeEnumType:(FLCodeEnumType*) codeEnumType  {
    
    self.enumName = [FLObjcEnumName objcEnumName:codeEnumType.typeName prefix:self.project.classPrefix];

    self.enumType = [FLObjcEnumType objcEnumType:self.enumName importFileName:[NSString stringWithFormat:@"%@.h", self.enumName.generatedName]];
    
    NSInteger counter = -1;
    for(FLCodeEnum* aEnum in codeEnumType.enums) {
    
        FLObjcEnumValueName* name = [FLObjcEnumValueName objcEnumValueName:aEnum.name prefix:self.enumName.generatedName];
    
        [_defines setObject:aEnum.name forKey:name.generatedName];
    
        NSString* value = nil;
        if(aEnum.value != 0) {
            value = aEnum.value;
        }
        else {
            value = ++counter;
        }
    
        FLObjcEnumValueType* enumValue = [FLObjcEnumValueType objcEnumValue:name value:value]; 
        [self addValue:enumValue];
    }
}

- (NSString*) generatedName {
    return self.enumName.generatedName;
}

- (NSString*) generatedReference {
    return self.enumType.generatedReference;
}

- (void) describeSelf:(FLPrettyString*) string {
    [string appendLineWithFormat:@"enumName = %@", self.enumName];
    [string appendLineWithFormat:@"enumType = %@", self.enumType];
    [string appendInScope:@"values {" closeScope:@"}" withBlock:^{
        for(id obj in _enumValues) {
            [string appendLine:[obj description]];
        }
    }];
}

- (NSString*) description {
    return [self prettyDescription];
}

- (NSString*) enumSetClassName {
    return  [NSString stringWithFormat:@"%@EnumSet", self.generatedName];
}

- (NSString*) stringFromEnumFunctionName {
    return [NSString stringWithFormat:@"%@StringFromEnum", self.generatedName];
}

- (NSString*) enumFromStringFunctionName {
    return [NSString stringWithFormat:@"%@EnumFromString", self.generatedName];
}

- (NSString*) stringFromEnumFunctionPrototype {
    return [NSString stringWithFormat:@"NSString* %@(%@ theEnum)", self.stringFromEnumFunctionName, self.generatedName];
}

- (NSString*) enumFromStringFunctionPrototype {
    return [NSString stringWithFormat:@"%@ %@(NSString* theString)", self.generatedName, self.enumFromStringFunctionName];
}


- (void) writeCodeToHeaderFile:(FLObjcFile*) file 
    withCodeBuilder:(FLObjcCodeBuilder*) codeBuilder {
    
    [codeBuilder appendImport:NSStringFromClass([FLTypeSpecificEnumSet class])];
    [codeBuilder appendBlankLine];

// define typedefs    
    [codeBuilder appendLine:@"typedef enum {"];
    [codeBuilder indent:^{
        for(FLObjcEnumValueType* value in _enumValues) {
            [codeBuilder appendLineWithFormat:@"%@ = %ld,", value.generatedName, value.enumValue];
         
        } 
    }];
    [codeBuilder appendLineWithFormat:@"} %@;", self.generatedName];
    
    [codeBuilder appendBlankLine];
    for(NSString* define in _defines) {
        [codeBuilder appendDefine:[NSString stringWithFormat:@"k%@", define] stringValue:[_defines objectForKey:define]];
    }
    [codeBuilder appendBlankLine];

// external conversion functions
    [codeBuilder appendLineWithFormat:@"extern %@;", self.stringFromEnumFunctionPrototype];
    [codeBuilder appendLineWithFormat:@"extern %@;", self.enumFromStringFunctionPrototype];
    [codeBuilder appendBlankLine];

// interface def for enumSet object
    [codeBuilder appendInterfaceDeclaration:self.enumSetClassName
                                 superClass:NSStringFromClass([FLTypeSpecificEnumSet class]) 
                                  protocols:nil appendMemberDeclarations:nil];

    [codeBuilder appendMethodDeclaration:@"enumSet" type:@"id" isInstanceMethod:NO closeLine:YES];
    [codeBuilder appendMethodDeclaration:@"enumSet:(NSString*) concatenatedEnumString" type:@"id" isInstanceMethod:NO closeLine:YES];
    
    [codeBuilder appendEnd];
}

- (void) writeCodeToSourceFile:(FLObjcFile*) file 
               withCodeBuilder:(FLObjcCodeBuilder*) codeBuilder {

    [codeBuilder appendImport:self.enumType.generatedName];
    [codeBuilder appendBlankLine];
               
// string from enum function               
    [codeBuilder appendLineWithFormat:@"%@ {", self.stringFromEnumFunctionPrototype];
    [codeBuilder indent: ^{
        [codeBuilder appendSwitchBlock:@"theEnum" caseStatements:^{
            for(NSString* define in _defines) {
                [codeBuilder appendCaseStatement:define statement:^{
                    [codeBuilder appendReturnValue:[NSString stringWithFormat:@"k%@", define]];
                }];
            }
        }];
        
        [codeBuilder appendReturnValue:@"nil"];
    }];
    [codeBuilder appendLine:@"}"];
    [codeBuilder appendBlankLine];

// enum from string function
    [codeBuilder appendLineWithFormat:@"%@ {", self.enumFromStringFunctionPrototype];
    [codeBuilder indent: ^{
        [codeBuilder appendStaticVariable:@"NSDictionary*" name:@"s_enumLookup" initialValue:@"nil"];
        [codeBuilder appendRunOnceBlock:@"s_lookupPredicate" block:^{
            [codeBuilder appendLineWithFormat:@"s_enumLookup = [[NSDictionary alloc] initWithObjectsAndKeys:"];
            [codeBuilder indent:^{
                for(NSString* define in _defines) {
                    [codeBuilder appendLineWithFormat:@"[NSNumber numberWithInteger:%@], [k%@ lowercaseString],", define, define]; 
                }
                
                [codeBuilder appendLine:@"nil ];"];
            }];
        
        }];

        [codeBuilder appendLineWithFormat:@"NSNumber* value = [s_enumLookup objectForKey:[theString lowercaseString]];"];
        [codeBuilder appendReturnValue:@"value == nil ? NSNotFound : [value integerValue]"];
        
    }];
    [codeBuilder appendLine:@"}"];
               
    [codeBuilder appendBlankLine];

// enumSet factory class implementation        
    [codeBuilder appendImplementation:self.enumSetClassName];
    [codeBuilder appendMethodDeclaration:@"enumSet" type:@"id" isInstanceMethod:NO closeLine:NO];
    [codeBuilder scope:^{
        [codeBuilder appendReturnValue:[NSString stringWithFormat:@"FLAutorelease([[[self class] alloc] initWithValueLookup:(FLEnumSetEnumValueLookup*)  %@EnumFromString stringLookup:(FLEnumSetEnumStringLookup*) %@StringFromEnum])", self.enumType.generatedName, self.enumType.generatedName]];
    }];

    [codeBuilder appendMethodDeclaration:@"enumSet:(NSString*) concatenatedEnumString " type:@"id" isInstanceMethod:NO closeLine:NO];
    [codeBuilder scope:^{
        [codeBuilder appendLineWithFormat:@"%@* outObject = FLAutorelease([[[self class] alloc] initWithValueLookup:(FLEnumSetEnumValueLookup*)  %@ stringLookup:(FLEnumSetEnumStringLookup*) %@]);",    
                self.enumSetClassName,
                self.enumFromStringFunctionName, 
                self.stringFromEnumFunctionName];
        
        [codeBuilder appendLine:@"[outObject setConcatenatedString:concatenatedEnumString];"];
        [codeBuilder appendReturnValue:@"outObject"];
    }];

    [codeBuilder appendEnd];
}



- (void) addEnumPropertyToObject:(FLObjcObject*) object withProperty:(FLObjcProperty*) property {
    FLObjcCustomProperty* newProperty = [FLObjcCustomProperty objcCustomProperty:object.project];
    NSString* newName = [NSString stringWithFormat:@"%@Enum", property.propertyName.generatedName];
    
    newProperty.propertyName = FLAutorelease([[property propertyName] copyWithNewName:newName]);
    
    newProperty.propertyType = [FLObjcValueType objcValueType:[FLObjcImportedName objcImportedName:self.generatedName] importFileName:nil];
    
    [object addProperty:newProperty];
    
    [newProperty.getter.code appendReturnValue:[NSString stringWithFormat:@"%@(self.%@)", 
        [self enumFromStringFunctionName], 
        property.propertyName.generatedName]];


    [newProperty.setter.code appendAssignment:[NSString stringWithFormat:@"%@(value)", self.stringFromEnumFunctionName]
        to:[NSString stringWithFormat:@"self.%@", property.propertyName.generatedName]]; 


}

- (void) addEnumSetPropertyToObject:(FLObjcObject*) object withProperty:(FLObjcProperty*) property {
    FLObjcCustomProperty* newProperty = [FLObjcCustomProperty objcCustomProperty:object.project];
    
    FLObjcName* name = [[property propertyName] copyWithNewName:[NSString stringWithFormat:@"%@EnumSet", property.propertyName.generatedName]];
    newProperty.propertyName = FLAutorelease(name);
    
    newProperty.propertyType = [FLObjcImmutableObjectType objcImmutableObjectType:[FLObjcImportedName objcImportedName:self.enumSetClassName] importFileName:nil];
    
    [object addProperty:newProperty];

    [newProperty.getter.code appendReturnValue:[NSString stringWithFormat:@"[%@ enumSet:self.%@];", 
        self.enumSetClassName, 
        property.propertyName.generatedName]];


    [newProperty.setter.code appendAssignment:@"value.concatenatedString"
        to:[NSString stringWithFormat:@"self.%@", property.propertyName.generatedName]]; 

}

- (void) objcObject:(FLObjcObject*) object didConfigureProperty:(FLObjcProperty *)property  {
    [self addEnumPropertyToObject:object withProperty:property];
    [self addEnumSetPropertyToObject:object withProperty:property];
}

- (FLObjcFile*) headerFile {
    FLObjcFile* file = [FLObjcGeneratedHeaderFile headerFile:self.generatedName];
    file.folder = self.project.inputProject.options.userObjectsFolderName;
    
    [file addFileElement:[self generatedFileHeader]];
    [file addFileElement:self];
    return file;
}

- (FLObjcFile*) sourceFile {
    FLObjcFile* file = [FLObjcGeneratedSourceFile sourceFile:self.generatedName];;
    file.folder = self.project.inputProject.options.userObjectsFolderName;

    [file addFileElement:[self generatedFileHeader]];
    [file addFileElement:self];
    return file;
}

@end

