//
//  FLObjcMethod.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/11/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcMethod.h"
#import "FLObjcTypeIndex.h"
#import "FLObjcName.h"
#import "FLObjcVariable.h"
#import "FLObjcStatement.h"
#import "FLObjcType.h"
#import "FLObjcObject.h"

#import "FLCodeMethod.h"
#import "FLCodeMethod+Additions.h"
#import "FLObjcTypeIndex.h"
#import "FLCodeCodeSnippet.h"

@implementation FLObjcMethod

@synthesize methodName = _methodName;
@synthesize returnType = _returnType;
@synthesize isPrivate = _isPrivate;
@synthesize isStatic = _isStatic;
@synthesize parentObject = _parentObject;
@synthesize statement = _statement;

- (id) initWithTypeIndex:(FLObjcTypeIndex*) index {	
	self = [super initWithTypeIndex:index];
	if(self) {
        _parameters = [[NSMutableArray alloc] init];
	    _statement = [[FLObjcBlockStatement alloc] init];
    }
	return self;
}

#if FL_MRC
- (void) dealloc {
    [_statement release];
    [_methodName release];
    [_returnType release];
    [_parameters release];
    [super dealloc];
}
#endif

+ (id) objcMethod:(FLObjcTypeIndex*) typeIndex {
    return FLAutorelease([[[self class] alloc] initWithTypeIndex:typeIndex]);
}

- (void) addParameter:(FLObjcParameter*) parameter {
    [_parameters addObject:parameter];
}

- (void) addStatement:(FLObjcStatement*) statement {
    if(!_statement) {
        _statement = [[FLObjcBlockStatement alloc] init];
    }
    [_statement addStatement:statement];
}

- (void) appendMethodDeclarationToCodeBuilder:(FLObjcCodeBuilder*) codeBuilder {
    [codeBuilder appendMethodDeclaration:self.methodName.generatedName type:self.returnType.generatedReference isInstanceMethod:![self isStatic]];
    
    for(int i = 0; i < _parameters.count; i++) {
        FLObjcParameter* param = [_parameters objectAtIndex:i];
    
        [codeBuilder appendMethodParameter:param.variableName.generatedName type:param.variableType.generatedReference key:param.key isFirst:(i == 0)];
    }
}

- (void) writeCodeToHeaderFile:(FLObjcFile*) file withCodeBuilder:(FLObjcCodeBuilder*) codeBuilder {
    if(!self.isPrivate) {
        [self appendMethodDeclarationToCodeBuilder:codeBuilder];
        [codeBuilder closeLineWithSemiColon];
    }
}

- (void) writeCodeToSourceFile:(FLObjcFile*) file withCodeBuilder:(FLObjcCodeBuilder*) codeBuilder {
    [self appendMethodDeclarationToCodeBuilder:codeBuilder];
    [codeBuilder appendString:@" "];
    if(_statement) {
        [_statement writeCodeToSourceFile:file withCodeBuilder:codeBuilder];
    }
}

- (void) configureWithCodeMethod:(FLCodeMethod*) codeMethod   {

    self.isPrivate = codeMethod.isPrivate;
    self.isStatic = codeMethod.isStatic;
    self.methodName = [FLObjcMethodName objcMethodName:codeMethod.name];
    if(codeMethod.hasLines) {
        FLObjcStringStatement* statement = [FLObjcStringStatement objcStringStatement];
        [statement.string appendLine:codeMethod.code.lines];
        [self addStatement:statement];
    }
    if(FLStringIsNotEmpty(codeMethod.returnType)) {
        self.returnType = [self.typeIndex objcTypeForTypeName:codeMethod.returnType];
    }
}

- (void) didMoveToObject:(FLObjcObject*) object {
    self.parentObject = object;
}


@end

@implementation FLObjcClassInitializerMethod

- (id) initWithTypeIndex:(FLObjcTypeIndex *)index {	
	self = [super initWithTypeIndex:index ];
	if(self) {
		
	}
	return self;
}

- (void) didMoveToObject:(FLObjcObject*) object {
    [super didMoveToObject:object];

    self.methodName = [FLObjcMethodName objcMethodName:self.parentObject.objectName.identifierName];
    self.returnType = self.parentObject.objectType;
    self.isStatic = YES;
    
    FLObjcStringStatement* statement = [FLObjcStringStatement objcStringStatement];
    [statement.string appendLine:@"return FLAutorelease([[[self class] alloc] init]);"];
    [self addStatement:statement];
    
//    [self.parentObject addDependency:self.ivar.variableType];
//    [self.parentObject addDependency:self.propertyType];
//    [self.parentObject addIvar:self.ivar];
//    
//    if(self.containerTypes && self.containerTypes.count) {
//        [self.parentObject addDependency:[self.typeIndex objcTypeForClass:[FLObjectDescriber class]]];
//     
//        for(FLObjcContainerSubType* subType in self.containerTypes) {
//            [self.parentObject addDependency:subType.objcType];
//        }
//    }    
    
}

@end

@interface FLObjcDeallocStatement : FLObjcStatement {
@private
    __unsafe_unretained FLObjcObject* _object;
}
@property (readwrite, assign, nonatomic) FLObjcObject* object;
@end

@implementation FLObjcDeallocStatement  
@synthesize object = object;

- (void) writeCodeToSourceFile:(FLObjcFile*) file withCodeBuilder:(FLObjcCodeBuilder*) codeBuilder  {
    for(FLObjcIvar* ivar in [self.object.ivars objectEnumerator]) {
        if(ivar.variableType.isObject) {
            [codeBuilder appendRelease:ivar.variableName.generatedName];
        }
    }
    [codeBuilder appendSuperDealloc];
}

@end

@implementation FLObjcDeallocMethod 

//+ (id) objcDeallocMethod {
//    return FLAutorelease([[[self class] alloc] init]);
//}

- (id) initWithTypeIndex:(FLObjcTypeIndex *)index {	
	self = [super initWithTypeIndex:index ];
	if(self) {
		_deallocStatement = [[FLObjcDeallocStatement alloc] init];
        self.methodName = [FLObjcMethodName objcMethodName:@"dealloc"];
        self.returnType = [FLObjcVoidType objcVoidType];
        self.isStatic = NO;
        self.isPrivate = YES;
        
        [self addStatement:_deallocStatement];
	}
	return self;
}

#if FL_MRC
- (void) dealloc {
	[_deallocStatement release];
    [super dealloc];
}
#endif

- (void) didMoveToObject:(FLObjcObject*) object {
    [super didMoveToObject:object];

    _deallocStatement.object = object;
}

- (void) writeCodeToSourceFile:(FLObjcFile*) file withCodeBuilder:(FLObjcCodeBuilder*) codeBuilder {

//    if(self.statement.statements.count == 0) {
    [codeBuilder appendPreprocessorIf:@"FL_MRC"];
    [super writeCodeToSourceFile:file withCodeBuilder:codeBuilder];
    [codeBuilder appendPreprocessorEndIf];
//    }
}


@end