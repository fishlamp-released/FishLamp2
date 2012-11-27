//
//  FLDownloadImageOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/10/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLHttpOperation.h"
#import "FLCachedImage.h"
#import "FLImage.h"

@interface FLDownloadImageOperation : FLHttpOperation {
}

// output is a FLCachedImage.

- (FLCachedImage*) cachedImageOutput;
- (FLImage*) jpegFileOutput;
- (NSImage_*) imageOutput;

@end

@interface FLDownloadImageBytesOperation : FLHttpOperation {
}

- (NSData*) imageDataOutput;

@end