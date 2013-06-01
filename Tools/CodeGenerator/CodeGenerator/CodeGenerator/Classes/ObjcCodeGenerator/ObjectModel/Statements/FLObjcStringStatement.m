//
//  FLObjcStringStatement.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/31/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcStringStatement.h"
#import "FLCodeChunk.h"
#import "FLObjcCodeGeneratorHeaders.h"
#import "FLCodeLine.h"

@implementation FLObjcStringStatement
@synthesize string = _string;
- (id) init {	
	self = [super init];
	if(self) {
		_string = [[FLObjcCodeBuilder alloc] init];
	}
	return self;
}
#if FL_MRC
- (void) dealloc {
	[_string release];
	[super dealloc];
}
#endif

- (void) writeCodeToSourceFile:(FLObjcFile*) file 
               withCodeBuilder:(FLObjcCodeBuilder*) codeBuilder {
               
    [codeBuilder appendStringFormatter:_string];
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