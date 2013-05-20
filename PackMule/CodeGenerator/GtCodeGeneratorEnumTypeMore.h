//
//	GtCodeGeneratorEnumTypeMore.h
//	PackMule
//
//	Created by Mike Fullerton on 4/22/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GtCodeGeneratorEnumType.h"
#import "GtObjectiveCCodeGenerator.h"

@interface GtCodeGeneratorEnumType (More)

+ (void) generateEnumFiles:(GtObjectiveCCodeGenerator*) generator;

- (NSString*) fullyQualifiedName:(GtObjectiveCCodeGenerator*) generator;

+ (NSString*) toStringFromEnumFunctionName:(GtObjectiveCCodeGenerator*) generator typeName:(NSString*) typeName;
+ (NSString*) toEnumFromStringFunctionName:(GtObjectiveCCodeGenerator*) generator typeName:(NSString*) typeName;

+ (NSString*) lookupObjectNameFromGenerator:(GtObjectiveCCodeGenerator*) generator;

@end
