//
//  GtDownloadImageOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/10/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtHttpOperation.h"
#import "GtCachedImage.h"
#import "GtJpegFile.h"

@interface GtDownloadImageOperation : GtHttpOperation {
}

// output is a GtCachedImage.

- (GtCachedImage*) cachedImageOutput;
- (GtJpegFile*) jpegFileOutput;
- (UIImage*) imageOutput;

@end
