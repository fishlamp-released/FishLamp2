//
//	GtCodeGeneratorProjectManager.m
//	PackMule
//
//	Created by Mike Fullerton on 8/15/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "GtCodeGeneratorProjectManager.h"
#import "GtObjectiveCCodeGenerator.h"
#import "GtWsdlTranslator.h"
#import "GtStringUtilities.h"
#import "GtCodeGeneratorProject.h"
#import "GtXmlParser.h"
#import "GtObjectXml.h"
#import "NSObject+GtStreamableObject.h"

@implementation GtCodeGeneratorProjectManager

GtSynthesizeSingleton(GtCodeGeneratorProjectManager);

@synthesize output = m_output;

- (id) init
{
	if(self = [super init])
	{
		m_codeTranslators = [[NSMutableArray alloc] init];
		[self addCodeTranslator:self];
		
		m_output = [[GtStringBuilder alloc] init];
	}

	return self;
}

- (void) dealloc
{
	[m_output release];
	[m_codeTranslators release];
	[m_generators release];
	
	[super dealloc];
	
}

- (void) addCodeTranslator:(id<GtCodeTranslator>) translator
{
	[m_codeTranslators addObject:translator];
}


- (BOOL) saveProject:(GtCodeGeneratorProject*) project filePath: (NSString*) filePath
{
/*
	GtXmlBuilder* builder = [GtXmlBuilder builder];
	[builder addVersionAndEncodingHeader];
	[builder openElement:@"project"];
	
	[project toXml:builder ];
	
	[builder closeElement]; // project
	
	NSError* err = nil;
	if([[NSFileManager defaultManager] fileExistsAtPath:filePath])
	{
		[[NSFileManager defaultManager] removeItemAtPath:filePath error:&err];
		GtThrowOnError(err);
	}
	
	BOOL written = [[builder toString] writeToFile:filePath 
		atomically:NO 
		encoding:NSUTF8StringEncoding
		error:&err];
	GtThrowOnError(err);
	
	return written;
*/
	return NO;
}

- (GtCodeGeneratorProject*) createEmptyProject
{
/*
	GtCodeGeneratorProject* proj = [GtCodeGeneratorProject object];
	
	proj.company = @"GreenTongue Software";
	proj.project = @"FishLamp";
	
	[proj.imports.array addObject:@"http://www.google.com"];
	
	return proj;
*/

	return nil;
}

- (BOOL) willTranslate:(NSString*) fileUrl
{
	return [[fileUrl pathExtension] isEqualToString:@"cgcode" caseSensitive:NO];
}

- (void) buildCodeGeneratorSchema:(NSString*) fromFilePath project:(GtCodeGeneratorProject*) project codeSchema:(GtCodeGeneratorProject*) codeSchema
{
	NSString* path = [[fromFilePath stringByDeletingLastPathComponent] stringByAppendingPathComponent:project.fileUrl];
	
	NSData* data = [[NSFileManager defaultManager] contentsAtPath:path];
	if(!data)
	{
		GtThrowException(@"GtCodeGenerator", @"Failed to load data for file: %@", path);
	}

	GtXmlParser* parser = [[[GtXmlParser alloc] initWithXmlData:data] autorelease];
	codeSchema.schemaName = [[path lastPathComponent] stringByDeletingPathExtension]; 
	[parser buildObjects:codeSchema];
}

- (void) loadImportedProjectsRecursively:(GtCodeGeneratorProject*) inProject
	 projectFilePath:(NSString*) filePath
{
	for(int i = inProject.imports.count-1; i >= 0; i--)
	{
		GtCodeGeneratorProject* import = [inProject.imports objectAtIndex:i];
	
		if([[import.fileUrl pathExtension] isEqualToString:@"cgcode" caseSensitive:NO])
		{
			NSString* path = [[filePath stringByDeletingLastPathComponent] stringByAppendingPathComponent:import.fileUrl];
		
			NSError* err = nil;
			NSData* xmlData = [[[NSData alloc] initWithContentsOfFile:path options:0 error:&err] autorelease];
            if(err)
            {
                GtThrowError([err autorelease]);
            }
			
			GtXmlParser* parser = [GtXmlParser xmlParser:xmlData];
			GtCodeGeneratorProject* newProject = [GtCodeGeneratorProject codeGeneratorProject];
			[parser buildObjects:newProject];
			 
			[inProject.imports removeObjectAtIndex:i];
			[self _generateCodeWithProject:newProject projectFilePath:path];
		}
	}
}



- (void) buildProject:(GtCodeGeneratorProject*) project 
	projectFilePath:(NSString*) filePath
{
	BOOL doMerge = YES;
	if(GtStringIsEmpty(project.fileUrl))
	{
		doMerge = NO;
		project.fileUrl = [filePath lastPathComponent];
	}

	NSString* fileUrl = GtStringIsEmpty(project.fileUrl) ? filePath : project.fileUrl;
	
	for(int i = 0; i < m_codeTranslators.count; i++)
	{
		id<GtCodeTranslator> translator = [m_codeTranslators objectAtIndex:i];
		if([translator willTranslate:fileUrl])
		{
			GtCodeGeneratorProject* codeSchema = [GtCodeGeneratorProject codeGeneratorProject];
			codeSchema.generatorOptions = project.generatorOptions;
			codeSchema.companyName = project.companyName;
			codeSchema.projectName = project.projectName;
			codeSchema.disabled = project.disabled;
			codeSchema.canLazyCreate = project.canLazyCreate;
			codeSchema.comment = project.comment;
			codeSchema.defines = project.defines;
			codeSchema.schemaName = project.schemaName;
			codeSchema.typeDefinitions = project.typeDefinitions;

			[translator buildCodeGeneratorSchema:filePath project:project codeSchema:codeSchema];
			
			GtCodeGenerator* generator = [GtObjectiveCCodeGenerator objectiveCCodeGenerator];
			[generator generateCode:filePath schema:codeSchema objectsToAddOrMerge:doMerge ? project : nil];
			[generator getResultsString:m_output];
			[m_generators addObject:generator];

			break;
		}
	}
}

