//
//  GtSavePhotoToUsersPhotoAlbumOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/1/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtSavePhotoToUsersPhotoAlbumOperation.h"
#import "GtObjectDatabase.h"
#import "GtUserPhotoFolder.h"

#if DEBUG
#define TIMEIT 1
#endif

#if IPHONE
@implementation GtSaveImageToUsersPhotoAlbumOperation

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
	if(error)
	{
		GtThrowOnError(error, NO);
	}
}

- (void) onPerformOperation
{
	UIImageWriteToSavedPhotosAlbum(self.input, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
	
	self.output = self.input;
}

- (id) initWithImageInput:(UIImage*) image;
{
	if(self = [super initWithInput:image])
	{
	}
	return self;
}

@end

@implementation GtSavePhotoToUsersPhotoAlbumOperation

- (id) initWithPhotoInput:(GtPhoto*) photoData
{
	if(self = [super initWithInput:photoData])
	{
	}
	return self;
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
	if(error)
	{
		GtThrowOnError(error, NO);
	}
}

- (void) onPerformOperation
{
#if TIMEIT
	GtStartTiming();
#endif

	NSAutoreleasePool* pool = [GtAlloc(NSAutoreleasePool) init];
	GtPhoto* photo = self.input;
	
	@try
	{	
			
		[photo.original readFromFile];
		UIImage* image = photo.original.image;
		UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
		[photo.original releaseImageAndData];
		
		self.output = photo;
	}
	@finally
	{	
		GtRelease(pool);
	}
#if TIMEIT
	GtStopTiming(@"save to photo album");
#endif
	
}

@end

#endif