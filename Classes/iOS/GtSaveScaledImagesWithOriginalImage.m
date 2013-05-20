//
//	GtSaveScaledImagesWithOriginalImage.m
//	FishLamp
//
//	Created by Mike Fullerton on 11/10/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtSaveScaledImagesWithOriginalImage.h"
#import "GtJpegFile.h"
#import "GtJpegFileImageAsset.h"

@implementation GtSaveScaledImagesWithOriginalImage

- (id) initWithPhotoInput:(id<GtImageAsset>) photo 
	folder:(GtFolder*) folder
	saveOptions:(GtSaveScaledImagesWithOriginalImageOption) options
{
	GtAssertNotNil(photo);
	GtAssertNotNil(folder);
	
	if((self = [super init]))
	{
		self.input = photo;
		m_folder = GtRetain(folder);
		m_options = options;
	}
	return self;
}

- (void) dealloc
{
	GtReleaseWithNil(m_folder);
	GtSuperDealloc();
}

- (void) performSelf
{
	id<GtImageAsset> input = (GtJpegFileImageAsset*) self.input;
	GtAssertNotNil(input);
	
	BOOL loadedOriginal = NO;
	BOOL loadedFull = NO;
	
	if(GtBitMaskTest(m_options, GtLoadOriginal))
	{
		if(!input.original.hasImage)
		{
			[input.original readFromStorage];
			loadedOriginal = YES;
		}
	}
	
	[self throwIfCancelled];
	
	
	if( GtBitMaskTest(m_options, GtLoadFullScreen))
	{
		if(!input.fullScreen.hasImage)
		{
			if(![input.fullScreen existsInStorage])
			{
				if(!input.original.hasImage)
				{
					[input.original readFromStorage];
					loadedOriginal = YES;

				}
			
				[self throwIfCancelled];
				[input createFullScreenVersion];
				
				[self throwIfCancelled];
				if(input.fullScreen.canWriteToStorage)
				{
					[input.fullScreen writeToStorage];
				}
			}
			else
			{
				[input.fullScreen readFromStorage];
				loadedFull = YES;
			}
		}
	}
	
	[self throwIfCancelled];
	
	if(GtBitMaskTest(m_options, GtLoadThumbnail))
	{
		if(!input.thumbnail.hasImage)
		{
			if(![input.thumbnail existsInStorage])
			{
				if(!input.fullScreen.hasImage && [input.fullScreen existsInStorage])
				{
					[input.fullScreen readFromStorage];
					loadedFull = YES;
				}
				else if(!input.original.hasImage)
				{
					[input.original readFromStorage];
					loadedOriginal = YES;
				}
				
				[self throwIfCancelled];
				[input createThumbnailVersion];
				
				[self throwIfCancelled];
				if(input.thumbnail.canWriteToStorage)
				{
					[input.thumbnail writeToStorage];
				}
			}
			else
			{
				[input.thumbnail readFromStorage];
			}
		}
	}

	
	if(!GtBitMaskTest(m_options, GtLoadFullScreen) && loadedFull)
	{
		[input.fullScreen releaseImage];
	}
	if(!GtBitMaskTest(m_options, GtLoadOriginal) && loadedOriginal)
	{
		[input.original releaseImage];
	}

	self.output = input;

}

@end
