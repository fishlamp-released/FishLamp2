//
//  FLObjcProperty.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/11/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcProperty.h"
#import "FLObjcCodeGeneratorHeaders.h"

#import "FLCodeProperty.h"
#import "FLCodeArray.h"
#import "FLCodeArrayType.h"


@interface FLObjcProperty ()
@property (readwrite, strong, nonatomic) NSArray* containerTypes;
@end

@implementation FLObjcProperty
@synthesize ivar = _ivar;
@synthesize parentObject = _parentObject;
@synthesize containerTypes = _containerTypes;
@synthesize isReadOnly = _isReadOnly;
@synthesize isAtomic = _isAtomic;
@synthesize isImmutable = _isImmutable;
@synthesize useForEquality = _useForEquality;
@synthesize lazyCreate = _lazyCreate;

- (id) initWithTypeIndex:(FLObjcTypeIndex*) typeIndex {	
	self = [super initWithTypeIndex:typeIndex];
	if(self) {
		_setter = [[FLObjcMethod alloc] initWithTypeIndex:typeIndex];
        _setter.returnType = [typeIndex objcTypeForTypeName:@"void"];
		_getter = [[FLObjcMethod alloc] initWithTypeIndex:typeIndex];
	}
	return self;
}

#if FL_MRC
- (void) dealloc {
    [_containerTypes release];
    [_ivar release];
	[_getter release];
	[_setter release];
	[super dealloc];
}
#endif

- (FLObjcType*) propertyType {
    return _getter.returnType;
}

- (void) setPropertyType:(FLObjcType*) type {
    _getter.returnType = type;
    [_setter addOrReplaceParameter:[FLObjcParameter objcParameter:[FLObjcParameterName objcParameterName:@"value"] parameterType:type key:@"value"]];
}

- (FLObjcName*) propertyName {
    return _getter.methodName;
}

- (void) setPropertyName:(FLObjcName*) name {
    _getter.methodName = name;
    _setter.methodName = [NSString stringWithFormat:@"set%@", [name.generatedName stringWithUpperCaseFirstLetter]];
}

+ (id) objcProperty:(FLObjcTypeIndex*) typeIndex {
    return FLAutorelease([[[self class] alloc] initWithTypeIndex:typeIndex]);
}

#if DEBUG
- (void) setIsReadOnly:(BOOL) readonly {
    _isReadOnly = readonly;
    if(_isReadOnly) {
        FLAssertWithComment(_isImmutable == NO, @"can't have readwrite immutable property");
    }
}
#endif    

- (void) setIsImmutable:(BOOL) immutable {
    _isImmutable = immutable;
    if(_isImmutable) {
        _isReadOnly = YES;
    }
}

- (void) setIsStatic:(BOOL) isStatic {
    _getter.isStatic = isStatic;
    _setter.isStatic = isStatic;
}

- (BOOL) isStatic {
    return _getter.isStatic;
}

- (void) setIsPrivate:(BOOL) private {
    _getter.isPrivate = private;
}

- (BOOL) isPrivate {
    return _getter.isPrivate;
}

