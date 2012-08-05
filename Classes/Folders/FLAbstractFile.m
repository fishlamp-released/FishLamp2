//
//	FLDataFile.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/25/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLAbstractFile.h"
#import "FLFolder.h"

@implementation FLAbstractFile

@synthesize folder = _folder;
@synthesize fileName = _fileName;

- (BOOL) canWriteToStorage
{
	return YES;
}

- (BOOL) canDeleteFromStorage
{
	return YES;
}

- (id) initWithFolder:(FLFolder*) folder fileName:(NSString*) fileName
{
	if((self = [super init]))
	{
		FLAssertIsNotNil(folder);
		FLAssertStringIsNotEmpty(fileName);
	
		self.folder = folder;
		self.fileName = fileName;
	}
	
	return self;
}

- (void) beginLoadingRepresentation:(FLErrorCallback) finishedLoadingBlock
{
    if(finishedLoadingBlock)
    {
        finishedLoadingBlock(nil);
    }
}

- (void) beginReadFromStorage:(FLErrorCallback) completionBlock
{
    if(completionBlock)
    {
        completionBlock(nil);
    }
}
- (void) beginWriteToStorage:(FLErrorCallback) completionBlock
{
    if(completionBlock)
    {
        completionBlock(nil);
    }
}
- (void) beginDeleteFromStorage:(FLErrorCallback) completionBlock
{
    if(completionBlock)
    {
        completionBlock(nil);
    }
}

- (BOOL) existsInStorage
{
	[self _throwIfNotConfigured];

	return [_folder fileExistsInFolder:self.fileName];
}

- (void) deleteFromStorage
{
	[self _throwIfNotConfigured];

	[_folder deleteFile:self.fileName];
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
	if(!_folder)
	{
		FLThrowError([NSError errorWithDomain:FLErrorDomain code:FLErrorInvalidFolder
			userInfo:[NSDictionary dictionaryWithObject:@"No Folder Set in FLJpegFile" forKey:NSLocalizedDescriptionKey]]);
	}
	if(FLStringIsEmpty(self.fileName))
	{
		FLThrowError([NSError errorWithDomain:FLErrorDomain code:FLErrorInvalidName
			userInfo:[NSDictionary dictionaryWithObject:@"No FileName Set in FLJpegFile" forKey:NSLocalizedDescriptionKey]]);
	}
}

- (void) dealloc
{
	FLRelease(_fileName);
	FLRelease(_folder);
	FLSuperDealloc();
}

- (NSString*) filePath
{
	return [_folder pathForFile:self.fileName];
}

- (NSInputStream*) createReadStream
{
	[self _throwIfNotConfigured];

	NSString* myPath = [_folder pathForFile:self.fileName];

	if(![[NSFileManager defaultManager] fileExistsAtPath:myPath])
	{
		FLThrowError([NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorFileDoesNotExist 
			userInfo:[NSDictionary dictionaryWithObject:@"Image file is missing - can't create read stream for upload" forKey:NSLocalizedFailureReasonErrorKey]]);
	}

	return FLReturnAutoreleased([[NSInputStream alloc] initWithFileAtPath:myPath]);
}

- (unsigned long long) sizeInStorage
{
	[self _throwIfNotConfigured];
	return [_folder sizeForFileName:self.fileName];
}

- (BOOL) canSaveToFile
{
	return _folder != nil && FLStringIsNotEmpty(_fileName);
}	

- (id) copyWithZone:(NSZone *)zone
{
	return [[FLAbstractFile allocWithZone:zone] initWithFolder:self.folder fileName:self.fileName];
}

@end
