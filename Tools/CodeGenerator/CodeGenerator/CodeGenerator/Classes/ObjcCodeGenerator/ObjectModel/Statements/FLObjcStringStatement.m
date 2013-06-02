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

@synthesize codeBuilder = _codeBulder;

- (id) init {	
	self = [super init];
	if(self) {
		_codeBulder = [[FLObjcCodeBuilder alloc] init];
	}
	return self;
}

#if FL_MRC
- (void) dealloc {
	[_codeBulder release];
	[super dealloc];
}
#endif

- (void) writeCodeToSourceFile:(FLObjcFile*) file 
               withCodeBuilder:(FLObjcCodeBuilder*) codeBuilder {
               
    [codeBuilder appendStringFormatter:_codeBulder];
}

+ (id) objcStringStatement {
    return FLAutorelease([[[self class] alloc] init]);
}


@end