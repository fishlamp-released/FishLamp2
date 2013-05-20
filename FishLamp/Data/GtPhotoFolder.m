//
//  GtPhotoFolder.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/26/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtPhotoFolder.h"
#import "GtPhoto.h"
#import "GtFileUtilities.h"

@implementation GtPhotoFolder

GtSynthesize(folderName, setFolderName, NSString, m_folderName);

- (void) dealloc
{
	GtRelease(m_folderName);
	[super dealloc];
}

- (void) setFolderName:(NSString*) name 
	folderPath:(NSString*) folderPath
{
	self.folderName = name;
	self.fullPath = [folderPath stringByAppendingPathComponent:name];
	
	[self createIfNeeded];
}

- (NSUInteger) countOriginalPhotos
{
	NSUInteger count = 0;
	
	if([self existsOnDisk])
	{
		NSAutoreleasePool* pool = [GtAlloc(NSAutoreleasePool) init];
		NSError* err = nil;
		NSArray* everything = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self fullPath] error:&err];
		GtThrowOnError(err, YES);
		
		for(NSString* path in everything)
		{
			if(	[GtPhoto isOriginalPhoto:path])
			{
				++count;
			}
		}

		GtRelease(pool);
	}
	return count;
}

- (void) loadPhotosInFolder:(NSArray**) outPhotoArray
{
	if([self existsOnDisk])
	{
		NSAutoreleasePool* pool = [GtAlloc(NSAutoreleasePool) init];

		NSError* err = nil;
		NSArray* everything = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self fullPath] error:&err];
		GtThrowOnError(err, YES);
		
		NSMutableArray* photos = [GtAlloc(NSMutableArray) init];
		
		for(NSString* path in everything)
		{
			if(	[GtPhoto isOriginalPhoto:path])
			{
				GtPhoto* photo = [GtAlloc(GtPhoto) initWithFolderAndRootFileName:self
					rootFileName:[GtPhoto rootFileNameFromOriginalPhotoName:path]];
				[photos addObject:photo];
				GtRelease(photo);
			}
		}

		*outPhotoArray = photos;
		
		GtRelease(pool);
	}
}
@end
