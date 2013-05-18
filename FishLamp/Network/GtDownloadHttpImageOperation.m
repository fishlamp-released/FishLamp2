//
//  GtDownloadHttpImageOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 8/30/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtDownloadHttpImageOperation.h"
#import "GtCachedPhotoData.h"
#import "GtBase64Encoding.h"
#import "GtDatabaseCache.h"

@implementation GtDownloadHttpImageOperation

- (id) init
{
	if(self = [super init])
	{
		self.canLoadFromCache = YES;
		self.canSaveToCache = YES;
	}
	
	return self;
}

- (id) initWithInput:(id) input
{
	if(self = [super initWithInput:input])
	{
		self.canLoadFromCache = YES;
		self.canSaveToCache = YES;
	}
	return self;
}

- (id) initWithUrlInput:(NSString*) url
{
	return [self initWithInput:url];
}

- (void) createHttpRequest:(id<GtWebRequestProtocol>*) outRequest
{
	*outRequest = [GtAlloc(GtWebRequest) initGetRequestWithUrl: self.input];
}

- (void) onSetOutput:(NSData*) data
{
	GtCachedPhotoData* photo = [GtAlloc(GtCachedPhotoData) init];
	photo.url = self.input;

	GtPhotoData* photoData = [GtAlloc(GtPhotoData) initWithData:data];
	photo.photoData = photoData;
	GtRelease(photoData);

	self.output = photo;
	GtRelease(photo);
}

- (void) onConvertOperationInputToCacheInput:(id*) outCacheInput;
{
	GtCachedPhotoData* input = [GtAlloc(GtCachedPhotoData) init];
	input.url = self.input;
	input.cacheKey = input.url; 
	*outCacheInput = input;
}

- (void) onSetOperationOutputWithCacheOutput:(id) cacheOutput;
{
	self.output = cacheOutput;
}

- (void) onConvertOperationOutputToCachedObject:(id*) outCachedObject
{
	[self.output setCacheKey:[self.output url]]; 
	
	*outCachedObject = [self.output retain];
}

@end
