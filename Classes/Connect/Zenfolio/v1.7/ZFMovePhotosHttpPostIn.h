// 
// ZFMovePhotosHttpPostIn.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/2/13 4:12 PM with PackMule (3.0.0.1)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "FLModelObject.h"

@class FLObjectDescriber;

@interface ZFMovePhotosHttpPostIn : FLModelObject {
@private
    NSString* _srcSetId;
    NSString* _destSetId;
    NSMutableArray* _photoIds;
}

@property (readwrite, strong, nonatomic) NSString* destSetId;
@property (readwrite, strong, nonatomic) NSMutableArray* photoIds;
@property (readwrite, strong, nonatomic) NSString* srcSetId;

+ (ZFMovePhotosHttpPostIn*) movePhotosHttpPostIn;

@end
