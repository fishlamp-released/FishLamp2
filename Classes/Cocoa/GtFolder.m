//
//	GtFolder.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/7/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFolder.h"
#import "NSFileManager+GtExtras.h"

@implementation GtFolder

@synthesize fullPath = m_fullPath;
@synthesize searchPathDirectory = m_searchPathDirectory;

- (void) setFullPath:(NSString*) fullPath
{
	GtAssertIsValidString(fullPath);
	GtAssignObject(m_fullPath, fullPath);
}

- (id) init
{
	if((self = [super init]))
	{
	}
	
	return self;
}

- (id) initWithFullPath:(NSString*) path
{
	GtAssertIsValidString(path);

	if((self = [super init]))
	{
		self.fullPath = path;
	}
	
	return self;
}

- (void) setSearchPathDirectory:(NSSearchPathDirectory) directory
{
	m_searchPathDirectory = directory;
	NSArray* paths = NSSearchPathForDirectoriesInDomains(m_searchPathDirectory, NSUserDomainMask, YES);
	self.fullPath = [paths objectAtIndex: 0];
}

- (id) initWithSearchPathDirectory:(NSSearchPathDirectory) directory
{
	if((self = [super init]))
	{
		self.searchPathDirectory = directory;
	}
	return self;
}

- (void) appendStringToPath:(NSString*) string
{	
	GtAssertIsValidString(string);

	self.fullPath = [self.fullPath stringByAppendingPathComponent:string];
}

- (void) dealloc
{
	GtReleaseWithNil(m_fullPath);
	GtSuperDealloc();
}

- (void) deleteAllFiles:(id<GtCancellableOperation>) operation
{
    [self deleteFiles:operation shouldDeleteFileBlock:nil];
}

- (void) visitAllFiles:(id<GtCancellableOperation>) operation
          visitorBlock:(GtFileVisitorBlock) visitorBlock
{
	if([self existsOnDisk] && visitorBlock)
	{
        NSError* err = nil;
		NSArray* everything = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self fullPath] error:&err];
        if(err)
        {
           GtThrowError(GtReturnAutoreleased(err));
        }
		
        for(NSString* name in everything)
        {
            NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
            @try
            {
                visitorBlock(self, name);

                [operation throwIfCancelled];
           
                GtDrainPool(&pool);
            }
            @catch(NSException* ex)
            {
                GtDrainPoolAndRethrow(&pool, ex);
            }
        }
    }
}

- (void) deleteFiles:(id<GtCancellableOperation>) operation
shouldDeleteFileBlock: (GtTestFileNameBlock) shouldDeleteFileBlock
{
	if([self existsOnDisk])
	{
        NSError* err = nil;
		NSArray* everything = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self fullPath] error:&err];
        if(err)
        {
           GtThrowError(GtReturnAutoreleased(err));
        }
		
        for(NSString* name in everything)
        {
            BOOL shouldDelete = YES;
            if(shouldDeleteFileBlock)
            {
                shouldDeleteFileBlock(name, &shouldDelete);
            }
            if(shouldDelete)
            {
                [[NSFileManager defaultManager] removeItemAtPath: 
                    [[self fullPath] stringByAppendingPathComponent:name] error:&err];
                
                if(err)
                {
                   GtThrowError(GtReturnAutoreleased(err));
                }
            }
            [operation throwIfCancelled];
        }
        
#if DEBUG
    NSArray* everything2 = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self fullPath] error:&err];
    GtLog(@"After delete, %d items left", everything2.count);    
#endif         
	}
}

