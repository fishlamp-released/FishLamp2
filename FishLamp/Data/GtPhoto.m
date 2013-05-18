//
//  GtCameraImage.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/25/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtPhoto.h"
#import "GtImageUtilities.h"


@implementation GtPhoto

GtSynthesize(folder, setFolder, GtPhotoFolder, m_folder);

GtSynthesizeID(userData, setUserData);
GtSynthesizeString(rootFileName, setRootFileName);

- (void) initPhotoObjects
{
	m_files = [GtAlloc(NSMutableDictionary) init];
}

- (id) init
{
	if(self = [super init])
	{
		[self initPhotoObjects];
	}
	return self;
}

- (id) initWithFolderAndRootFileName:(GtPhotoFolder*) folder
	rootFileName:(NSString*) rootFileName
{
	if(self = [super init])
	{
		self.rootFileName = rootFileName;
		self.folder = folder;
		[self initPhotoObjects];
	}
	
	return self;
}


- (id) initWithOriginalBytes:(GtPhotoFolder*) folder
	rootFileName:(NSString*) rootFileName
	data:(NSData*) data
{
	if(self = [super init])
	{
		self.rootFileName = rootFileName;
		self.folder = folder;
		[self initPhotoObjects];
		self.original.data = data;
	}
	
	return self;
}

- (id) initWithOriginalImage:(GtPhotoFolder*) folder
	rootFileName:(NSString*) rootFileName
	image:(UIImage*) image
{
	if(self = [super init])
	{
		self.rootFileName = rootFileName;
		self.folder = folder;
		[self initPhotoObjects];
		[self.original setImage:image];
	}
	
	return self;
}

- (void) dealloc
{
	GtRelease(m_folder);
	GtRelease(m_rootFileName);
	GtRelease(m_files);
	GtRelease(m_userData);
	[super dealloc];
}


- (NSString*) fullFilePathForSuffix:(NSString*) suffix
{
	GtAssertNotNil(m_folder);
	GtAssertIsValidString(self.rootFileName);

	return [[m_folder fullPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@", self.rootFileName, suffix]];
}

- (void) setPhotoDataFile:(GtPhotoFile*) file 
				   suffix:(NSString*) suffix
{
	GtAssertIsValidString(self.rootFileName);
	
	file.path = [self fullFilePathForSuffix:suffix];
	[m_files setObject:file forKey:suffix];
}

- (GtPhotoData*) photoDataFile:(NSString*) forSuffix
{
	GtPhotoData* data = [m_files objectForKey:forSuffix];
	if(!data)
	{
		data = [GtAlloc(GtPhotoData) init];
		data.path = [self fullFilePathForSuffix:forSuffix];
		[m_files setObject:data forKey:forSuffix];
		GtRelease(data);
	}
	
	return data;
}

- (GtPhotoFile*) dataFile
{
	GtPhotoFile* data = [m_files objectForKey:GT_PHOTO_DATA_SUFFIX];
	if(!data)
	{
		data = [GtAlloc(GtPhotoFile) init];
		data.path = [self fullFilePathForSuffix:GT_PHOTO_DATA_SUFFIX];
		
		[m_files setObject:data forKey:GT_PHOTO_DATA_SUFFIX];
		GtRelease(data);
	}

	return data;
}

- (void) setDataFile:(GtPhotoFile*) file
{
	[m_files setObject:file forKey:GT_PHOTO_DATA_SUFFIX];
}

- (GtPhotoData*) fullScreen
{
	return [self photoDataFile:GT_FULLSIZE_PHOTO_SUFFIX];
}

- (GtPhotoData*) original
{
	return [self photoDataFile:GT_ORIGINAL_PHOTO_SUFFIX];
}

- (GtPhotoData*) thumbnail
{
	return [self photoDataFile:GT_THUMBNAIL_PHOTO_SUFFIX];
}


- (void) loadThumbnail
{
	if(!self.thumbnail.isLoaded )
	{
		[self.thumbnail readFromFile];
	}
}

- (void) loadOriginal
{
	if(!self.original.isLoaded)
	{
		[self.original readFromFile];
	}
}

- (void) loadFullScreen
{
	if(!self.fullScreen.isLoaded)
	{
		[self.fullScreen readFromFile];
	}
}

- (void) loadDataFile
{
	if(!self.dataFile.hasData)
	{
		[self.dataFile readFromFile]; 
	}
}

- (void) createThumbnailVersion
{
	UIImage* thumb = nil;
	UIImage* fullSized = self.fullScreen.image;
	
	[fullSized shrinkImage:&thumb maxLongSide:60 makeSquare:YES];
	
	self.thumbnail.image = thumb;
	
	GtRelease(thumb);
}


- (void) createFullScreenVersion
{
	if(!self.fullScreen.isLoaded)
	{
#if 0
		GtStartTiming();
#endif	
		UIImage* fullSized = nil;
		UIImage* original = self.original.image;
		
		[original shrinkImage:&fullSized maxLongSide:480 makeSquare:NO];
		
		self.fullScreen.image = fullSized;
		
		GtRelease(fullSized);
		
#if 0
		GtStopTiming(@"createFullScreenVersion");
#endif
	}
	
}


+ (NSString*) imagePlusTimeFileName
{
	static unsigned int counter = 0;

	NSDateComponents* parts = [[NSCalendar currentCalendar] components: 
			(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit)
			fromDate:[NSDate date]];
	return [[GtAlloc(NSString) initWithFormat:@"IMG_%.2d%.2d%.2d%.2d%.2d%.2d.%.3d", 
				parts.month,
				parts.day,
				parts.year,
				parts.hour,
				parts.minute,
				parts.second,
				++counter] autorelease];
}

- (void) deleteFiles
{
	for(NSString* key in m_files)
	{
		GtPhotoFile* file = [m_files objectForKey:key];
		[file deleteFile];
	}
/*
	[self.original deleteFile:folder];
	[self.fullScreen deleteFile:folder];
	[self.thumbnail deleteFile:folder];
	[self.dataFile deleteFile:folder];
*/
}

- (void) createAndSaveFullAndThumbnailVersionsToFileIfNeeded:(BOOL) clearFullScreen
    clearThumbnailWhenDone:(BOOL) clearThumbnail
{
	if(	![self.fullScreen existsOnDisk])
	{
		[self.original readFromFile];
		[self createFullScreenVersion];
		[self.fullScreen saveToFile];
		[self.original releaseImageAndData];
	}

	if( ![self.thumbnail existsOnDisk])
	{
		[self.fullScreen readFromFile];
		[self createThumbnailVersion];
		[self.thumbnail saveToFile];
	}
    
    if(clearFullScreen)
    {
        [self.fullScreen releaseImageAndData];
    }
    if(clearThumbnail)
    {
        [self.thumbnail releaseImageAndData];
    }
}

+ (BOOL) isOriginalPhoto:(NSString*) path
{
	return	![path hasSuffix:GT_FULLSIZE_PHOTO_SUFFIX] &&
			![path hasSuffix:GT_THUMBNAIL_PHOTO_SUFFIX] &&
			![path hasSuffix:GT_PHOTO_DATA_SUFFIX] == 0;
}

+ (NSString*) rootFileNameFromOriginalPhotoName:(NSString*) path
{
	if([path hasSuffix:GT_ORIGINAL_PHOTO_SUFFIX])
	{
		return [path substringToIndex:path.length - [GT_ORIGINAL_PHOTO_SUFFIX length]];
	}
	
	NSString* suffix = [path pathExtension];
	if(suffix && suffix.length)
	{
		return [path stringByDeletingPathExtension];
	}
	
	return path;
}


@end
