//
//	FLCachedPhotoInfo.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/30/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLCachedImage.h"
#import "FLCacheBehavior.h"
#import "FLCachedImageCacheBehavior.h"
#import "NSObject+Copying.h"

@implementation FLCachedImage

@synthesize imageFile = _imageFile;
FLSynthesizeCachedObjectHandlerProperty(FLCachedImage);

- (id) initWithUrlString:(NSString*) url
{
	if((self = [super init]))
	{
		self.url = url;
	}
	
	return self;
}

+ (FLCachedImage*) cachedImageWithUrlString:(NSString*) url
{
	return autorelease_([[FLCachedImage alloc] initWithUrlString:url]);
}

+ (FLCachedImage*) cachedImage
{
	return autorelease_([[FLCachedImage alloc] init]);
}

- (void) dealloc
{
	FLReleaseWithNil_(_imageFile);
	mrc_super_dealloc_();
}

- (void) setUrl:(NSString*) inValue 
{ 
	[super setUrl:inValue];

	NSURL* url = [[NSURL alloc] initWithString:inValue];

	self.host = url.host;
	self.imageId = [NSString stringWithFormat:@"%@%@", url.host, url.path];
	self.photoUrl = url.path;

	FLReleaseWithNil_(url);
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	
	FLJpegFile* file = [[self imageFile] copy];
	[object setImageFile:file];
	mrc_release_(file);
}



@end
