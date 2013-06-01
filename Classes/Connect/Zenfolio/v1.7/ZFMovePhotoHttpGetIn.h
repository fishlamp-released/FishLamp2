// 
// ZFMovePhotoHttpGetIn.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 5/31/13 7:38 PM with PackMule (3.0.0.1)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "FLModelObject.h"
@interface ZFMovePhotoHttpGetIn : FLModelObject {
@private
    NSString* _destSetId;
    NSString* _photoId;
    NSString* _srcSetId;
    NSString* _index;
}

@property (readwrite, strong, nonatomic) NSString* destSetId;
@property (readwrite, strong, nonatomic) NSString* photoId;
@property (readwrite, strong, nonatomic) NSString* srcSetId;
@property (readwrite, strong, nonatomic) NSString* index;
+ (ZFMovePhotoHttpGetIn*) movePhotoHttpGetIn;
@end
