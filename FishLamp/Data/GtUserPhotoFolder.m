//
//  GtUserPhotoFolder.m
//  MyZen
//
//  Created by Mike Fullerton on 10/30/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtUserPhotoFolder.h"


@implementation GtUserPhotoFolder

GtSynthesizeSingleton(GtUserPhotoFolder);

- (NSSearchPathDirectory) searchPathDirectory
{
	return NSDocumentDirectory;
}

@end
