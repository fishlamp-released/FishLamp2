//
//	GtSavePhotoToUsersPhotoAlbumOperation.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/1/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtSavePhotoToUsersPhotoAlbumOperation.h"
#import "GtObjectDatabase.h"

@implementation GtSaveImageToUsersPhotoAlbumOperation

- (id) initWithImageInput:(UIImage*) image	properties:(NSDictionary*) properties
{
	GtAssertNotNil(image);

	if((self = [super init]))
	{
    	[self setImageInput:image properties:properties];
	}
	return self;
}

- (void) dealloc
{
	GtRelease(m_properties);
	GtRelease(m_lock);
	GtRelease(m_assetsLibrary);
	GtSuperDealloc();
}

- (void) _doneSaving:(NSError*) error
{
	[m_lock lockWhenCondition:YES];
	m_done = YES;
	if(error)
	{
		self.error = error;
		
		GtLog(@"Saving image to photo gallery failed: %@", error);
	}
#if DEBUG
	m_savedImage = YES;
#endif
	[m_lock unlockWithCondition:NO];
}

- (void) saveImage:(UIImage*) image	 properties:(NSDictionary*) properties
{

	GtAssertNotNil(image);

	m_lock = [[NSConditionLock alloc] initWithCondition:YES]; 
	@try
	{
        m_assetsLibrary = [[ALAssetsLibrary alloc] init];
        GtAssertNotNil(m_assetsLibrary);
	
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

		GtAssert(m_savedImage, @"lock appears to have failed");
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
	m_properties = GtRetain(properties);
}

@end

@implementation GtSavePhotoToUsersPhotoAlbumOperation

- (id) initWithPhotoInput:(id<GtImageAsset>) photoData
{
	GtAssertNotNil(photoData);

	if((self = [super init]))
	{
		self.input = photoData;
	}
	return self;
}

- (void) performSelf
{
	id<GtImageAsset> photo = self.input;
	
	@try
	{
		GtAssertNotNil(photo.original);

    	[photo.original readFromStorage];
		
		[self saveImage:photo.original.image properties:photo.original.properties];
	}
	@finally
	{	
		[photo.original releaseImage];
	}
}

@end
