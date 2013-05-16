//
//  GtPhotoCacheFolder.m
//  MyZen
//
//  Created by Mike Fullerton on 10/30/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtCachedPhotoFolder.h"

@implementation GtCachedPhotoFolder

GtSynthesizeSingleton(GtCachedPhotoFolder);

- (NSSearchPathDirectory) searchPathDirectory
{
	return NSCachesDirectory;
}

@end