- (unsigned long long) calculateFolderSize:(id<GtCancellableOperation>) operation
	outItemCount:(NSUInteger*) outItemCount
{
	unsigned long long size = 0;
	
	if([self existsOnDisk])
	{
		NSAutoreleasePool* outerpool = [[NSAutoreleasePool alloc] init];
		@try
		{
			NSError* err = nil;
			NSDictionary* folderAttr = [[NSFileManager defaultManager] attributesOfItemAtPath:[self fullPath] error:&err];
			if(err)
            {
               GtThrowError(GtReturnAutoreleased(err));
            }
			
			size = [[folderAttr objectForKey:NSFileSize] longValue];
			
			NSArray* everything = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self fullPath] error:&err];
            if(err)
            {
               GtThrowError(GtReturnAutoreleased(err));
            }

			if(outItemCount)
			{
				*outItemCount = everything.count; 
			}
			
			for(NSString* path in everything)
			{
				NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
				@try
				{
					NSDictionary* attr = [[NSFileManager defaultManager] attributesOfItemAtPath:
						[[self fullPath] stringByAppendingPathComponent:path] error:&err];
                    if(err)
                    {
                       GtThrowError(GtReturnAutoreleased(err));
                    }
				
					size += [[attr objectForKey:NSFileSize] longLongValue];
					
					[operation throwIfCancelled];
					GtDrainPool(&pool);
				}
				@catch(NSException* ex)
				{
					GtDrainPoolAndRethrow(&pool, ex);
				}
			}
			
			GtDrainPool(&outerpool);
		}
		@catch(NSException* ex)
		{
			GtDrainPoolAndRethrow(&outerpool, ex);
		}
	}
	return size;
}

- (NSDate*) dateCreatedForFile:(NSString*) fileName
{
	NSError* err = nil;
	NSDictionary* attr = [[NSFileManager defaultManager] attributesOfItemAtPath:[self pathForFile:fileName] error:&err];
    if(err)
    {
       GtThrowError(GtReturnAutoreleased(err));
    }

	return [attr objectForKey:NSFileCreationDate];
}

- (NSDate*) dateModifiedForFile:(NSString*) fileName
{
	NSError* err = nil;
	NSDictionary* attr = [[NSFileManager defaultManager] attributesOfItemAtPath:[self pathForFile:fileName] error:&err];
	
    if(err)
    {
       GtThrowError(GtReturnAutoreleased(err));
    }

	return [attr objectForKey:NSFileModificationDate];
}

- (unsigned long long) sizeForFileName:(NSString*) fileName
{
	NSError* err = nil;
	NSDictionary* attr = [[NSFileManager defaultManager] attributesOfItemAtPath:[self pathForFile:fileName] error:&err];
    if(err)
    {
       GtThrowError(GtReturnAutoreleased(err));
    }

	return [[attr objectForKey:NSFileSize] longLongValue];
}


- (void) createIfNeeded
{
	NSError* err = nil;
	BOOL isDirectory;
	if(![[NSFileManager defaultManager] fileExistsAtPath: [self fullPath] isDirectory:&isDirectory])
	{
		[[NSFileManager defaultManager] createDirectoryAtPath: [self fullPath] withIntermediateDirectories:YES attributes:nil error:&err];
        
        if(err)
        {
           GtThrowError(GtReturnAutoreleased(err));
        }

	}
}

- (NSString*) pathForFile:(NSString*) fileName
{
	GtAssertIsValidString(fileName);

	return [self.fullPath stringByAppendingPathComponent:fileName];
}

- (BOOL) existsOnDisk
{
	BOOL isDirectory = NO;
	return [[NSFileManager defaultManager] fileExistsAtPath: [self fullPath] isDirectory:&isDirectory];
}

- (void) deleteFile:(NSString*) fileName
{
	GtAssertIsValidString(fileName);

	NSError* error = nil;
	[[NSFileManager defaultManager] removeItemAtPath:[self pathForFile:fileName] error:&error];
	if(error)
    {
        GtThrowError(GtReturnAutoreleased(error));
    }
}

- (void) writeObjectToFile:(NSString*) fileName object:(id) object
{
	GtAssertIsValidString(fileName);
	GtAssertNotNil(object);

	NSData* data = [NSKeyedArchiver archivedDataWithRootObject:object];
	[self writeDataToFile:fileName data:data]; 
}

