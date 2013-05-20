//
//	GtObjectiveCCodeGenerator.m
//	PackMule
//
//	Created by Mike Fullerton on 4/17/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "GtObjectiveCCodeGenerator.h"
#import "GtStringUtilities.h"

#import "GtCodeGeneratorPropertyMore.h"
#import "GtCodeGeneratorMethodMore.h"
#import "GtCodeGeneratorObjectMore.h"
#import "GtCodeGeneratorEnumTypeMore.h"


@implementation GtObjectiveCCodeGenerator

- (NSString*) enumsHeaderFileName
{
	return [NSString stringWithFormat:@"%@Enums.h", self.schema.schemaName];
}

- (void) generateFileHeader:(GtStringBuilder*) builder 
				   fileName:(NSString*) fileName
				   disabled:(BOOL) disabled
				   generated:(BOOL) generated
{
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];

	[dateFormatter setDateStyle:kCFDateFormatterShortStyle];
	[dateFormatter setTimeStyle:kCFDateFormatterShortStyle];

	NSString *formattedDateString = [dateFormatter stringFromDate:[NSDate date]];
	
	if(generated)
	{
		[builder appendLineWithFormat:@"//\tThis file was generated at %@ by PackMule. DO NOT MODIFY!!", formattedDateString];
	}
	[builder appendLine:@"//"];
	[builder appendLineWithFormat:@"//\t%@", fileName];
	[builder appendLineWithFormat:@"//\tProject: %@", self.schema.projectName];
	[builder appendLineWithFormat:@"//\tSchema: %@", self.schema.schemaName];
	[builder appendLine:@"//"];
	[builder appendLineWithFormat:@"//\tCopywrite 2011 %@. All rights reserved.", self.schema.companyName];
	[builder appendLine:@"//"];
	[builder appendLine];
	
	if(self.schema.generatorOptions.disabled.boolValue || disabled)
	{
		[builder appendLine:@"#if DISABLED"];
	} 
}

- (void) generateFileFooter:(GtStringBuilder*) builder 
				   fileName:(NSString*) fileName
				   disabled:(BOOL) disabled
{
	if(self.schema.generatorOptions.disabled.boolValue || disabled)
	{
		[builder appendLine:@"#endif"];
	}
}

- (void) generateAllIncludesFile
{
	if(self.schema.generatorOptions.generateAllIncludesFile)
	{
		GtStringBuilder* builder = [GtStringBuilder stringBuilder];
		
		NSString* fileName = [NSString stringWithFormat:@"%@All.h", [self getTypeName:self.schema.schemaName]];
		
		[self generateFileHeader:builder fileName:fileName	disabled:NO generated:YES];
		
		for(GtCodeGeneratorObject* obj in self.schema.objects)
		{
			[builder appendLineWithFormat:@"#import \"%@\"", obj.headerFileName];
		}
		
		[self generateFileFooter:builder fileName:fileName	disabled:NO];
			
		GtCodeGeneratorFile* allFiles = [GtCodeGeneratorFile codeGeneratorFile];
		allFiles.name = fileName;
		allFiles.contents = [builder toString];
		[self.files addObject:allFiles];
	}
}

- (void) configureForCodeGeneration
{
	[GtCodeGeneratorEnumType generateEnumFiles:self];
	
	for(GtCodeGeneratorObject* obj in self.schema.objects)
	{
		[obj configure:self];
	}
	
}

- (void) generateCode
{
	for(GtCodeGeneratorObject* obj in self.schema.objects)
	{
		[obj generate:self];
	}
	
	[self generateAllIncludesFile];
}

- (NSString*) getTypeName:(NSString*) typeName
{
	if(!GtStringIsEmpty(self.schema.generatorOptions.typePrefix) &&
		[typeName rangeOfString:self.schema.generatorOptions.typePrefix].location != 0)
	{
		return [NSString stringWithFormat:@"%@%@", self.schema.generatorOptions.typePrefix, [typeName stringWithUpperCaseFirstLetter]];
	}
	
	return typeName;
}

+ (GtObjectiveCCodeGenerator*) objectiveCCodeGenerator
{
	return [[[GtObjectiveCCodeGenerator alloc] init] autorelease];
}				



@end
