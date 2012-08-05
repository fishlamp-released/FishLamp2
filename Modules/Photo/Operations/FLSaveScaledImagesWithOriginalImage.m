//
//	FLSaveScaledImagesWithOriginalImage.m
//	FishLamp
//
//	Created by Mike Fullerton on 11/10/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLSaveScaledImagesWithOriginalImage.h"
#import "FLJpegFile.h"
#import "FLJpegFileImageAsset.h"

@implementation FLSaveScaledImagesWithOriginalImage

- (id) initWithPhotoInput:(id<FLImageAsset>) photo 
	folder:(FLFolder*) folder
	saveOptions:(FLSaveScaledImagesWithOriginalImageOption) options
{
	FLAssertIsNotNil(photo);
	FLAssertIsNotNil(folder);
	
	if((self = [super init]))
	{
		self.input = photo;
		m_folder = FLReturnRetained(folder);
		m_options = options;
	}
	return self;
}

- (void) dealloc
{
	FLReleaseWithNil(m_folder);
	FLSuperDealloc();
}

- (void) performSelf
{
	id<FLImageAsset> input = (FLJpegFileImageAsset*) self.input;
	FLAssertIsNotNil(input);
	
	BOOL loadedOriginal = NO;
	BOOL loadedFull = NO;
	
	if(FLBitTest(m_options, FLLoadOriginal))
	{
		if(!input.original.hasImage)
		{
			[input.original readFromStorage];
			loadedOriginal = YES;
		}
	}
	
	[self throwIfCancelled];
	
	
	if( FLBitTest(m_options, FLLoadFullScreen))
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
	
	if(FLBitTest(m_options, FLLoadThumbnail))
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

	
	if(!FLBitTest(m_options, FLLoadFullScreen) && loadedFull)
	{
		[input.fullScreen releaseImage];
	}
	if(!FLBitTest(m_options, FLLoadOriginal) && loadedOriginal)
	{
		[input.original releaseImage];
	}

	self.output = input;

}

@end
