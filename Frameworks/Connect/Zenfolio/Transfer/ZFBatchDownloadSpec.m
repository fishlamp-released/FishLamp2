//
//  ZFBatchDownloadSpec.m
//  ZenfolioDownloader
//
//  Created by Mike Fullerton on 4/5/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "ZFBatchDownloadSpec.h"

#define kDestinationFolderPath @"DestFolderPath"
#define kDownloadMediaTypes @"DownloadMediaTypes"
#define kUseSSL @"DownloadUsesSSL"

@implementation ZFBatchDownloadSpec

@synthesize photoSets = _photoSets;
@synthesize rootGroupID = _rootGroupID;
@synthesize mediaTypes = _mediaTypes;
@synthesize destinationPath = _destinationPath;

#if FL_MRC
- (void) dealloc {
    [_photoSets release];
    [_mediaTypes release];
    [_destinationPath release];
    [super dealloc];
}
#endif

+ (id) batchDownloadSpec {
    return FLAutorelease([[[self class] alloc] init]);
}

- (id) copyWithZone:(NSZone *)zone {
    ZFBatchDownloadSpec* spec = [[ZFBatchDownloadSpec alloc] init];
    spec.destinationPath = self.destinationPath;
    spec.mediaTypes = self.mediaTypes;
    spec.rootGroupID = self.rootGroupID;
    spec.photoSets = self.photoSets;
    return spec;
}

+ (id) batchDownloadSpecFromUserDefaults {
    
    ZFBatchDownloadSpec* spec = [ZFBatchDownloadSpec batchDownloadSpec];
    
    NSMutableArray* mediaTypes = [NSMutableArray array];
    id object = [[NSUserDefaults standardUserDefaults] objectForKey:kDownloadMediaTypes];
    if(object) {
        for(NSNumber* number in object) {
            [mediaTypes addObject:[ZFMediaType mediaType:[number intValue]]];
        } 
    }
    else {
        [mediaTypes addObject:[ZFMediaType originalImage]];
        [mediaTypes addObject:[ZFMediaType video]];
    }
    spec.mediaTypes = mediaTypes;
    
    spec.destinationPath =  [[NSUserDefaults standardUserDefaults] objectForKey:kDestinationFolderPath];

    if( FLStringIsEmpty(spec.destinationPath)) {
        NSArray* cachePaths = NSSearchPathForDirectoriesInDomains(NSPicturesDirectory, NSUserDomainMask, YES);
        spec.destinationPath = [cachePaths objectAtIndex: 0];
    }

    return spec;
}

- (void) saveToUserDefaults {

    NSMutableArray* mediaTypes = [NSMutableArray array];
    for(ZFMediaType* type in self.mediaTypes) {
        [mediaTypes addObject:[NSNumber numberWithInt:type.mediaTypeID]];
    }
    [[NSUserDefaults standardUserDefaults] setObject:self.destinationPath forKey:kDestinationFolderPath];
    [[NSUserDefaults standardUserDefaults] setObject:mediaTypes forKey:kDownloadMediaTypes];

    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
