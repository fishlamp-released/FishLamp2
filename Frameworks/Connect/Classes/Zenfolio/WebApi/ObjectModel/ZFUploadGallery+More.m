//
//	ZFUploadGallery.m
//	FishLamp
//
//	Created by Mike Fullerton on 11/20/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "ZFUploadGallery.h"
#import "NSString+GUID.h"

@implementation ZFUploadGallery (More)

- (id) initWithPhotoSet:(ZFPhotoSet*) photoSet
{
	if((self = [self init]))
	{
		self.name = photoSet.Title;
		self.photoSetIdValue = photoSet.IdValue;
		self.uploadUrl = photoSet.UploadUrl;
	}

	return self;
}

- (NSString*) description
{
	return [NSString stringWithFormat:(NSLocalizedString(@"Upload Gallery: %@, id: %d, url:%@", nil)), self.name, self.photoSetIdValue, self.uploadUrl];
}

- (BOOL) isValid
{
	return self.photoSetIdValue != 0 && FLStringIsNotEmpty(self.name) && FLStringIsNotEmpty(self.uploadUrl);
}

+ (ZFUploadGallery*) uploadGallery:(ZFPhotoSet*) photoSet
{
	return FLAutorelease([[ZFUploadGallery alloc] initWithPhotoSet:photoSet]);
}

+ (NSString*) displayFormatterDataToString:(ZFUploadGallery*) data {
    return data == nil || ![data isValid] ? NSLocalizedString(@"Not Selected", nil) : [data name];
}


@end
