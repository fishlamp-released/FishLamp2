//
//  FLObjcVariable.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 2/10/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcVariable.h"
#import "FLObjcObject.h"
#import "FLObjcName.h"
#import "FLObjcType.h"
#import "FLObjcRuntimeValue.h"
#import "FLObjcCodeBuilder.h"

@implementation FLObjcVariable
@synthesize variableName = _variableName;
@synthesize variableType = _variableType;
@synthesize runtimeValue = _runtimeValue;

- (id) initWithVariableName:(FLObjcName*) variableName variableType:(FLObjcType*) variableType {	
	self = [super init];
	if(self) {
		self.variableName = variableName;
        self.variableType = variableType;
	}
	return self;
}

#if FL_MRC
- (void) dealloc {
    [_runtimeValue release];
	[_variableName release];
    [_variableType release];
    [super dealloc];
}
#endif

- (NSString*) description {
    return [NSString stringWithFormat:@"%@, %@", self.variableName, self.variableType];
}


- (void) writeCodeToHeaderFile:(FLObjcFile*) file withCodeBuilder:(FLObjcCodeBuilder*) codeBuilder {
}
- (void) writeCodeToSourceFile:(FLObjcFile*) file withCodeBuilder:(FLObjcCodeBuilder*) codeBuilder {
}
@end

@implementation FLObjcLocalVariable

@end

@implementation FLObjcIvar

+ (id) objcIvar:(FLObjcName*) variableName ivarType:(FLObjcType*) variableType {
    return FLAutorelease([[[self class] alloc] initWithVariableName:variableName variableType:variableType]);
}

- (void) writeCodeToHeaderFile:(FLObjcFile*) file withCodeBuilder:(FLObjcCodeBuilder*) codeBuilder {
    [codeBuilder appendVariableDeclaration:self.variableType.generatedReference variableName:self.variableName.generatedName];
}

@end

@implementation FLObjcParameter
@synthesize key = _key;

- (id) initWithParameterName:(FLObjcName*) variableName parameterType:(FLObjcType*) parameterType key:(NSString*) key {
    self = [self initWithVariableName:variableName variableType:parameterType];
    if(self) {
        self.key = key;
    }   
    return self;
}

+ (id) objcParameter:(FLObjcName*) variableName parameterType:(FLObjcType*) parameterType key:(NSString*) key {
    return FLAutorelease([[[self class] alloc] initWithParameterName:variableName parameterType:parameterType key:key]);
}

#if FL_MRC
- (void) dealloc {
	[_key release];
	[super dealloc];
}
#endif

//- (void) writeCodeToHeaderFile:(FLObjcFile*) file withCodeBuilder:(FLObjcCodeBuilder*) codeBuilder {
//}
//- (void) writeCodeToSourceFile:(FLObjcFile*) file withCodeBuilder:(FLObjcCodeBuilder*) codeBuilder {
//}

@end
