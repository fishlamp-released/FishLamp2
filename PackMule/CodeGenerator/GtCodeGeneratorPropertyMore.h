//
//	GtCodeGeneratorObjectPropertyMore.h
//	PackMule
//
//	Created by Mike Fullerton on 4/18/10.
//	Copyright 2010 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "GtCodeGeneratorProperty.h"

#import "GtObjectiveCCodeGenerator.h"

@interface GtCodeGeneratorProperty (More) 


- (NSString*) getterName;
- (NSString*) setterName;

- (BOOL) willLazyCreate:(GtCodeGenerator*) generator;
- (BOOL) canCreateMemberData:(GtCodeGenerator*) generator;


- (void) addVariablesToParentObject:(GtCodeGeneratorObject*) obj;
- (void) buildCode:(GtObjectiveCCodeGenerator*) generator object:(GtCodeGeneratorObject*) obj;

- (void) generateDeclaration:(GtObjectiveCCodeGenerator*) generator object:(GtCodeGeneratorObject*) obj builder:(GtStringBuilder*) builder;
- (void) generateSource:(GtObjectiveCCodeGenerator*) generator object:(GtCodeGeneratorObject*) obj builder:(GtStringBuilder*) builder;

- (BOOL) isValueProperty:(GtCodeGenerator*) codeGenerator;
- (BOOL) isEnumProperty:(GtCodeGenerator*) codeGenerator;
	
@end
