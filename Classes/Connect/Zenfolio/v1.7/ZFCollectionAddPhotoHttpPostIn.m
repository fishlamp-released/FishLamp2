// 
// ZFCollectionAddPhotoHttpPostIn.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/3/13 10:43 AM with PackMule (3.0.1.100)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 


#import "FLModelObject.h"
#import "ZFCollectionAddPhotoHttpPostIn.h"

@implementation ZFCollectionAddPhotoHttpPostIn

+ (ZFCollectionAddPhotoHttpPostIn*) collectionAddPhotoHttpPostIn {
    return FLAutorelease([[[self class] alloc] init]);
}
@synthesize collectionId = _collectionId;
#if FL_MRC
- (void) dealloc {
    [_photoId release];
    [_collectionId release];
    [super dealloc];
}
#endif
@synthesize photoId = _photoId;

@end
