//
//  ZFPhotoIdentifier.m
//  FishLampConnect
//
//  Created by Mike Fullerton on 4/21/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "ZFPhotoIdentifier.h"

@interface ZFPhotoIdentifier ()
@property (readwrite, strong, nonatomic) ZFPhoto* photo;
@property (readwrite, strong, nonatomic) ZFPhotoSet* photoSet;
@property (readwrite, strong, nonatomic) ZFGroup* rootGroup;
@property (readwrite, strong, nonatomic) ZFMediaType* mediaType;
@end

@implementation ZFPhotoIdentifier

@synthesize photo = _photo;
@synthesize rootGroup = _rootGroup;
@synthesize photoSet = _photoSet;
@synthesize mediaType = _mediaType;

+ (id) photoIdentifier:(ZFPhoto*) photo 
            mediaType:(ZFMediaType*) mediaType
              photoSet:(ZFPhotoSet*) photoSet 
             rootGroup:(ZFGroup*) rootGroup {
    
    ZFPhotoIdentifier* identifier = FLAutorelease([[[self class] alloc] init]);
    identifier.photo = photo;
    identifier.mediaType = mediaType;
    identifier.photoSet = photoSet;
    identifier.rootGroup = rootGroup;
    return identifier;
}             

#if FL_MRC
- (void) dealloc {
	[_photoSet release];
    [_photo release];
    [_rootGroup release];
    [_mediaType release];
    [super dealloc];
}
#endif

- (NSString*) relativePathIdentifier {
    NSString* folderPath = [_rootGroup relativePathForElement:_photoSet];
    NSString* fileName = [_mediaType humanReadableFileNameForPhoto:_photo inPhotoSet:_photoSet];
    return [folderPath stringByAppendingPathComponent:fileName];
}

- (id) uniqueIdentifier {
    return nil;
}


@end
