//
//  FLObjcStatement.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcStatement.h"
#import "FLObjcType.h"

@implementation FLObjcStatement
//+ (id) objcStatement:(FLObjcTypeIndex*) typeIndex {
//    return FLAutorelease([[[self class] alloc] initWithTypeIndex:typeIndex]);
//}
- (void) writeCodeToHeaderFile:(FLObjcFile*) file withCodeBuilder:(FLObjcCodeBuilder*) codeBuilder {
}

- (void) writeCodeToSourceFile:(FLObjcFile*) file withCodeBuilder:(FLObjcCodeBuilder*) codeBuilder {
}

@end

@implementation FLObjcReturnStatement
@synthesize returnValue = _returnValue;

- (id) initWithReturnValue:(FLObjcRuntimeValue*) returnValue {	
	self = [super init];
	if(self) {
		self.returnValue = returnValue;
	}
	return self;
}



+ (id) objcReturnStatement:(FLObjcRuntimeValue*) returnValue {
    return FLAutorelease([[[self class] alloc] initWithReturnValue:returnValue]);
}

#if FL_MRC
- (void) dealloc {
	[_returnValue release];
	[super dealloc];
}
#endif

@end

@implementation FLObjcBlockStatement

@synthesize statements = _statements;

- (id) init {	
	self = [super init];
	if(self) {
		_statements = [[NSMutableArray alloc] init];
	}
	return self;
}

+ (id) objcBlockStatement {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) writeCodeToSourceFile:(FLObjcFile*) file withCodeBuilder:(FLObjcCodeBuilder*) codeBuilder {

    [codeBuilder appendLine:@"{"];
    [codeBuilder indent:^{
        for(FLObjcStatement* statement in _statements) {
            [statement writeCodeToSourceFile:file withCodeBuilder:codeBuilder];
        }
    }];
    [codeBuilder appendLine:@"}"];
}

- (void) addStatement:(FLObjcStatement*) statement {
    [_statements addObject:statement];
}

#if FL_MRC
- (void) dealloc {
	[_statements release];
	[super dealloc];
}
#endif


@end

@implementation FLObjcStringStatement
@synthesize string = _string;
- (id) init {	
	self = [super init];
	if(self) {
		_string = [[FLCodeChunk alloc] init];
	}
	return self;
}
#if FL_MRC
- (void) dealloc {
	[_string release];
	[super dealloc];
}
#endif

- (void) writeCodeToSourceFile:(FLObjcFile*) file withCodeBuilder:(FLObjcCodeBuilder*) codeBuilder {
    [codeBuilder addCodeChunk:_string];
}

+ (id) objcStringStatement {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) addCodeLine:(FLCodeLine*) codeLine withTypeIndex:(FLObjcTypeIndex*) typeIndex {

    switch(codeLine.codeLineType) {
        case FLCodeLineTypeReturnNewObject:{
            FLObjcType* theType = [typeIndex objcTypeForTypeName:[codeLine parameterForKey:FLCodeLineClassName]];
            [self.string appendLineWithFormat:@"return FLAutorelease([[%@ alloc] init]);", theType.generatedName];
        }
        break;
        
        case FLCodeLineTypeReturnString:
            [self.string appendLineWithFormat:@"return @\"%@\";", [codeLine parameterForKey:FLCodeLineString]];
        break;
        
        default:
        break;
    
    }
}

@end