//
//  FLObjcCodeElement.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/11/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcCodeElement.h"
#import "FLObjcTypeIndex.h"
#import "FLObjcCodeBuilder.h"
#import "FLObjcFile.h"

@implementation FLObjcCodeElement
@synthesize typeIndex = _typeIndex;

- (NSString*) generatedReference {
    return nil;
}

- (NSString*) generatedName {
    return nil;
}

- (id) init {	
	return [self initWithTypeIndex:nil];
}

- (id) initWithTypeIndex:(FLObjcTypeIndex*) index {	
    FLAssertNotNil(index);
	self = [super init];
	if(self) {
		_typeIndex = index;
	}
	return self;
}

- (void) writeCodeToHeaderFile:(FLObjcFile*) file withCodeBuilder:(FLObjcCodeBuilder*) codeBuilder {
}
- (void) writeCodeToSourceFile:(FLObjcFile*) file withCodeBuilder:(FLObjcCodeBuilder*) codeBuilder {
}

@end
