//
//	GtCodeGeneratorCodeSnippetMore.h
//	PackMule
//
//	Created by Mike Fullerton on 4/18/10.
//	Copyright 2010 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GtObjectiveCCodeGenerator.h"

@interface GtCodeGeneratorCodeSnippet (More)

- (void) generate:(GtObjectiveCCodeGenerator*) generator
	object: (GtCodeGeneratorObject*) obj
	builder: (GtStringBuilder*) builder;

@end
