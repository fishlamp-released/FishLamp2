//
//  FLDownloadImageOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/10/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLDownloadImageOperation.h"
#import "FLHttpImageDownloadNetworkResponseHandler.h"
#import "FLCachedImage.h"

@implementation FLDownloadImageOperation

- (void) didInit {
	[super didInit];
	
	self.responseHandler = [FLHttpImageDownloadNetworkResponseHandler instance];
	self.input = [FLCachedImage cachedImage];
}

- (void) dealloc {	
	FLSuperDealloc();
}

- (void) willPerformOperation {
	[((FLCachedImage*)self.input) setUrl:self.URL.absoluteString];
    
    [super willPerformOperation];
}

- (FLCachedImage*) cachedImageOutput {
	return self.operationOutput;
}

- (FLJpegFile*) jpegFileOutput {
	return [self cachedImageOutput].imageFile;
}

- (CocoaImage*) imageOutput {
	return [self jpegFileOutput].image;
}


@end