- (void) readObjectFromFile:(NSString*) fileName outObject:(id*) outObject 
{
	GtAssertIsValidString(fileName);
	NSData* data = nil;
	@try
	{
		[self readDataFromFile:fileName outData:&data];
	
		id object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
		if(object)
		{
			*outObject = GtRetain(object);
		}
	}
	@finally
	{
		GtReleaseWithNil(data);
	}
}

- (void) writeDataToFile:(NSString*) fileName data:(NSData*) data
{
	GtAssertIsValidString(fileName);
	GtAssertNotNil(data);
	
	NSError* error = nil;
	[data writeToFile:[self pathForFile:fileName] options:NSAtomicWrite error:&error];
	if(error)
    {
        GtThrowError(GtReturnAutoreleased(error));
    }
}

- (void) readDataFromFile:(NSString*) fileName outData:(NSData**) outData
{
	GtAssertIsValidString(fileName);

	NSError* internalErr = nil;
	
	NSString* path = [self pathForFile:fileName];
	
	if(![[NSFileManager defaultManager] fileExistsAtPath:path])
	{
		GtThrowError( GtReturnAutoreleased([[NSError alloc] initWithDomain:NSCocoaErrorDomain code:NSFileNoSuchFileError userInfo:nil]));
	}
	
	NSData* data = [[NSData alloc] initWithContentsOfFile:[self pathForFile:fileName] options:NSDataReadingUncached error:&internalErr];

	@try
	{
        if(internalErr)
        {
            GtThrowError(GtReturnAutoreleased(internalErr));
        }

		if(!data)
		{
			GtThrowErrorCode(NSCocoaErrorDomain, NSFileReadUnknownError, @"unexpectedly read empty file");
		}
		if(outData)
		{
			*outData = GtRetain(data);
		}
	}
	@finally
	{
		GtReleaseWithNil(data);
	}
}

- (void) moveFilesToFolder:(GtFolder*) destinationFolder withCopy:(BOOL) copy
{
	GtAssertNotNil(destinationFolder);

	NSError* err = nil;
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];

	@try
	{
		if(![self existsOnDisk] || ![destinationFolder existsOnDisk])
		{
			GtThrowError( GtReturnAutoreleased([[NSError alloc] initWithDomain:NSCocoaErrorDomain code:NSFileNoSuchFileError userInfo:nil]));
		}
		
		NSFileManager* fileMgr = [NSFileManager defaultManager];
		NSArray* everything = [fileMgr contentsOfDirectoryAtPath:[self fullPath] error:&err];
		        if(err)
        {
           GtThrowError(GtReturnAutoreleased(err));
        }


		NSString* destFolder = destinationFolder.fullPath;
		NSString* srcFolder = self.fullPath;
		
		for(NSString* file in everything)
		{
			NSString* src =		[srcFolder stringByAppendingPathComponent:file];
			NSString* dest =	[destFolder stringByAppendingPathComponent:file];
		
			if([fileMgr fileExistsAtPath:dest])
			{
				continue;
			}
		
			if(copy)
			{
				[fileMgr copyItemAtPath:src toPath:dest error:&err];
			}
			else
			{
				[fileMgr moveItemAtPath:src toPath:dest error:&err];
			}
			
            if(err)
            {
               GtThrowError(GtReturnAutoreleased(err));
            }
        }
	
		GtDrainPool(&pool);
	}
	@catch(NSException* ex)
	{
		GtDrainPoolAndRethrow(&pool, ex);
	}
}

- (BOOL) fileExistsInFolder:(NSString*) name
{
	GtAssertIsValidString(name);

	return [[NSFileManager defaultManager] fileExistsAtPath:[self pathForFile:name]];
}

- (void) addSkipBackupAttributeToFile:(NSString*) name
{
    [NSFileManager addSkipBackupAttributeToFile:[self pathForFile:name]];
}

- (NSUInteger) countItems:(BOOL) recursive
{
    return [[NSFileManager defaultManager] countItemsInDirectory:self.fullPath recursively:recursive visibleItemsOnly:YES];
}

@end

                                                   

