// [Generated]
//
// FLCodeObject.m
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//
// [/Generated]

#import "FLCodeObject+Additions.h"
#import "FLCodeMethod.h"
#import "FLCodeProperty.h"
#import "FLCodeObjectCategory.h"

@implementation FLCodeObject (Additions)

- (void) addMethods:(NSArray*) methodArray {
	NSMutableArray* newMethods = [NSMutableArray array];
	for(FLCodeMethod* method in methodArray) {
		BOOL foundIt = NO;
		for(FLCodeMethod* destMethod in self.methods) {
			if([destMethod.name isEqualToString:method.name]) {
				foundIt = YES;
				break;
			}
		}
		
		if(!foundIt) {
			[newMethods addObject:method];
		}
	}
	
	[self.methods addObjectsFromArray:newMethods];
}

- (void) addProperties:(NSArray*) propertyArray {

	for(FLCodeProperty* prop in propertyArray) {
		[self addProperty:prop];
	}
}

- (void) addProperty:(FLCodeProperty*) property {
       
    for(FLCodeProperty* destProp in self.properties) {
        if([destProp.name isEqualToString:property.name]) {
            return;
        }
    }        
        
    [self.properties addObject:property];
}

- (void) addMethod:(FLCodeMethod*) method {
    [self.methods addObject:method];
}

- (void) addCategory:(FLCodeObjectCategory*) category {
    [self.categories addObject:category];
}

- (void) addDependencyType:(FLCodeTypeDefinition*) def {
    [self.dependencies addObject:def];
}

- (void) addMember:(FLCodeVariable*) var {
    [self.members addObject:var];
}

- (void) addSourceSnippet:(FLCodeCodeSnippet*) code {
    [self.sourceSnippets addObject:code];
}

- (void) addInitLine:(NSString*) line {
    [self.linesForInitMethod addObject:line];
}




@end
