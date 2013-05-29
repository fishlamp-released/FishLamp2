//
//  FLObjcProperty.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/11/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcProperty.h"
#import "FLObjcVariable.h"
#import "FLObjcObject.h"
#import "FLCodeProperty.h"
#import "FLObjcName.h"
#import "FLObjcVariable.h"
#import "FLObjcType.h"
#import "FLObjcTypeIndex.h"
#import "FLCodeArray.h"
#import "FLCodeArrayType.h"
#import "FLObjcCodeBuilder.h"

@interface FLObjcProperty ()
@property (readwrite, strong, nonatomic) FLCodeProperty* codeProperty;
@property (readwrite, strong, nonatomic) NSArray* containerTypes;
@end

@implementation FLObjcProperty
@synthesize propertyName = _propertyName;
@synthesize ivar = _ivar;
@synthesize parentObject = _parentObject;
@synthesize codeProperty = _codeProperty;
@synthesize propertyType = _propertyType;
@synthesize containerTypes = _containerTypes;

+ (id) objcProperty:(FLObjcTypeIndex*) typeIndex {
    return FLAutorelease([[[self class] alloc] initWithTypeIndex:typeIndex]);
}

- (void) configureWithCodeProperty:(FLCodeProperty*) codeProperty {
    
    FLConfirmStringIsNotEmptyWithComment(codeProperty.type, @"code property '%@' type is nil", codeProperty.name);

    self.codeProperty = codeProperty;

    self.propertyType = [self.typeIndex objcTypeForTypeName:[codeProperty type]];
    
    if(codeProperty.arrayTypes && codeProperty.arrayTypes.count) {
        NSMutableArray* containerTypes = [[NSMutableArray alloc] init];
    
        FLAssert([self.propertyType isKindOfClass:[FLObjcContainerType class]]);
        
        for(FLCodeArrayType* codeArrayType in codeProperty.arrayTypes) {
            FLObjcType* typeForSubType = [self.typeIndex objcTypeForTypeName:[codeArrayType typeName]];
            [containerTypes addObject:[FLObjcContainerSubType objcContainerSubType:codeArrayType.name objcType:typeForSubType]];
        }
        
        self.containerTypes = containerTypes;
    }
    
    FLObjcIvarName* name = [FLObjcIvarName objcIvarName:[codeProperty name]];
        
    self.ivar = [FLObjcIvar objcIvar:name ivarType:self.propertyType];
    self.propertyName = [FLObjcPropertyName objcPropertyName:[codeProperty name]];
}

#if FL_MRC
- (void) dealloc {
    [_containerTypes release];
    [_propertyType release];
    [_codeProperty release];
	[_propertyName release];
    [_ivar release];
    [super dealloc];
}
#endif

- (NSString*) description {
    return [NSString stringWithFormat:@"%@ -> ivar %@", self.propertyName, [self.ivar description]];
}

- (void) didMoveToObject:(FLObjcObject*) object {
    self.parentObject = object;
    
    [self.parentObject addDependency:self.ivar.variableType];
    [self.parentObject addDependency:self.propertyType];
    [self.parentObject addIvar:self.ivar];
    
    if(self.containerTypes && self.containerTypes.count) {
        [self.parentObject addDependency:[self.typeIndex objcTypeForClass:[FLObjectDescriber class]]];
     
        for(FLObjcContainerSubType* subType in self.containerTypes) {
            [self.parentObject addDependency:subType.objcType];
        }
    }
    
}

- (void) writeCodeToHeaderFile:(FLObjcFile*) file withCodeBuilder:(FLObjcCodeBuilder*) codeBuilder {
//    [codeBuilder appendVariableDeclaration:self.type.generatedString name:self.name.generatedString];
    
    if([self.codeProperty isPrivate]) {
        return;
    }
    if([self.codeProperty isStatic]) {
    
    }
    else {
        FLObjcPropertyTypeEnum ownership = FLObjcPropertyTypeAssign;
        if(self.ivar.variableType.isObject) {
            ownership = FLObjcPropertyTypeStrong;
        }

        [codeBuilder appendPropertyDeclaration:self.propertyName.generatedName 
                                          type:self.ivar.variableType.generatedReference 
                                        atomic:NO 
                                     ownership:ownership 
                                     readwrite:![self.codeProperty isReadOnly] 
                                  customGetter:nil 
                                  customSetter:nil];
    }

}

- (void) writeCodeToSourceFile:(FLObjcFile*) file withCodeBuilder:(FLObjcCodeBuilder*) codeBuilder {
    
    if([self.codeProperty isStatic]) {
    
    }
    else {
        [codeBuilder appendSynthesize:self.propertyName.generatedReference ivarName:self.ivar.variableName.generatedName];
    }
}

@end
