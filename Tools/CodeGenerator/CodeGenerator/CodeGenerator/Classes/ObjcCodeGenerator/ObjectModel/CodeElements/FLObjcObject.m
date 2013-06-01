//
//  FLObjcObject.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/11/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcObject.h"
#import "FLObjcCodeGeneratorHeaders.h"

#import "FLCodeObject.h"
#import "FLCodeStorageOptions.h"

@interface FLObjcObject ()
@property (readwrite, strong, nonatomic) FLCodeObject* codeObject;
//@property (readwrite, strong, nonatomic) FLCodeObject* codeObject;
@end

@implementation FLObjcObject 

@synthesize superclassType = _superclassType;
@synthesize objectName = _objectName;
@synthesize codeObject = _codeObject;
@synthesize ivars = _ivars;
@synthesize objectType = _objectType;
@synthesize properties = _properties;

- (id) initWithProject:(FLObjcProject*) project {	
	self = [super initWithProject:project];
	if(self) {
        _ivars = [[FLObjcNamedObjectCollection alloc] init];
        _properties = [[FLObjcNamedObjectCollection alloc] init];
        _methods = [[NSMutableArray alloc] init];
        _dependencies = [[NSMutableSet alloc] init];

	}
	return self;
}

+ (id) objcObject:(FLObjcProject*) project {
    return FLAutorelease([[[self class] alloc] initWithProject:project]);
}

- (BOOL) isObject {
    return YES;
}


- (NSString*) generatedName {
    return self.objectName.generatedName;
}

- (NSString*) generatedReference {
    return self.objectType.generatedReference;

//    return [NSString stringWithFormat:@"%@*", self.typeName];
}


- (NSString*) importFileName {
    return [NSString stringWithFormat:@"%@.h", self.generatedName];
}

- (void) addIvar:(FLObjcIvar*) ivar {
    [_ivars addObject:ivar forObjcName:ivar.variableName];
}

- (void) addProperty:(FLObjcProperty*) property {
    [_properties addObject:property forObjcName:property.propertyName];
    [property didMoveToObject:self];
}

- (void) addDependency:(FLObjcType*) type {

    [_dependencies addObject:type.typeName.identifierName];

//    [_dependencies addObject:type.iden];
}

- (void) addMethod:(FLObjcMethod*) method {
    [_methods addObject:method];
    [method didMoveToObject:self];
}

- (void) addProtocol:(FLObjcType*) type {
    if(!_protocols) {
        _protocols = [[NSMutableArray alloc] init];
    }
    [_protocols addObject:type];
    [self addDependency:type];

}

#if FL_MRC
- (void) dealloc {
    [_protocols release];
    [_codeObject release];
	[_superclass release];
    [_objectName release];
    [_ivars release];
    [_properties release];
    [_methods release];
    [_dependencies release];
    [super dealloc];
}
#endif

- (NSString*) storageMaskForStorageOptions:(FLCodeStorageOptions*) option {
	NSMutableString* storageMask = [NSMutableString string];

	if(!option.isStorable) {
		[storageMask appendString:@"FLStorageAttributeNotStored"];
	}
	else {
		[storageMask appendString:@"FLStorageAttributeStored"];
	}
	
    if(option.isPrimaryKey) {
		[storageMask appendString:@"|FLStorageAttributePrimaryKey"];
	}
	
    if(option.isIndexed) {
		[storageMask appendString:@"|FLStorageAttributeIndexed"];
	}
	
    if(option.isRequired) {
		[storageMask appendString:@"|FLStorageAttributeRequired"];
	}
	
    if(option.isUnique) {
		[storageMask appendString:@"|FLStorageAttributeUnique"];
	}
	
	return storageMask;
}


