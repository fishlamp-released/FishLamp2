//
//  UIImage+FLZfCache.h
//  Downloader
//
//  Created by Mike Fullerton on 11/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLStorableImage.h"

@interface FLStorableImage (FLZfCache)

- (BOOL) isStaleComparedToPhotoSequenceNumber:(NSString*) photoSequenceNumber;

@end
