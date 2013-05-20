//
//	GtCodeGenerator.m
//	PackMule
//
//	Created by Mike Fullerton on 8/8/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "GtCodeGenerator.h"
#import "GtStringUtilities.h"
#import "GtFileUtilities.h"
#import "GtStringUtilities.h"
#import "GtCodeGeneratorTypeDefinition+More.h"
#import "GtObjectDescriber.h"

#define GeneratedFileHeader @"// This file was generated at %@ by PackMule. DO NOT MODIFY!!"

#define XmlFolderSuffix	 @"XML"

#define TAB1 @"\t"

#define CodeGenFail @"Code Generator Failed"

#define GtThrowIfNilProperty(OBJ, PROP) \
	do { \
		if(!OBJ.PROP) { \
			GtThrowException(@"Code Generation Failed",	 @"%@ value for key '%@' is nil", NSStringFromClass([OBJ class]), @#PROP); \
		} \
	} \
	while(0)

NSString* _CheckString(NSString* str, const char* cstr)
{
	FailIfStringIsEmpty(str, @"%s", cstr != nil ? cstr : "");
	return str;
}	

@implementation GtCodeGenerator

@synthesize diffs  = m_diffs;

@synthesize addedFiles = m_addedFiles;
@synthesize removedFiles = m_removedFiles;
@synthesize changedFiles = m_changedFiles;
@synthesize unchangedFiles = m_unchangedFiles;
@synthesize schema = m_schema;
@synthesize files = m_files;
@synthesize comments = m_comments;
@synthesize parentFolder = m_parentFolder;

- (id) init
{
	if(self = [super init])
	{
		m_files = [[NSMutableArray alloc] init];
		m_oldContents = [[NSMutableDictionary alloc] init];
		m_comments = [[NSMutableArray alloc] init]; 
		m_diffs = [[GtStringBuilder alloc] init];
		m_addedFiles = [[NSMutableArray alloc] init];
		m_removedFiles = [[NSMutableArray alloc] init];
		m_changedFiles = [[NSMutableArray alloc] init];
		m_unchangedFiles = [[NSMutableArray alloc] init];
	}
	
	return self;
}

- (void) dealloc
{
	[m_files release];
	[m_comments release];
	[m_diffs release];
	[m_oldContents release];

	[m_addedFiles release];
	[m_removedFiles release];
	[m_changedFiles release];
	[m_unchangedFiles release];

	[super dealloc];
}

- (NSString*) codeFileFolder
{
	return GtStringIsNotEmpty(m_schema.generatorOptions.codeFileFolderName) ? 
			[m_parentFolder stringByAppendingPathComponent:m_schema.generatorOptions.codeFileFolderName] : 
			m_parentFolder;
}

- (GtCodeGeneratorObject*) getObjectInSchema:(NSString*) objectName
{
	FailIfStringIsEmpty(objectName, @"Object not found: %@", objectName);

	for(GtCodeGeneratorObject* obj in m_schema.objects)
	{
		if([obj.typeName isEqualToString:objectName])
		{
			return obj;
		}
	}
	
	return nil;
}

#define ARCHIVED @"PackMule CodeGen Archive"

- (NSString*) getArchivePath:(NSString*) folderPath
{
	NSArray * paths = NSSearchPathForDirectoriesInDomains (NSDesktopDirectory, NSUserDomainMask, YES);
	NSString * desktopPath = [paths objectAtIndex:0];

	return [desktopPath stringByAppendingPathComponent:ARCHIVED];
}

- (BOOL) filesAreTheSame:(GtCodeGeneratorFile*) newFile oldFile:(NSString*) oldFile
{
	NSString* existingFileContents = [m_oldContents objectForKey:[oldFile lastPathComponent]];
	
	if(existingFileContents)
	{
	}
	
	if(!existingFileContents)
	{
		NSError* err = nil;
		existingFileContents = [NSString stringWithContentsOfFile:oldFile 
			encoding:NSASCIIStringEncoding error:&err];
        if(err)
        {
            GtThrowError([err autorelease]);
        }
    }
	
	return [existingFileContents linesAreEqualTo:newFile.contents 
		startString:[newFile.contents rangeOfString:@"DO NOT MODIFY"].length > 0 ? @"DO NOT MODIFY" : nil
		lhsName:[NSString stringWithFormat:@"%@ (old)", oldFile] 
		rhsName:[NSString stringWithFormat:@"%@ (new)", oldFile] 
		output:m_diffs];
}

- (NSString*) objectsFolderPath
{
	NSString* objectsFolderPath = m_parentFolder;
	
	if(GtStringIsNotEmpty(m_schema.generatorOptions.objectsFolderName))
	{
		objectsFolderPath = [m_parentFolder stringByAppendingPathComponent:m_schema.generatorOptions.objectsFolderName];
	}
	
	return objectsFolderPath;
}
 

- (NSString*) archiveFolderPath
{
	if(!m_archiveFolder)
	{
		NSString* objectsFolderPath = [self objectsFolderPath];
		m_archiveFolder = [NSFileManager createUniqueFolder:[objectsFolderPath lastPathComponent] inParentFolder:[self getArchivePath:objectsFolderPath]];
	}
	
	return m_archiveFolder;
}

- (void) createOrUpdateFiles:(NSString*) fromUri
{
	NSString* objectsFolderPath = [self objectsFolderPath];
	m_archiveFolder = [self archiveFolderPath];

	BOOL isDirectory = NO;
	if(![[NSFileManager defaultManager] fileExistsAtPath:objectsFolderPath isDirectory:&isDirectory])
	{
		NSError* err = nil;
		[[NSFileManager defaultManager] createDirectoryAtPath:objectsFolderPath withIntermediateDirectories:NO attributes:nil error:&err];
	    if(err)
        {
            GtThrowError([err autorelease]);
        }
    
	}
	else if(!isDirectory)
	{
		@throw [NSException exceptionWithName:@"Can't create generation folder" reason:@"Folder exists already but is a file" userInfo:nil];
	}
	
	if(m_comments.count)
	{
		GtStringBuilder* builder = [GtStringBuilder stringBuilder];
		for(GtCodeGeneratorComment* comment in m_comments)
		{
			[builder appendLineWithFormat:@"\"%@.%@\" = \"%@\";", comment.object, comment.commentID, [comment.comment stringByReplacingOccurrencesOfString:@"\"" withString:@"\'"]];
		}
		
		GtCodeGeneratorFile* commentsFile = [GtCodeGeneratorFile codeGeneratorFile];
		commentsFile.name = [NSString stringWithFormat:@"%@.strings", m_schema.schemaName];
		commentsFile.contents = [builder toString];
		[m_files addObject:commentsFile];
	}
	
	for(GtCodeGeneratorFile* file in m_files)
	{
		NSString* srcPath = [objectsFolderPath stringByAppendingPathComponent:file.name];
	
		BOOL updated = NO;
	
		NSError* err = nil;
		if( [[NSFileManager defaultManager] fileExistsAtPath:srcPath] )
		{
			if( [self filesAreTheSame:file oldFile:srcPath])
			{
				[m_unchangedFiles addObject:srcPath];
				continue;
			}
		
			NSString* destPath = [m_archiveFolder stringByAppendingPathComponent:file.name];
					
			[[NSFileManager defaultManager] moveItemAtPath:srcPath toPath:destPath error:&err];
            if(err)
            {
                GtThrowError([err autorelease]);
            }
			
			updated = YES;
		}
	
		[file.contents writeToFile:srcPath atomically:YES
			encoding:NSASCIIStringEncoding error:&err];
			
		if(updated)
		{
			[m_changedFiles addObject:srcPath];
		}
		else
		{
			[m_addedFiles addObject:srcPath];
		}
		
	}
	
//	  [self clearOldFiles:fromUri objectsFolder:objectsFolderPath archiveFolder: archiveFolder];
}


- (NSString*) getTypeName:(NSString*) typeName
{
	return typeName;
}

- (GtCodeGeneratorEnumType*) getEnum:(NSString*) typeName
{
	for(GtCodeGeneratorEnumType* enumType in self.schema.enumTypes)
	{
		NSString* lhs = [self getTypeName:typeName];
		NSString* rhs = [self getTypeName:enumType.typeName];
	
		if([lhs isEqualToString:rhs])
		{
			return enumType;
		}			 
	}
	return nil;
}

- (void) addNewMethods:(GtCodeGeneratorObject*) dest source:(GtCodeGeneratorObject*) source
{
	NSMutableArray* newMethods = [NSMutableArray array];
	for(GtCodeGeneratorMethod* method in source.methods)
	{
		BOOL foundIt = NO;
		for(GtCodeGeneratorMethod* destMethod in dest.methods)
		{
			if([destMethod.name isEqualToString:method.name])
			{
				foundIt = YES;
				break;
			}
		}
		
		if(!foundIt)
		{
			[newMethods addObject:method];
		}
	}
	
	[dest.methods addObjectsFromArray:newMethods];
}


- (void) addNewProperties:(GtCodeGeneratorObject*) dest source:(GtCodeGeneratorObject*) source
{
	NSMutableArray* newProperties = [NSMutableArray array];
	for(GtCodeGeneratorProperty* prop in source.properties)
	{
		BOOL foundIt = NO;
		for(GtCodeGeneratorProperty* destProp in dest.properties)
		{
			if([destProp.name isEqualToString:prop.name])
			{
				foundIt = YES;
				break;
			}
		}
		
		if(!foundIt)
		{
			[newProperties addObject:prop];
		}
	}
	
	[dest.properties addObjectsFromArray:newProperties];
}

- (void) renamePropertyTypes:(NSString*) old new:(NSString*) new
{
	for(GtCodeGeneratorObject* obj in self.schema.objects)
	{
		for(GtCodeGeneratorProperty* prop in obj.properties)
		{
			if([prop.type isEqualToString:old])
			{
				prop.type = new;
			}
			
			for(GtCodeGeneratorVariable* arrayType in prop.arrayTypes)
			{
				if([arrayType.typeName isEqualToString:old])
				{
					arrayType.typeName = new;
				}
			}
		}
		
		if([obj.superclass isEqualToString:old])
		{
			obj.superclass = new;
		}
	}
	
	for(GtCodeGeneratorArray* array in self.schema.arrays)
	{
		for(GtCodeGeneratorVariable* arrayType in array.types)
		{
			if([arrayType.typeName isEqualToString:old])
			{
				arrayType.typeName = new;
			}
		}
	}
}

- (void) addPrefixToObjects:(NSArray*) objects
{
	if(GtStringIsNotEmpty(self.schema.generatorOptions.typePrefix))
	{	
		NSString* prefix = self.schema.generatorOptions.typePrefix;
		for(GtCodeGeneratorObject* obj in objects)
		{
			
			if(![obj.typeName hasPrefix:prefix])
			{
				NSString* newType = [NSString stringWithFormat:@"%@%@", prefix, obj.typeName];
				
				[self renamePropertyTypes:obj.typeName new:newType];
				
				obj.typeName = newType;
			}
			
			
		}
	}
}


- (void) configureForCodeGeneration
{
}

- (void) generateCode
{
}

- (void) addKnownTypesToSchema
{
	NSString* types[] = {
		@"char",
		@"unsigned char",
		@"int",
		@"integer",
		@"NSInteger",
		@"NSUInteger",
		@"unsigned int",
		@"UInt32",
		@"Int32",
		@"SInt32",
		@"long",
		@"unsigned long",
		@"long long",
		@"unsigned long long",
		@"short",
		@"unsigned short",
		@"float",
		@"decimal",
		@"double",
		@"BOOL",
		@"void",
		@"id",
		@"CGPoint",
		@"CGRect",
		@"CGSize",
		@"NSPoint",
		@"NSRect",
		@"NSSize",
		nil 
	};
	
	NSString* objects[] = {
		@"GtSqliteTable,GtSqliteTable.h",
		@"GtObjectDescriber,GtObjectDescriber.h",
		@"GtObjectInflator,GtObjectInflator.h",
		@"GtGuid,GtGuid.h",
		@"NSValue",
		@"NSDate",
		@"NSData",
		@"NSString",
		@"NSNumber",
		@"NSMutableArray",
		@"NSArray",
		@"NSDictionary",
		@"NSMutableDictionary",
		@"NSSet",
		@"NSMutableSet",
		@"NSCountedSet",
		@"NSZone",
		@"NSCoder",
		nil
	};

	for(int i = 0; types[i] != nil; i++)
	{
		GtCodeGeneratorTypeDefinition* type = [GtCodeGeneratorTypeDefinition codeGeneratorTypeDefinition];
		type.typeName = types[i];
		type.dataType = @"value";
		[self addTypeDefinition:type];
	}
	for(int i = 0; objects[i] != nil; i++)
	{
		GtCodeGeneratorTypeDefinition* type = [GtCodeGeneratorTypeDefinition codeGeneratorTypeDefinition];
		
		NSArray* split = [objects[i] componentsSeparatedByString:@","];
		
		type.typeName = [split objectAtIndex:0];
		if(split.count == 2)
		{
			type.import = [split objectAtIndex:1];
			type.importIsPrivateValue = YES;
		}
		type.dataType = @"object";
		[self addTypeDefinition:type];
	}
}

//NSString* applePrefixes[] = {
//	@"NS", // duh
//	@"CG", // core graphics
//	@"UI", // ui kit
//	@"CF", // core foundation
//	@"AL", // asset library
//	@"AV", // audio video
//	@"CL", // core location
//	@"CM", // core media, core motion
//	@"CV", // core video
//	@"MK", // MAP kit
//	@"MIDI", // midi
//	@"CT", // core telephony, core text
//	@"EK", // event kit
//	@"GK", // game kit
//	@"MP", // game kit
//	nil 
//	};
	

- (GtCodeGeneratorTypeDefinition*) typeForName:(NSString*) typeName
{
	for(GtCodeGeneratorTypeDefinition* type in self.schema.typeDefinitions)
	{
		if(GtStringsAreEqual(type.typeName, typeName))
		{
			return type;
		}
	}
	
//	for(int i = 0; applePrefixes[i] != nil; i++)
//	{
//		if([typeName hasPrefix:applePrefixes[i]])
//		{
//			GtCodeGeneratorTypeDefinition* def = [GtCodeGeneratorTypeDefinition codeGeneratorTypeDefinition];
//			def.typeName = typeName;
//			def.dataType = @"object";
//			[self.schema.typeDefinitions addObject:def];
//			return def;
//		}
//	}
	
	GtFail(GtCodeGeneratorErrorDomain, GtCodeGeneratorErrorCodeUnknownTypeErrorCode, @"Unknown Type: %@", typeName);
	
	return nil;
}

- (NSString*) typeStringForGeneratedCode:(NSString*) typeName
{
	GtCodeGeneratorTypeDefinition* type = [self typeForName:typeName];
	
	return type.dataTypeIsObject ? [NSString stringWithFormat:@"%@*", typeName] : typeName;
}

- (void) generateCode:(NSString*) fromUri
	schema:(GtCodeGeneratorProject*) schema 
	objectsToAddOrMerge:(GtCodeGeneratorProject*) postObjects
{
	FailIfStringIsEmpty(fromUri, @"Missing expecting filePath");
	
	if(GtStringIsEmpty(schema.schemaName))
	{
		schema.schemaName = [[fromUri lastPathComponent] stringByDeletingPathExtension];
	}
	
	schema.schemaName = [schema.schemaName stringByReplacingOccurrencesOfString:@"." withString:@"_"];
	
	FailIfStringIsEmpty(schema.schemaName, @"schema needs to be named - <description name='foo'/>");

	m_schema = [schema retain];
	m_parentFolder = [[fromUri stringByDeletingLastPathComponent] retain];
	
	if(GtStringIsEmpty(schema.generatorOptions.codeFileFolderName))
	{
		schema.generatorOptions.codeFileFolderName = schema.generatorOptions.objectsFolderName;
	}
	
	[self addPrefixToObjects:schema.objects];
	[self addPrefixToObjects:postObjects.objects];
   
	GtMergeObjects(schema, postObjects, GtMergeModePreserveDestination);
	
	[self addKnownTypesToSchema];
	
	for(GtCodeGeneratorObject* object in schema.objects)
	{	
		object.typeName = [self getTypeName:object.typeName];
		
		GtCodeGeneratorTypeDefinition* type = [GtCodeGeneratorTypeDefinition codeGeneratorTypeDefinition];
		type.typeName = object.typeName;
		type.dataType = @"object";
		type.import = [NSString stringWithFormat:@"%@.h", type.typeName];
		[self addTypeDefinition:type];
	}
	for(GtCodeGeneratorEnumType* aEnum in schema.enumTypes)
	{	
		aEnum.typeName = [self getTypeName:aEnum.typeName];
		
		GtCodeGeneratorTypeDefinition* type = [GtCodeGeneratorTypeDefinition codeGeneratorTypeDefinition];
		type.typeName = aEnum.typeName;
		type.dataType = @"enum";
		[self addTypeDefinition:type];
	}
	
	[self configureForCodeGeneration];
	[self generateCode];
	[self createOrUpdateFiles:fromUri];
}

+ (GtCodeGeneratorObject*) getObjectByType:(GtCodeGeneratorProject*) schema type:(NSString*) type;
{
	for(GtCodeGeneratorObject* bizObj in schema.objects)
	{
		if(GtStringsAreEqualCaseInsensitive(bizObj.typeName, type))
		{
			return bizObj;
		}
	}
	
	return nil;
}

- (void) getResultsString:(GtStringBuilder*) output
{
	if(self.addedFiles.count)
	{
		[output appendLine:@"New files:"];
		for(NSString* file in self.addedFiles)
		{
			[output appendLine:file];
		}
		[output appendLine];
	}
	if(self.changedFiles.count)
	{
		[output appendLine:@"Changed files:"];
		for(NSString* file in self.changedFiles)
		{
			[output appendLine:file];
		}
		[output appendLine];
	}
	if(self.removedFiles.count)
	{
		[output appendLine:@"Removed files:"];
		for(NSString* file in self.removedFiles)
		{
			[output appendLine:file];
		}
		[output appendLine];
	}
	if(self.unchangedFiles.count)
	{
		[output appendLine:@"Unchanged files:"];
		for(NSString* file in self.unchangedFiles)
		{
			[output appendLine:file];
		}
		[output appendLine];
	}
	
	[output appendLine:[self.diffs toString]];

}

- (void) addDependency:(GtCodeGeneratorTypeDefinition*) dependency
{
	for(GtCodeGeneratorTypeDefinition* aDef in self.schema.dependencies)
	{
		if(GtStringsAreEqual(aDef.typeName, dependency.typeName))
		{
			return;
		}
	}	

	[self.schema.dependencies addObject:dependency];
}

- (void) addTypeDefinition:(GtCodeGeneratorTypeDefinition*) definition
{
	for(GtCodeGeneratorTypeDefinition* aDef in self.schema.typeDefinitions)
	{
		if(GtStringsAreEqual(aDef.typeName, definition.typeName) )
		{
			return;
		}
	}	

	[self.schema.typeDefinitions addObject:definition];
}


@end
