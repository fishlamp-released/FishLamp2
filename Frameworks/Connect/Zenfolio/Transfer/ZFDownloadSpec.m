//
//  ZFDownloadSpec.m
//  FishLampConnect
//
//  Created by Mike Fullerton on 4/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "ZFDownloadSpec.h"

@implementation ZFDownloadSpec

@synthesize rootGroupID = _rootGroupID;
@synthesize photoSetID = _photoSetID;
@synthesize fullPathToFile = _fullPathToFile;
@synthesize photo = _photo;
@synthesize mediaType = _mediaType;
@synthesize tempFolder = _tempFolder;
@synthesize relativePath = _relativePath;

@synthesize wasSkipped = _wasSkipped;
@synthesize wasDownloaded = _wasDownloaded;

- (id) initWithPhoto:(ZFPhoto*) photo {
    self = [super init];
    if(self) {
        self.photo = photo;
    }
    return self;
}

+ (id) downloadSpec:(ZFPhoto*) photo {
    return FLAutorelease([[[self class] alloc] initWithPhoto:photo]);
}

#if FL_MRC
- (void) dealloc { 
    [_relativePath release];
	[_fullPathToFile release];
    [_photo release];
    [_mediaType release];
    [_tempFolder release];
    [super dealloc];
}
#endif

@end
