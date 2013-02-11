//
//	FLZenfolioUploadGallery.m
//	FishLamp
//
//	Created by Mike Fullerton on 11/20/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLZenfolioUploadGallery.h"
#import "NSString+GUID.h"

@implementation FLZenfolioUploadGallery (More)

- (id) initWithPhotoSet:(FLZenfolioPhotoSet*) photoSet
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

+ (FLZenfolioUploadGallery*) uploadGallery:(FLZenfolioPhotoSet*) photoSet
{
	return FLAutorelease([[FLZenfolioUploadGallery alloc] initWithPhotoSet:photoSet]);
}

+ (NSString*) displayFormatterDataToString:(FLZenfolioUploadGallery*) data {
    return data == nil || ![data isValid] ? NSLocalizedString(@"Not Selected", nil) : [data name];
}


@end
