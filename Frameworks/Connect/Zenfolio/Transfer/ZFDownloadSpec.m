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
@synthesize destinationPath = _destinationPath;
@synthesize photo = _photo;
@synthesize mediaType = _mediaType;
@synthesize hiddenFolderPath = _hiddenFolderPath;
@synthesize fileName = _fileName;

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
    [_fileName release];
	[_destinationPath release];
    [_photo release];
    [_mediaType release];
    [_hiddenFolderPath release];
    [super dealloc];
}
#endif

@end
