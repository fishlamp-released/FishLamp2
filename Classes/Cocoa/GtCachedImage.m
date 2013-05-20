//
//	GtCachedPhotoInfo.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/30/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtCachedImage.h"
#import "GtCachedObjectHandler.h"
#import "GtCachedImageCacheBehavior.h"

@implementation GtCachedImage

@synthesize imageFile = m_imageFile;
GtSynthesizeCachedObjectHandlerProperty(GtCachedImage);

- (id) initWithUrlString:(NSString*) url
{
	if((self = [super init]))
	{
		self.url = url;
	}
	
	return self;
}

+ (GtCachedImage*) cachedImageWithUrlString:(NSString*) url
{
	return GtReturnAutoreleased([[GtCachedImage alloc] initWithUrlString:url]);
}

+ (GtCachedImage*) cachedImage
{
	return GtReturnAutoreleased([[GtCachedImage alloc] init]);
}

- (void) dealloc
{
	GtReleaseWithNil(m_imageFile);
	GtSuperDealloc();
}

- (void) setUrl:(NSString*) inValue 
{ 
	[super setUrl:inValue];

	NSURL* url = [[NSURL alloc] initWithString:inValue];

	self.host = url.host;
	self.imageId = [NSString stringWithFormat:@"%@%@", url.host, url.path];
	self.photoUrl = url.path;

	GtReleaseWithNil(url);
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	
	GtJpegFile* file = [[self imageFile] copy];
	[object setImageFile:file];
	GtRelease(file);
}



@end