- (void) configureWithCodeObject:(FLCodeObject*) codeObject {
    
    if(FLStringIsNotEmpty(codeObject.protocols)) {
        NSArray* protocols = [[codeObject protocols] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" ,"] allowEmptyStrings:NO];

        for(NSString* protocol in protocols) {
            FLObjcType* type = [self.project.typeRegistry typeForKey:protocol];
            [self addProtocol:type];
        }
    }
    
    self.codeObject = codeObject;
    
    FLObjcType* superclass = nil;
    if(FLStringIsNotEmpty(codeObject.superclass)) {
        superclass = [self.project.typeRegistry typeForKey:codeObject.superclass];
    }
    else {
        superclass = [self.project.typeRegistry typeForKey:NSStringFromClass([FLModelObject class])];
    }
   
    [self addDependency:superclass];
   
    self.objectName = 
        [FLObjcClassName objcClassName:codeObject.className prefix:self.project.classPrefix];
    
    self.objectType = [FLObjcObjectType objcObjectType:self.objectName importFileName:[NSString stringWithFormat:@"%@.h", self.objectName.generatedName]];
    
    self.superclassType = superclass;
    self.codeObject = codeObject;
    
    for(FLCodeProperty* codeProp in codeObject.properties) {
    
        FLObjcProperty* prop = [FLObjcProperty objcProperty:self.project];
        [prop configureWithCodeProperty:codeProp];
        [self addProperty:prop];
        
        [self addDependency:prop.propertyType];
    }

    NSArray* copyOfProperties = FLCopyWithAutorelease([self.properties allValues]);
    for(FLObjcProperty* objcProp in copyOfProperties) {
        [[objcProp propertyType] addAdditionalStuffToObject:self forProperty:objcProp withTypeRegistry:self.project];
    }
    
    for(FLCodeMethod* method in codeObject.methods) {
        FLObjcMethod* objcMethod = [FLObjcMethod objcMethod:self.project];
        [objcMethod configureWithCodeMethod:method];
        [self addMethod:objcMethod];

        [self addDependency:objcMethod.returnType];

    }
    
    [self addMethod:[FLObjcDidRegisterObjectDescriberMethod objcDidRegisterObjectDescriberMethod:self.project]];
    [self addMethod:[FLObjcClassInitializerMethod objcMethod:self.project]];
    [self addMethod:[FLObjcDeallocMethod objcMethod:self.project]];
}

- (NSString*) description {
    FLPrettyString* string = [FLPrettyString prettyString];
    [string appendLineWithFormat:@"classType: %@, superclass:%@",  [self.objectName description], [self.superclassType description]];
    
    [string appendLine:@"properties:"];
    [string indent: ^{
        for(FLObjcProperty* prop in [_properties objectEnumerator]) {
            [string appendLine:[prop description]];
        }
    }];
    [string appendLine:@"ivars:"];
    [string indent: ^{
        for(FLObjcIvar* ivar in [_ivars objectEnumerator]) {
            [string appendLine:[ivar description]];
        }
    }];
    [string appendLine:@"dependencies:"];
    [string indent: ^{
        for(NSString* type in _dependencies) {
            [string appendLine:type];
        }
    }];
    
    return string.string;
}

- (void) writeCodeToHeaderFile:(FLObjcFile*) file withCodeBuilder:(FLObjcCodeBuilder*) codeBuilder {
    
    FLObjcType* superclass = self.superclassType;
    
    if(FLStringIsNotEmpty(superclass.importFileName)) {
        [codeBuilder appendImport:superclass.importFileName];
    }
    
    for(NSString* dependencyName in _dependencies) {
        FLObjcType* dependency = [self.project.typeRegistry typeForKey:dependencyName];
        if(dependency == superclass) {
            continue;
        }
        
        if(FLStringIsNotEmpty(dependency.importFileName)) {
            if(dependency.isObject) {
                [codeBuilder appendClassDeclaration:dependency.generatedName];
            }
            else {
                [codeBuilder appendImport:dependency.importFileName];
            }
        }
    }
    
    NSMutableArray* protocols = nil;
    if(_protocols) {
        protocols = [NSMutableArray array];
        
        for(FLObjcType* type in _protocols) {
            [protocols addObject:type.generatedName];
        }
    }
    
    [codeBuilder appendInterfaceDeclaration:self.objectName.generatedName 
                                 superClass:self.superclassType.generatedName 
                                  protocols:protocols 
                   appendMemberDeclarations:^{
    
        for(FLObjcIvar* ivar in [_ivars objectEnumerator]) {
            [ivar writeCodeToHeaderFile:file withCodeBuilder:codeBuilder];
        }
    }];

    for(FLObjcProperty* prop in [_properties objectEnumerator]) {
        [prop writeCodeToHeaderFile:file withCodeBuilder:codeBuilder];
    }

    for(FLObjcMethod* method in _methods) {
        [method writeCodeToHeaderFile:file withCodeBuilder:codeBuilder];
    }

    [codeBuilder appendEnd];
}

- (void) writeCodeToSourceFile:(FLObjcFile*) file withCodeBuilder:(FLObjcCodeBuilder*) codeBuilder {

    [codeBuilder appendImport:file.counterPartFileName];
    
    for(NSString* dependencyName in _dependencies) {
        FLObjcType* dependency = [self.project.typeRegistry typeForKey:dependencyName];

        if(FLStringIsNotEmpty(dependency.importFileName)) {
            [codeBuilder appendImport:dependency.importFileName];
        }
    }
    
    [codeBuilder appendImplementation:self.objectName.generatedName];

    for(FLObjcProperty* prop in [_properties objectEnumerator]) {
        [prop writeCodeToSourceFile:file withCodeBuilder:codeBuilder];
    }

    for(FLObjcMethod* method in _methods) {
        [method writeCodeToSourceFile:file withCodeBuilder:codeBuilder];
    }

    [codeBuilder appendEnd];
}



@end
