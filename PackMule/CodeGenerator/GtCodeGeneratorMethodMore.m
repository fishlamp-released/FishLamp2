//
//	GtCodeGeneratorMethodMore.m
//	PackMule
//
//	Created by Mike Fullerton on 4/18/10.
//	Copyright 2010 Greentongue Software. All rights reserved.
//

#import "GtCodeGeneratorMethodMore.h"
#import "GtCodeGeneratorCodeSnippetMore.h"


@implementation GtCodeGeneratorMethod (More)

- (void) generateSource:(GtObjectiveCCodeGenerator*) generator object:(GtCodeGeneratorObject*) obj builder:(GtStringBuilder*) builder
{
	[builder appendLine];
	if(GtStringIsNotEmpty(self.comment))
	{
		[builder appendLineWithFormat:@"// %@", self.comment];
	}
	self.code.scopedBy = [self declaration:generator];
	[self.code generate:generator object:obj builder:builder];
}

- (void) generateDeclaration:(GtObjectiveCCodeGenerator*) generator object:(GtCodeGeneratorObject*) obj builder:(GtStringBuilder*) builder
{
	if(!self.isPrivate.boolValue)
	{
		[builder appendLine];
		[builder appendLineWithFormat:@"%@; %@", [self declaration:generator], GtStringIsNotEmpty(self.comment) ? [NSString stringWithFormat:@"// %@", self.comment] : @""];
	}
}

- (NSString*) declaration:(GtObjectiveCCodeGenerator*) generator
{
	FailIfStringIsEmpty(self.name, @"method has no name");

	NSMutableString* string = [NSMutableString string];
	
	[string appendFormat:@"%@ (%@) %@", 
		self.isStatic.boolValue ? @"+" : @"-", 
		GtStringIsEmpty(self.returnType) ? @"void" : [generator typeStringForGeneratedCode:self.returnType],
		self.name];
		
	if(self.parameters && self.parameters.count > 0)
	{	
		int count = 0;
		for(GtCodeGeneratorVariable* type in self.parameters)
		{
			FailIfStringIsEmpty(type.name, @"name missing");
			FailIfStringIsEmpty(type.typeName, @"type missing");
			if(count++ == 0)
			{
				[string appendFormat:@":(%@) %@", [generator typeStringForGeneratedCode:type.typeName], type.name];
			}
			else
			{
				[string appendFormat:@" %@:(%@) %@", type.name, [generator typeStringForGeneratedCode:type.typeName], type.name];
			}
		}
	}
		
	return string;
}

- (BOOL) hasLines
{
	return self.code.lines.length > 0;
}
@end
