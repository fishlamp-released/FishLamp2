//
//	GtFolderFile.m
//	PackMule
//
//	Created by Mike Fullerton on 11/8/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFolderFile.h"
#import "GtObjectDescriber.h"

@implementation GtFolderFile

@synthesize folder = m_folder;
@synthesize fileName = m_fileName;

- (id) initWithFolder:(GtFolder*) folder fileName:(NSString*) fileName
{
	if((self = [super init]))
	{
		self.folder = folder;
		self.fileName = fileName;
	}
	return self;
}

- (void) dealloc
{
	GtRelease(m_fileName);
	GtRelease(m_folder);
	GtSuperDealloc();
}

- (NSString*) filePath
{
	return [m_folder pathForFile:self.fileName];
}

- (void) deleteFile
{
	[m_folder deleteFile:self.fileName];
}

- (void) writeToFile
{
	[m_folder writeObjectToFile:self.fileName object:self];
}

- (BOOL) fileExists
{
	return [m_folder fileExistsInFolder:self.fileName];
}

- (BOOL) readFromFile
{
	id contents = nil;
	@try
	{
		if([m_folder fileExistsInFolder:self.fileName])
		{
			[m_folder readObjectFromFile:self.fileName outObject:&contents];
			
			GtMergeObjects(self, contents, GtMergeModeSourceWins);
			
		//	[self copyContentsFromObject:contents];
			return YES;
		}
	}
	@catch(NSException* ex)
	{
		GtLog(@"exception loading folderFile: %@", [ex description]);
	}
	@finally
	{
		GtRelease(contents);
	}
	
	return NO;
}

@end
