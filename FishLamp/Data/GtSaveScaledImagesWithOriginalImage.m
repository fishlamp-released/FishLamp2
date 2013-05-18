//
//  GtSaveScaledImagesWithOriginalImage.m
//  MyZen
//
//  Created by Mike Fullerton on 11/10/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtSaveScaledImagesWithOriginalImage.h"
#import "GtUserPhotoFolder.h"
#import "GtPhotoData.h"
#import "GtPhoto.h"

@implementation GtSaveScaledImagesWithOriginalImage

- (id) initWithPhotoInput:(GtPhoto*) photo 
    folder:(GtPhotoFolder*) folder
    saveOptions:(GtBitMask) options
{
	if(self = [super initWithInput:photo])
	{
		m_folder = [folder retain];
        m_options = options;
	}
	return self;
}

- (void) dealloc
{
	GtRelease(m_folder);
	[super dealloc];
}

- (void) onPerformOperation
{
	GtPhoto* photo = (GtPhoto*) self.input;
	
	GtAssertNotNil(photo);
	
    if(![photo.fullScreen existsOnDisk])
    {
        if(![photo.original isLoaded])
        {
            [photo.original readFromFile];
        }
    
        [photo createFullScreenVersion];
        [photo.fullScreen saveToFile];
    }
    
    if( GtTestAnyBits(m_options, GtLoadFullScreen | GtLoadFullScreenImage) && 
        ![photo.fullScreen isLoaded])
    {
        [photo.fullScreen readFromFile];
    }
    
    if( GtTestAllBits(m_options, GtLoadFullScreenImage) &&
        !photo.fullScreen.hasImage)
    {
        [photo.fullScreen setImageFromData];
    }
    
    if(GtTestAllBits(m_options, GtCreateThumbnail))
    {
        if(![photo.thumbnail existsOnDisk])
        {
            if(![photo.fullScreen isLoaded])
            {
                [photo.fullScreen readFromFile];
            }
            
            [photo createThumbnailVersion];
            [photo.thumbnail saveToFile];
        }
    }
    
   
    
    if( GtTestAllBits(m_options, GtLoadThumbnail) &&
        ![photo.thumbnail isLoaded])
    {
        [photo.thumbnail readFromFile];
    }
    
    if(GtTestAllBits(m_options, GtDiscardOriginal))
    {
        [photo.original releaseImageAndData];
    }

	if(GtTestAllBits(m_options, GtDiscardFullSize))
    {
        [photo.fullScreen releaseImageAndData];
    }
    
    if(GtTestAllBits(m_options, GtDiscardThumbail))
    {
        [photo.thumbnail releaseImageAndData];
    }
    
	self.output = photo;
	
}

@end
