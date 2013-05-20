//
//	GtCodeGeneratorEnumTypeMore.m
//	PackMule
//
//	Created by Mike Fullerton on 4/22/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "GtCodeGeneratorEnumTypeMore.h"
#import "GtObjectiveCCodeGenerator.h"
#import "GtCodeGeneratorEnum.h"

@interface GtCodeGeneratorEnum (More)
- (NSString*) fullyQualifiedName:(NSString*) parentName;
@end

@implementation GtCodeGeneratorEnum (More)

- (NSString*) fullyQualifiedName:(NSString*) parentName
{
	return [NSString stringWithFormat:@"%@%@", parentName, self.name];
}

@end

@implementation GtCodeGeneratorEnumType (More)

+ (NSString*) cleanName:(NSString*) name generator:(GtObjectiveCCodeGenerator*) generator
{
	NSString* prefix = generator.schema.generatorOptions.typePrefix;
	if(GtStringIsEmpty(prefix))
	{
		return name;
	}
	
	return [name substringFromIndex:[name rangeOfString:prefix].length];
}

+ (NSString*) toStringFromEnumFunctionName:(GtObjectiveCCodeGenerator*) generator typeName:(NSString*) typeName
{
	return [NSString stringWithFormat:@"stringFrom%@", [[GtCodeGeneratorEnumType cleanName:typeName generator:generator] stringWithUpperCaseFirstLetter]];
}

+ (NSString*) toEnumFromStringFunctionName:(GtObjectiveCCodeGenerator*) generator typeName:(NSString*) typeName
{
	return [NSString stringWithFormat:@"%@FromString", [[GtCodeGeneratorEnumType cleanName:typeName generator:generator] stringWithLowercaseFirstLetter]];
}

