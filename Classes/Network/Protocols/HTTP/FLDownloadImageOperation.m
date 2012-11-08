//
//  FLDownloadImageOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/10/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLDownloadImageOperation.h"
#import "FLCachedImage.h"

@implementation FLDownloadImageOperation

- (id) initWithURL:(NSURL*) url {
    self = [super initWithURL:url];
    if(self) {
        self.input = [FLCachedImage cachedImage];
    }
    return self;
}

- (void) runSelf {
	[((FLCachedImage*)self.input) setUrl:self.URL.absoluteString];

    [super runSelf];

    FLThrowIfError_([self.httpResponse simpleHttpResponseErrorCheck]);
    if(self.didSucceed) {
    
        FLCachedImage* photo = [FLCachedImage create];
        photo.url = self.URL.absoluteString;
        
        NSData* data = self.httpResponse.responseData;
        if(data && data.length > 0)
        {
            // note: folder and file name will be set by image cache.
            FLJpegFile* imageFile = [[FLJpegFile alloc] init];
            imageFile.jpegData = data;
            photo.imageFile = imageFile;
            FLReleaseWithNil_(imageFile);
            
            self.output = photo;
        }
    }
}

- (FLCachedImage*) cachedImageOutput {
	return self.operationOutput;
}

- (FLJpegFile*) jpegFileOutput {
	return [self cachedImageOutput].imageFile;
}

- (FLImage*) imageOutput {
	return [self jpegFileOutput].image;
}

@end
