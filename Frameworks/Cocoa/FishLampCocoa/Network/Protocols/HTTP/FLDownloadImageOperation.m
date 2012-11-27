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

    FLThrowError_([self.httpResponse simpleHttpResponseErrorCheck]);
    if(!self.error) {
    
        FLCachedImage* photo = [FLCachedImage cachedImage];
        photo.url = self.URL.absoluteString;
        
        NSData* data = self.httpResponse.responseData;
        if(data && data.length > 0)
        {
            // note: folder and file name will be set by image cache.
            FLImage* imageFile = [[FLImage alloc] init];
            imageFile.imageBytes = data;
            // uhoh, how do I tell what type it is???
FIXME("ambiguous type")            
            photo.imageFile = imageFile;
            FLReleaseWithNil_(imageFile);
            
            self.output = photo;
        }
    }
}

- (FLCachedImage*) cachedImageOutput {
	return self.operationOutput;
}

- (FLImage*) jpegFileOutput {
	return [self cachedImageOutput].imageFile;
}

- (NSImage_*) imageOutput {
	return [self jpegFileOutput].image;
}

@end

@implementation FLDownloadImageBytesOperation 

- (void) runSelf {
	[super runSelf];

    FLThrowError_([self.httpResponse simpleHttpResponseErrorCheck]);
    if(!self.error) {
        self.output = self.httpResponse.responseData;
    }
}

- (NSData*) imageDataOutput {
    return (NSData*) self.output;
}

@end