+ (GtCodeGeneratorFile*) generateEnumHeaderFile:(GtObjectiveCCodeGenerator*) generator
{
	GtStringBuilder* builder = [GtStringBuilder stringBuilder];
	
	NSString* fileName = generator.enumsHeaderFileName;
	[generator generateFileHeader:builder fileName:fileName disabled:NO generated:YES];

	for(GtCodeGeneratorDefine* define in generator.schema.defines)
	{
		[builder appendLineWithFormat:@"#define %@ %@ %@",	
			define.define, 
			define.isString.boolValue ? [NSString stringWithFormat:@"@\"%@\"", define.value] : define.value, 
			GtStringIsNotEmpty(define.comment) ? [NSString stringWithFormat:@"// %@", define.comment] : @""];
	}
	
	if(generator.schema.enumTypes.count)
	{
		[builder appendLine];

		for(GtCodeGeneratorEnumType* anEnumType in generator.schema.enumTypes)
		{
			NSString* typeName = [generator getTypeName:anEnumType.typeName];
		
			for(GtCodeGeneratorEnum* anEnum in anEnumType.enums)
			{
				NSString* enumName = [anEnum fullyQualifiedName:typeName];
				
				if(GtStringIsNotEmpty(anEnum.stringValue))
				{
					[builder appendLineWithFormat:@"#define k%@ @\"%@\"",  enumName, anEnum.stringValue];
				}
				else
				{
					[builder appendLineWithFormat:@"#define k%@ @\"%@\"",  enumName, anEnum.name];
				}
			}
		}

		[builder appendLine];
		
		NSString* objName  = [GtCodeGeneratorEnumType lookupObjectNameFromGenerator:generator];

		GtStringBuilder* lookupObj = [GtStringBuilder stringBuilder];
		[lookupObj appendLineWithFormat:@"@interface %@ : NSObject {", objName];
		[lookupObj appendLineWithFormat:@"\tNSDictionary* m_strings;"];
		[lookupObj appendLineWithFormat:@"}"];
		[lookupObj appendLineWithFormat:@"GtSingletonProperty(%@);", objName];
		
		for(GtCodeGeneratorEnumType* anEnumType in generator.schema.enumTypes)
		{
			NSString* typeName = [generator getTypeName:anEnumType.typeName];
		
			if(anEnumType.enums.count > 0)
			{
				[builder appendLineWithFormat:@"typedef enum {"];
			
				[builder tabIn];
				for(GtCodeGeneratorEnum* anEnum in anEnumType.enums)
				{
					if(anEnum.value)
					{
						[builder appendLineWithFormat:@"%@ = %d,", [anEnum fullyQualifiedName:typeName], anEnum.value];
					}
					else
					{
						[builder appendLineWithFormat:@"%@,", [anEnum fullyQualifiedName:typeName]];
					}
				}
				[builder tabOut];
			
				[builder appendLineWithFormat:@"} %@;", typeName];
				[builder appendLine:@""];
								
				GtCodeGeneratorTypeDefinition* type = [generator typeForName:typeName];
				type.import = fileName;
				
//				[GtCodeGeneratorTypeDefinition codeGeneratorTypeDefinition];
//				type.typeName = typeName;
//				type.dataType = @"enum";
//				type.import = fileName;
//				[generator.schema.typeDefinitions addObject:type];
								
								
				[lookupObj appendLine:@""];
				[lookupObj appendLineWithFormat:@"- (NSString*) %@:(%@) inEnum;", [GtCodeGeneratorEnumType toStringFromEnumFunctionName:generator typeName:typeName], typeName ];
				[lookupObj appendLineWithFormat:@"- (%@) %@:(NSString*) inString;", typeName, [GtCodeGeneratorEnumType toEnumFromStringFunctionName:generator typeName:typeName]];
				
				
//				[builder appendLineWithFormat:@"extern NSString* StringFrom%@(%@ inEnum);", [typeName stringWithUpperCaseFirstLetter], typeName];
//				[builder appendLineWithFormat:@"extern %@ %@FromString(NSString* inString);", 
//					typeName, [typeName stringWithUpperCaseFirstLetter]];
//				[builder appendLine:@""];
			}
		}
		
		[builder appendLine];
		[lookupObj appendLine:@"@end"];
		[builder appendLines:[lookupObj toString] trimWhitespace:NO];
	}	 
	
	
	
	[generator generateFileFooter:builder fileName:fileName	 disabled:NO];

	GtCodeGeneratorFile* enumsFile = [GtCodeGeneratorFile codeGeneratorFile];
	enumsFile.name = fileName;
	enumsFile.contents = [builder toString];
	[generator.files addObject:enumsFile];
	
	return enumsFile;
}

- (NSString*) fullyQualifiedName:(GtObjectiveCCodeGenerator*) generator
{
	return [generator getTypeName:self.typeName];
}

+ (NSString*) enumFromStringFunctionName:(GtObjectiveCCodeGenerator*) generator
{
	return [NSString stringWithFormat:@"_%@EnumFromString", generator.schema.schemaName];
}

+ (NSString*) lookupObjectNameFromGenerator:(GtObjectiveCCodeGenerator*) generator
{
	return [NSString stringWithFormat:@"%@EnumLookup", [generator getTypeName:generator.schema.schemaName]];
}