- (void) _generateCodeWithProject:(GtCodeGeneratorProject*) project projectFilePath:(NSString*) filePath
{
	GtThrowIfNil(project);
	GtThrowIfStringEmpty(filePath);
	
	[self loadImportedProjectsRecursively:project projectFilePath:filePath];

	for(GtCodeGeneratorProject* import in project.imports)
	{
		import.parentProjectPath = filePath;
		GtMergeObjects(import.generatorOptions, project.generatorOptions, GtMergeModeSourceWins);
//		GtMergeObjects(import.description, project.description, GtMergeModeSourceWins);
//		GtMergeObjects(import.objectOptions, project.objectOptions, GtMergeModeSourceWins);
//		GtMergeObjects(import.propertyOptions, project.propertyOptions, GtMergeModeSourceWins);
	
		[self buildProject:import projectFilePath:filePath];
	}
	
	[self buildProject:project projectFilePath:filePath];
}


#define FileName @"filelist.plist"

- (NSArray*) readFileListFromFile:(NSString*) path
{
	if(![[NSFileManager defaultManager] fileExistsAtPath:path])
	{
		return nil;
	}
	
	NSError* err = nil;
	NSData* data = [[NSData alloc] initWithContentsOfFile:path options:NSUncachedRead error:&err];
	if(err)
	{
		[err release];
		return nil;
	}

	@try
	{
		return [NSKeyedUnarchiver unarchiveObjectWithData:data];
	}
	@catch(NSException* ex)
	{
	}
	
	return nil;
}

- (void) clearOldFiles:(NSString*) objectsFolderPath 
	archiveFolder:(NSString*) archiveFolder
	fileList:(NSArray*) fileList
{
	NSString* filesFilePath = [objectsFolderPath stringByAppendingPathComponent:@"filelist.plist"];
	NSMutableArray* oldFileList = [NSMutableArray arrayWithArray:[self readFileListFromFile:filesFilePath]];
		
	NSMutableArray* newFileList = [NSMutableArray array];
   
	for(GtCodeGeneratorFile* file in fileList)
	{
		NSString* srcPath = [objectsFolderPath stringByAppendingPathComponent:file.name];

		if(oldFileList)
		{
			if( [[NSFileManager defaultManager] fileExistsAtPath:srcPath] )
			{
				for(int i = 0; i < oldFileList.count; i++)
				{
					NSString* oldFile = [objectsFolderPath stringByAppendingPathComponent:
						[oldFileList objectAtIndex:i]];
				
					if([oldFile isEqualToString:srcPath])
					{
						[oldFileList removeObjectAtIndex:i];
						break;
					}
				}
			}
		}

		[newFileList addObject:file.name];
	}
	
	if(oldFileList)
	{
		NSError* err = nil;
		for(NSString* oldFile in oldFileList)
		{
			NSString* srcPath = [objectsFolderPath stringByAppendingPathComponent:oldFile];
			NSString* destPath = [archiveFolder stringByAppendingPathComponent:oldFile];

 //			  [m_removedFiles addObject:destPath];

			[[NSFileManager defaultManager] moveItemAtPath:srcPath toPath:destPath error:&err];
            if(err)
            {
                GtThrowError([err autorelease]);
            }

	/*
			[m_output appendLineWithFormat:@"Archived:"];
			[m_output tabIn];
			[m_output appendLineWithFormat:@"From: %@", oldFile];
			[m_output appendLineWithFormat:@"To: %@", destPath];
			[m_output tabOut];
	 */
	 
		}
	}
	
	NSData* data = [NSKeyedArchiver archivedDataWithRootObject:newFileList];
	NSError* err = nil;
	[data writeToFile:filesFilePath options:NSAtomicWrite error:&err];
    if(err)
    {
        GtThrowError([err autorelease]);
    }

}

- (void) generateCodeWithProject:(GtCodeGeneratorProject*) project projectFilePath:(NSString*) filePath
{
	GtReleaseWithNil(m_generators);
	m_generators = [[NSMutableArray alloc] init];
	[self _generateCodeWithProject:project projectFilePath:filePath];
	
//	  while(m_generators.count)
//	  {
//		  GtCodeGenerator* generator = [generators objectAtIndex:0];
//	  
//		  NSString* objectsPath = [generator objectsFolderPath];
//		  NSMutableArray* fileList = [NSMutableArray array];
//		  [fileList addObjectsFromArray:generator.files];
//		  
//		  for(int j = m_generators.count-1; j > 0; j--)
//		  {
//			  if(GtStringsAreEqual(objectsPath,[[generators objectAtIndex:j] objectsFolderPath]))
//			  {
//				  [fileList addObjectsFromArray:[[generators objectAtIndex:j] files]];
//				  [m_generators removeObjectAtIndex:j];
//			  }
//		  }
//	   
//		  
//	  }
}

@end
