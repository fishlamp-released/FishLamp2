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
	FLAssertIsNotNil_(photo);
	FLAssertIsNotNil_(folder);
	
	if((self = [super init]))
	{
		self.input = photo;
		_folder = retain_(folder);
		_options = options;
	}
	return self;
}

+ (FLSaveScaledImagesWithOriginalImage*) saveScaledImagesWithOriginalImage:(id<FLImageAsset>) photo 
				   folder:(FLFolder*) folder
			  saveOptions:(FLSaveScaledImagesWithOriginalImageOption) options {
    
        return FLAutorelease([[FLSaveScaledImagesWithOriginalImage alloc] initWithPhotoInput:photo folder:folder saveOptions:options]);
}


- (void) dealloc
{
	FLReleaseWithNil_(_folder);
	super_dealloc_();
}

- (void) runSelf
{
	id<FLImageAsset> input = (FLJpegFileImageAsset*) self.input;
	FLAssertIsNotNil_(input);
	
	BOOL loadedOriginal = NO;
	BOOL loadedFull = NO;
	
	if(FLTestBits(_options, FLLoadOriginal))
	{
		if(!input.original.hasImage)
		{
			[input.original readFromStorage];
			loadedOriginal = YES;
		}
	}
	
	FLThrowIfCancelled(self);
	
	
	if( FLTestBits(_options, FLLoadFullScreen))
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
			
				FLThrowIfCancelled(self);
				[input createFullScreenVersion];
				
				FLThrowIfCancelled(self);
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
	
	FLThrowIfCancelled(self);
	
	if(FLTestBits(_options, FLLoadThumbnail))
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
				
				FLThrowIfCancelled(self);
				[input createThumbnailVersion];
				
				FLThrowIfCancelled(self);
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

	
	if(!FLTestBits(_options, FLLoadFullScreen) && loadedFull)
	{
		[input.fullScreen releaseImage];
	}
	if(!FLTestBits(_options, FLLoadOriginal) && loadedOriginal)
	{
		[input.original releaseImage];
	}

	self.output = input;

    
}

@end