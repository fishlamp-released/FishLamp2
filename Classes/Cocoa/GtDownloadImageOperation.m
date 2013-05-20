//
//  GtDownloadImageOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/10/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtDownloadImageOperation.h"
#import "GtHttpImageDownloadNetworkResponseHandler.h"
#import "GtCachedImage.h"

@implementation GtDownloadImageOperation


- (void) didInit
{
	[super didInit];
	
	self.responseHandler = [GtHttpImageDownloadNetworkResponseHandler instance];
	self.cacheBehavior	= GtHttpOperationCacheBehaviorAll;
	self.input = [GtCachedImage cachedImage];
}

- (void) dealloc
{	
	GtSuperDealloc();
}

- (void) prepareToLoadFromCache
{
	[self.input setUrl:self.URL];
}

- (GtCachedImage*) cachedImageOutput
{
	return self.operationOutput;
}
- (GtJpegFile*) jpegFileOutput
{
	return [self cachedImageOutput].imageFile;
}
- (UIImage*) imageOutput
{
	return [self jpegFileOutput].image;
}


@end