+ (void) generateEnumLookups:(GtObjectiveCCodeGenerator*) generator builder:(GtStringBuilder*) builder
{
	NSString* objName  = [GtCodeGeneratorEnumType lookupObjectNameFromGenerator:generator];
	[builder appendLineWithFormat:@"@implementation %@", objName];
	[builder appendLineWithFormat:@"GtSynthesizeSingleton(%@);", objName];
	
	[builder appendLineWithFormat:@"- (id) init {"];
	[builder tabIn];
				
	[builder appendLineWithFormat:@"if((self = [super init])) {"];
	[builder tabIn];
				
	[builder appendLineWithFormat:@"m_strings = [[NSDictionary alloc] initWithObjectsAndKeys:"];

	for(GtCodeGeneratorEnumType* anEnumType in generator.schema.enumTypes)
	{
		NSString* typeName = [generator getTypeName:anEnumType.typeName];
	
		for(GtCodeGeneratorEnum* anEnum in anEnumType.enums)
		{
			NSString* enumName = [anEnum fullyQualifiedName:typeName];
			
			// STORE kBlah here
			[builder tabIn];
			[builder appendLineWithFormat:@"[NSNumber numberWithInt:%@], k%@, ",  enumName, enumName];
			[builder tabOut];
	
		}
	}
	[builder appendLineWithFormat:@" nil];"];
	[builder tabOut];
		
	[builder appendLineWithFormat:@"}"];

	[builder appendLineWithFormat:@"return self;"];
	[builder tabOut];
	[builder appendLineWithFormat:@"}"];
	
	[builder appendLine:@""];
	[builder appendLineWithFormat:@"- (NSInteger) lookupString:(NSString*) inString {"];
	[builder tabIn];
	[builder appendLineWithFormat:@"NSNumber* num = [m_strings objectForKey:inString];"];
	[builder appendLineWithFormat:@"if(!num) { return NSNotFound; } "];
	[builder appendLineWithFormat:@"return [num intValue];"];
	[builder tabOut];
	[builder appendLineWithFormat:@"}"];

		

	for(GtCodeGeneratorEnumType* anEnumType in generator.schema.enumTypes)
	{		
		[builder appendLine:@""];
		NSString* typeName = [generator getTypeName:anEnumType.typeName];
		
		[builder appendLineWithFormat:@"- (NSString*) %@:(%@) inEnum {",[GtCodeGeneratorEnumType toStringFromEnumFunctionName:generator typeName:typeName], typeName];
		[builder tabIn];
		[builder appendLineWithFormat:@"switch(inEnum) {"];
		[builder tabIn];
			
		for(GtCodeGeneratorEnum* anEnum in anEnumType.enums)
		{
			NSString* enumName = [anEnum fullyQualifiedName:typeName];
		
			[builder appendLineWithFormat:@"case %@: return k%@;", enumName, enumName];
		}

		[builder tabOut];
		[builder appendLineWithFormat:@"}"];
		[builder appendLineWithFormat:@"return nil;"];
		[builder tabOut];
		[builder appendLineWithFormat:@"}"];
		
		[builder appendLine:@""];
	
		[builder appendLineWithFormat:@"- (%@) %@:(NSString*) inString {", 
			typeName, [GtCodeGeneratorEnumType toEnumFromStringFunctionName:generator typeName:typeName]];

		[builder tabIn];
		[builder appendLineWithFormat:@"return (%@) [self lookupString:inString];", typeName];
		
		[builder tabOut];
		[builder appendLineWithFormat:@"}"];
		
		[builder appendLine:@""];

	}

	[builder appendLine:@"@end"];
}

+ (void) generateEnumSourceFile:(GtObjectiveCCodeGenerator*) generator
{
	if(generator.schema.enumTypes && generator.schema.enumTypes.count > 0)
	{
		NSString* fileName = 
			[NSString  stringWithFormat:@"%@Enums.m", generator.schema.schemaName];
	
		GtStringBuilder* builder = [GtStringBuilder stringBuilder];
		
		[generator generateFileHeader:builder fileName:fileName	 disabled:NO generated:YES];
	
		[builder appendLineWithFormat:@"#import \"%@Enums.h\"", generator.schema.schemaName];
				
		[self generateEnumLookups:generator builder:builder];
		
		[generator generateFileFooter:builder fileName:fileName	 disabled:NO];

		GtCodeGeneratorFile* file2 = [GtCodeGeneratorFile codeGeneratorFile];
		file2.name = fileName;
		file2.contents = [builder toString];
		[generator.files addObject:file2];
	}
}


+ (void) generateEnumFiles:(GtObjectiveCCodeGenerator*) generator
{
	if( generator.schema.enumTypes.count > 0 ||
		generator.schema.defines.count > 0)
	{
//		GtCodeGeneratorFile* headerFile = 
		[self generateEnumHeaderFile:generator];
		
//		GtCodeGeneratorTypeDefinition* dep = [GtCodeGeneratorTypeDefinition codeGeneratorTypeDefinition];
//		dep.import = headerFile.name;
//		dep.typeName = @"file";
//		[generator addDependency:dep];
		
		[self generateEnumSourceFile:generator];
	}
}


@end
