// 
// ZFSetGroupTitlePhotoHttpGetIn.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 5/30/13 2:36 PM with PackMule (3.0.0.1)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "ZFSetGroupTitlePhotoHttpGetIn.h"
#import "FLModelObject.h"
@implementation ZFSetGroupTitlePhotoHttpGetIn
@synthesize groupId = _groupId;
@synthesize photoId = _photoId;
+(ZFSetGroupTitlePhotoHttpGetIn*) setGroupTitlePhotoHttpGetIn {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
-(void) dealloc {
    [_groupId release];
    [_photoId release];
    [super dealloc];
}
#endif
@end
