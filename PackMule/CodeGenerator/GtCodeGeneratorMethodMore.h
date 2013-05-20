//
//	GtCodeGeneratorMethodMore.h
//	PackMule
//
//	Created by Mike Fullerton on 4/18/10.
//	Copyright 2010 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GtObjectiveCCodeGenerator.h"

@interface GtCodeGeneratorMethod (More)

- (NSString*) declaration:(GtObjectiveCCodeGenerator*) generator;

- (void) generateDeclaration:(GtObjectiveCCodeGenerator*) generator object:(GtCodeGeneratorObject*) obj builder:(GtStringBuilder*) builder;
- (void) generateSource:(GtObjectiveCCodeGenerator*) generator object:(GtCodeGeneratorObject*) obj builder:(GtStringBuilder*) builder ;
	
@property (readonly, assign, nonatomic) BOOL hasLines;	
	
@end
