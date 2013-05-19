//
//	FLSaveScaledImagesWithOriginalImage.m
//	FishLamp
//
//	Created by Mike Fullerton on 11/10/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
		_folder = FLRetain(folder);
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
	FLReleaseWithNil(_folder);
	FLSuperDealloc();
}

- (void) performSynchronously
{
	id<FLImageAsset> input = (FLJpegFileImageAsset*) self.input;
	FLAssertIsNotNil(input);
	
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
