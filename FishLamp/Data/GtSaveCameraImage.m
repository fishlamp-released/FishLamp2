//
//  GtSaveCameraImage.m
//  MyZen
//
//  Created by Mike Fullerton on 11/10/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtSaveCameraImage.h"
#import "GtUserPhotoFolder.h"
#import "GtPhotoData.h"
#import "GtPhoto.h"
#import "GtUserSession.h"

@implementation GtSaveCameraImage

- (id) initWithImageInput:(UIImage*) image
{
	if(self = [super initWithInput:image])
	{
	}
	return self;
}

- (void) onPerformOperation
{
	GtPhoto* photo = [GtAlloc(GtPhoto) initWithOriginalImage:[GtUserSession instance].photoFolder
		rootFileName:[GtPhoto imagePlusTimeFileName] 
		image:(UIImage*) self.input];
	
	[photo.original saveToFile];
	self.output = photo;
	
	GtRelease(photo);
}

- (GtPhoto*) outputPhoto
{
	return (GtPhoto*) self.output;
}

- (void) setOutputPhoto:(GtPhoto*) photo
{
	self.output = photo;
}

@end
