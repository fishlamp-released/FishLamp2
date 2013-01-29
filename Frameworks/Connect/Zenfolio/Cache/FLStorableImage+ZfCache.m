//
//  UIImage+FLZfCache.m
//  Downloader
//
//  Created by Mike Fullerton on 11/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLStorableImage+ZfCache.h"

@implementation FLStorableImage (ZfCache)

- (BOOL) isStaleComparedToPhotoSequenceNumber:(NSString*) photoSequenceNumber {
   return !FLStringsAreEqual([self.imageProperties imageVersion], photoSequenceNumber);
}

@end