- (void) configureWithCodeProperty:(FLCodeProperty*) codeProperty {
    
    FLConfirmStringIsNotEmptyWithComment(codeProperty.type, @"code property '%@' type is nil", codeProperty.name);

    self.useForEquality = codeProperty.useForEquality;
    self.lazyCreate = codeProperty.canLazyCreate;
    self.isReadOnly = codeProperty.isReadOnly;
    self.isImmutable = codeProperty.isImmutable;
    self.isPrivate = codeProperty.isPrivate;
    self.isStatic = codeProperty.isStatic;
    self.propertyType = [self.typeIndex objcTypeForTypeName:[codeProperty type]];
    if(!self.isImmutable) {
        FLObjcIvarName* name = [FLObjcIvarName objcIvarName:[codeProperty name]];
        self.ivar = [FLObjcIvar objcIvar:name ivarType:self.propertyType];
    }
    self.propertyName = [FLObjcPropertyName objcPropertyName:[codeProperty name]];

    if(codeProperty.arrayTypes && codeProperty.arrayTypes.count) {
        NSMutableArray* containerTypes = [[NSMutableArray alloc] init];
    
        FLAssert([self.propertyType isKindOfClass:[FLObjcContainerType class]]);
        
        for(FLCodeArrayType* codeArrayType in codeProperty.arrayTypes) {
            FLObjcType* typeForSubType = [self.typeIndex objcTypeForTypeName:[codeArrayType typeName]];
            [containerTypes addObject:[FLObjcContainerSubType objcContainerSubType:codeArrayType.name objcType:typeForSubType]];
        }
        
        self.containerTypes = containerTypes;
    }
        
    if(codeProperty.defaultValue) {
        FLObjcStringStatement* stringStatement = [FLObjcStringStatement objcStringStatement];
        [stringStatement addCodeLine:codeProperty.defaultValue withTypeIndex:self.typeIndex];
        [_getter addStatement:stringStatement];
    }
}


- (NSString*) description {
    return [NSString stringWithFormat:@"%@ -> ivar %@", self.propertyName, [self.ivar description]];
}

- (void) didMoveToObject:(FLObjcObject*) object {
    self.parentObject = object;
    
    if(self.ivar) {
        [self.parentObject addDependency:self.ivar.variableType];
        [self.parentObject addIvar:self.ivar];
    }
    
    [self.parentObject addDependency:self.propertyType];
    
    if(self.containerTypes && self.containerTypes.count) {
        [self.parentObject addDependency:[self.typeIndex objcTypeForClass:[FLObjectDescriber class]]];
     
        for(FLObjcContainerSubType* subType in self.containerTypes) {
            [self.parentObject addDependency:subType.objcType];
        }
    }
}

- (void) writeCodeToHeaderFile:(FLObjcFile*) file withCodeBuilder:(FLObjcCodeBuilder*) codeBuilder {
//    [codeBuilder appendVariableDeclaration:self.type.generatedString name:self.name.generatedString];
    
    if([self isPrivate]) {
        return;
    }
    if([self isStatic]) {
        [_getter writeCodeToHeaderFile:file withCodeBuilder:codeBuilder];
        [_setter writeCodeToHeaderFile:file withCodeBuilder:codeBuilder];
    }
    else {
        FLObjcPropertyTypeEnum ownership = FLObjcPropertyTypeAssign;
        if(self.propertyType.isObject) {
            ownership = FLObjcPropertyTypeStrong;
        }

        [codeBuilder appendPropertyDeclaration:self.propertyName.generatedName 
                                          type:self.propertyType.generatedReference 
                                        atomic:NO 
                                     ownership:ownership 
                                     readwrite:![self isReadOnly] 
                                  customGetter:nil 
                                  customSetter:nil];
    }
}

- (void) writeCodeToSourceFile:(FLObjcFile*) file withCodeBuilder:(FLObjcCodeBuilder*) codeBuilder {
    
    if([self isStatic]) {
        [_getter writeCodeToSourceFile:file withCodeBuilder:codeBuilder];
        [_setter writeCodeToSourceFile:file withCodeBuilder:codeBuilder];
    }
    else if(self.isImmutable)  {
        [_getter writeCodeToSourceFile:file withCodeBuilder:codeBuilder];
    }
    else {
        if(self.lazyCreate) {
            FLConfirmNotNilWithComment(self.ivar, @"lazy properties must have an ivar");
        
            [codeBuilder appendLineWithFormat:@"FLSynthesizeLazyGetter(%@, %@, %@);", 
                self.propertyName.generatedReference, 
                self.propertyType.generatedReference, 
                self.ivar.variableName];
        }
        
        [codeBuilder appendSynthesize:self.propertyName.generatedReference ivarName:self.ivar.variableName.generatedName];
    }
}

@end
