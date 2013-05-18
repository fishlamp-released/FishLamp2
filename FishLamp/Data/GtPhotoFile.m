//
//  GtPhotoFile.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/25/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtPhotoFile.h"
#import "GtPhotoFolder.h"

@implementation GtPhotoFile

GtSynthesize(data, setData, NSData, m_data);
GtSynthesize(path, setPath, NSString, m_path);

- (id) init
{
	if(self = [super init])
	{
	}
	return self;
}

- (id) initWithData:(NSData*) data
{
	if(self = [self init])
	{
		self.data = data;
	}
	return self;
}

- (id) initWithPath:(NSString*) path
{
	if(self = [super init])
	{
		self.path = path;
	}
	return self;
}

- (id) initWithPathAndData:(NSString*) path 
					  data:(NSData*) data
{
	if(self = [super init])
	{
		self.path = path;
		self.data = data;
	}
	return self;
}

- (void) dealloc
{
	GtRelease(m_path);
	GtRelease(m_data);
	[super dealloc];
}

- (BOOL) deleteFile
{
	GtAssertIsValidString(self.path);

	NSError* err = nil;
	if([[NSFileManager defaultManager] fileExistsAtPath:self.path])
	{
		[[NSFileManager defaultManager] removeItemAtPath:self.path error:&err];
		GtThrowOnError(err, YES);
		return YES;
	}
	return NO;
}

- (BOOL) existsOnDisk
{
	GtAssertIsValidString(self.path);
	return [[NSFileManager defaultManager] fileExistsAtPath:self.path];
}

- (BOOL) hasData
{
	return (m_data != nil && m_data.length > 0);
}

- (BOOL) isLoaded
{
	return self.hasData;
}

- (void) releaseData
{
	self.data = nil;
}

- (BOOL) saveToFile
{	
#if DEBUG

	if(GtTestBoolEnvironmentVariable(GtTimePhotoOperations))
	{
		GtStartTiming(); 
	}

#endif

	GtAssertIsValidString(self.path);
    GtAssert(self.isLoaded, @"image not loaded");
    
    BOOL hadData = self.hasData;
    NSData* data = self.data;
    
    GtAssert(data && data.length > 0, @"Image doesn't have data");
    
	BOOL didSave = [data writeToFile:self.path atomically:NO];
	GtAssert(didSave, @"file didn't save");
    
    if(!hadData)
    {
        self.data = nil;
    }
    
#if DEBUG

	if(GtTestBoolEnvironmentVariable(GtTimePhotoOperations))
	{
		GtStopTiming(@"Saving JPG to disk"); 
	}

#endif

	return didSave;
}

- (BOOL) readFromFile
{
	return [self readFromFile:NO];
}

- (BOOL) readFromFile:(BOOL) forceReload
{	
	if(!self.isLoaded || forceReload)
	{
		[self releaseData];
			
		GtAssertIsValidString(self.path);
        GtAssert(self.existsOnDisk, @"trying to load file that ain't there");

		NSData* data = [GtAlloc(NSData) initWithContentsOfFile:self.path];
        
        GtAssertNotNil(data); 
        
		self.data = data;
		GtRelease(data);
		
		return YES;
	}
	
	return NO;
}

- (unsigned long) size
{
	if(self.data)
	{
		return self.data.length;
	}
	
	return 0;
}


@end
