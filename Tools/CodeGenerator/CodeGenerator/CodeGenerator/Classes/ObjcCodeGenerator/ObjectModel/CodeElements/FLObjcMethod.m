//
//  FLObjcMethod.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/11/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcMethod.h"

#import "FLObjcCodeGeneratorHeaders.h"

#import "FLCodeMethod.h"
#import "FLCodeMethod+Additions.h"
#import "FLCodeCodeSnippet.h"
#import "FLObjcBlockStatement.h"

@implementation FLObjcMethod

@synthesize methodName = _methodName;
@synthesize returnType = _returnType;
@synthesize isPrivate = _isPrivate;
@synthesize isStatic = _isStatic;
@synthesize parentObject = _parentObject;
@synthesize statement = _statement;

- (id) initWithProject:(FLObjcProject*) project {	
	self = [super initWithProject:project];
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

+ (id) objcMethod:(FLObjcProject*) project {
    return FLAutorelease([[[self class] alloc] initWithProject:project]);
}

- (void) addParameter:(FLObjcParameter*) parameter {
    FLConfirmWithComment([self parameterForName:parameter.variableName.identifierName] == nil, @"parameter for %@ already exists", parameter.variableName.identifierName);
    
    [_parameters addObject:parameter];
}

- (FLObjcParameter*) parameterForName:(NSString*) name {

    for(FLObjcParameter* parameter in _parameters) {
        if(FLStringsAreEqual(name, parameter.variableName.identifierName)) {
            return parameter;
        }
    }
    
    return nil;
}

- (void) replaceParameter:(FLObjcParameter*) oldParameter 
            withParameter:(FLObjcParameter*) newParameter {
            
    NSUInteger idx = [_parameters indexOfObject:oldParameter];
    if(idx != NSNotFound) {
        [_parameters replaceObjectAtIndex:idx withObject:newParameter];
    }
}

- (void) addOrReplaceParameter:(FLObjcParameter*) parameter {
    FLObjcParameter* oldParam = [self parameterForName:parameter.variableName.identifierName];
    if(oldParam) {
        [self replaceParameter:oldParam withParameter:parameter];
    }
    else {
        [self addParameter:parameter];
    }
}

- (void) removeParameter:(FLObjcParameter*) parameter {
    [_parameters removeObject:parameter];
}

- (void) addStatement:(FLObjcStatement*) statement {
    if(!_statement) {
        _statement = [[FLObjcBlockStatement alloc] init];
    }
    [_statement addStatement:statement];
}

- (void) appendMethodDeclarationToCodeBuilder:(FLObjcCodeBuilder*) codeBuilder {
    [codeBuilder appendMethodDeclaration:self.methodName.generatedName type:self.returnType.generatedReference isInstanceMethod:![self isStatic] closeLine:NO];
    
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
    FLObjcStringStatement* statement = [FLObjcStringStatement objcStringStatement];
    
    for(FLCodeLine* codeLine in codeMethod.codeLines) {
        [statement addCodeLine:codeLine withTypeRegistry:self.project];
    }
    
    [self addStatement:statement];

    if(FLStringIsNotEmpty(codeMethod.returnType)) {
        self.returnType = [self.project.typeRegistry typeForKey:codeMethod.returnType];
    }
}

- (void) didMoveToObject:(FLObjcObject*) object {
    self.parentObject = object;
}


@end




