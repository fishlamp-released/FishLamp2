//
//	FLZfPhotoInfo.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/26/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLZfPhotoInfo.h"

@implementation FLZfPhotoInfo

@synthesize imageSize = _imageSize;
@synthesize fileSize = _fileSize;
@synthesize sizeInDatabase = _sizeInDatabase;
@synthesize cachedImage = _cachedImage;

#if FL_MRC
- (void) dealloc {
    [_imageSize release];
	[_cachedImage release];
    [super dealloc];
}
#endif

@end

