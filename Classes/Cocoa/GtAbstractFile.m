//
//	GtDataFile.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/25/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtAbstractFile.h"
#import "GtFolder.h"

@implementation GtAbstractFile

@synthesize folder = m_folder;
@synthesize fileName = m_fileName;

- (BOOL) canWriteToStorage
{
	return YES;
}

- (BOOL) canDeleteFromStorage
{
	return YES;
}

- (id) initWithFolder:(GtFolder*) folder fileName:(NSString*) fileName
{
	if((self = [super init]))
	{
		GtAssertNotNil(folder);
		GtAssertIsValidString(fileName);
	
		self.folder = folder;
		self.fileName = fileName;
	}
	
	return self;
}

- (void) beginLoadingRepresentation:(GtErrorCallback) finishedLoadingBlock
{
    if(finishedLoadingBlock)
    {
        finishedLoadingBlock(nil);
    }
}

- (void) beginReadFromStorage:(GtErrorCallback) completionBlock
{
    if(completionBlock)
    {
        completionBlock(nil);
    }
}
- (void) beginWriteToStorage:(GtErrorCallback) completionBlock
{
    if(completionBlock)
    {
        completionBlock(nil);
    }
}
- (void) beginDeleteFromStorage:(GtErrorCallback) completionBlock
{
    if(completionBlock)
    {
        completionBlock(nil);
    }
}

- (BOOL) existsInStorage
{
	[self _throwIfNotConfigured];

	return [m_folder fileExistsInFolder:self.fileName];
}

- (void) deleteFromStorage
{
	[self _throwIfNotConfigured];

	[m_folder deleteFile:self.fileName];
}

- (void) writeToStorage
{
	[self _throwIfNotConfigured];
}

- (void) readFromStorage
{
	[self _throwIfNotConfigured];
}

- (void) _throwIfNotConfigured
{
	if(!m_folder)
	{
		GtThrowError([NSError errorWithDomain:GtErrorDomain code:GtErrorInvalidFolder
			userInfo:[NSDictionary dictionaryWithObject:@"No Folder Set in GtJpegFile" forKey:NSLocalizedDescriptionKey]]);
	}
	if(GtStringIsEmpty(self.fileName))
	{
		GtThrowError([NSError errorWithDomain:GtErrorDomain code:GtErrorInvalidName
			userInfo:[NSDictionary dictionaryWithObject:@"No FileName Set in GtJpegFile" forKey:NSLocalizedDescriptionKey]]);
	}
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

- (NSInputStream*) createReadStream
{
	[self _throwIfNotConfigured];

	NSString* myPath = [m_folder pathForFile:self.fileName];

	if(![[NSFileManager defaultManager] fileExistsAtPath:myPath])
	{
		GtThrowError([NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorFileDoesNotExist 
			userInfo:[NSDictionary dictionaryWithObject:@"Image file is missing - can't create read stream for upload" forKey:NSLocalizedFailureReasonErrorKey]]);
	}

	return GtReturnAutoreleased([[NSInputStream alloc] initWithFileAtPath:myPath]);
}

- (unsigned long long) sizeInStorage
{
	[self _throwIfNotConfigured];
	return [m_folder sizeForFileName:self.fileName];
}

- (BOOL) canSaveToFile
{
	return m_folder != nil && GtStringIsNotEmpty(m_fileName);
}	

- (id) copyWithZone:(NSZone *)zone
{
	return [[GtAbstractFile allocWithZone:zone] initWithFolder:self.folder fileName:self.fileName];
}

@end
