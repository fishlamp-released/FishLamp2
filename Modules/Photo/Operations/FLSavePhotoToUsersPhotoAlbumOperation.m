//
//	FLSavePhotoToUsersPhotoAlbumOperation.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/1/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
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
    return FLReturnAutoreleased([[[self class] alloc] initWithImageInput:image properties:properties]);
}

- (void) dealloc
{
	FLRelease(m_properties);
	FLRelease(m_lock);
	FLRelease(m_assetsLibrary);
	FLSuperDealloc();
}

- (void) _doneSaving:(NSError*) error
{
	[m_lock lockWhenCondition:YES];
	m_done = YES;
	if(error)
	{
		self.error = error;
		
		FLDebugLog(@"Saving image to photo gallery failed: %@", error);
	}
#if DEBUG
	m_savedImage = YES;
#endif
	[m_lock unlockWithCondition:NO];
}

- (void) saveImage:(UIImage*) image	 properties:(NSDictionary*) properties
{

	FLAssertIsNotNil(image);

	m_lock = [[NSConditionLock alloc] initWithCondition:YES]; 
	@try
	{
        m_assetsLibrary = [[ALAssetsLibrary alloc] init];
        FLAssertIsNotNil(m_assetsLibrary);
	
        [m_assetsLibrary writeImageToSavedPhotosAlbum:image.CGImage 
            metadata:properties 
            completionBlock:^(NSURL *assetURL, NSError *error)
            {
                if(!error)
                {
                    self.output = assetURL;
                }
                [self _doneSaving:error];
            }];
		
		[m_lock lockWhenCondition:NO];

#if DEBUG
		FLAssert(m_savedImage, @"lock appears to have failed");
#endif
	}
	@finally
	{	
		[m_lock unlock];
	}
}

- (void) performSelf
{
	[self saveImage:self.input properties:m_properties];
}

- (void) setImageInput:(UIImage*) image properties:(NSDictionary*) properties
{
	self.input = image;
	m_properties = FLReturnRetained(properties);
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

- (void) performSelf
{
	id<FLImageAsset> photo = self.input;
	
	@try
	{
		FLAssertIsNotNil(photo.original);

    	[photo.original readFromStorage];
		
		[self saveImage:photo.original.image properties:photo.original.properties];
	}
	@finally
	{	
		[photo.original releaseImage];
	}
}

@end
