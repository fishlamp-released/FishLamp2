// [Generated]
//
// FLCodeObject.h
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//
// [/Generated]

#import "FLCodeObject.h"

@interface FLCodeObject (Additions)

- (void) addProperties:(NSArray*) propertyArray;

- (void) addMethods:(NSArray*) methodArray;

- (void) addProperty:(FLCodeProperty*) property;

- (void) addMethod:(FLCodeMethod*) method;

- (void) addCategory:(FLCodeObjectCategory*) category;

- (void) addDependencyType:(FLCodeTypeDefinition*) def;

- (void) addMember:(FLCodeVariable*) var ;

- (void) addSourceSnippet:(FLCodeCodeSnippet*) code;

- (void) addInitLine:(NSString*) line;

@end
