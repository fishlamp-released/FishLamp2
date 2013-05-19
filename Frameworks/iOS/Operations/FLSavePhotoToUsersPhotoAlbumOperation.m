//
//	FLSavePhotoToUsersPhotoAlbumOperation.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/1/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLSavePhotoToUsersPhotoAlbumOperation.h"
#import "FLObjectDatabase.h"

@implementation FLSaveImageToUsersPhotoAlbumOperation

- (id) initWithImageInput:(UIImage*) image	properties:(NSDictionary*) properties
{
	FLAssertIsNotNil(image);

	if((self = [super init]))
	{
    	[self setImageInput:image properties:properties];
	}
	return self;
}

+ (FLSaveImageToUsersPhotoAlbumOperation*) saveImageToUserPhotoAlbumOperation:(UIImage*) image 
                                                                   properties:(NSDictionary*) properties
{
    return FLAutorelease([[[self class] alloc] initWithImageInput:image properties:properties]);
}

- (void) dealloc
{
	FLRelease(_properties);
	FLRelease(_lock);
	FLRelease(_assetsLibrary);
	FLSuperDealloc();
}

- (void) _doneSaving:(NSError*) error
{
	[_lock lockWhenCondition:YES];
	_done = YES;
	if(error) {
        self.error = error;
        FLDebugLog(@"Saving image to photo gallery failed: %@", error);
	}
#if DEBUG
	_savedImage = YES;
#endif
	[_lock unlockWithCondition:NO];
}

- (void) saveImage:(UIImage*) image	 properties:(NSDictionary*) properties
{

	FLAssertIsNotNil(image);

	_lock = [[NSConditionLock alloc] initWithCondition:YES]; 
	@try
	{
        _assetsLibrary = [[ALAssetsLibrary alloc] init];
        FLAssertIsNotNil(_assetsLibrary);
	
        [_assetsLibrary writeImageToSavedPhotosAlbum:image.CGImage 
            metadata:properties 
            completionBlock:^(NSURL *assetURL, NSError *error)
            {
                if(!error)
                {
                    self.output = assetURL;
                }
                [self _doneSaving:error];
            }];
		
		[_lock lockWhenCondition:NO];

#if DEBUG
		FLAssertWithComment(_savedImage, @"lock appears to have failed");
#endif
	}
	@finally
	{	
		[_lock unlock];
	}
}

- (void) performSynchronously {
	[self saveImage:self.input properties:_properties];

}

- (void) setImageInput:(UIImage*) image properties:(NSDictionary*) properties
{
	self.input = image;
	_properties = FLRetain(properties);
}

@end

@implementation FLSavePhotoToUsersPhotoAlbumOperation

- (id) initWithPhotoInput:(id<FLImageAsset>) photoData
{
	FLAssertIsNotNil(photoData);

	if((self = [super init]))
	{
		self.input = photoData;
	}
	return self;
}

- (void) performSynchronously {
	id<FLImageAsset> photo = self.input;
	@try {
		FLAssertIsNotNil(photo.original);
    	[photo.original readFromStorage];
		[self saveImage:photo.original.image properties:photo.original.properties];
	}
	@finally {
		[photo.original releaseImage];
	}

}

@end
