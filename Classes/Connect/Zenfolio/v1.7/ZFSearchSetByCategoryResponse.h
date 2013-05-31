// 
// ZFSearchSetByCategoryResponse.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 5/30/13 6:24 PM with PackMule (3.0.0.1)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "FLModelObject.h"
@class ZFPhotoSetResult;
@interface ZFSearchSetByCategoryResponse : FLModelObject {
@private
    ZFPhotoSetResult* _searchSetByCategoryResult;
}

@property (readwrite, strong, nonatomic) ZFPhotoSetResult* searchSetByCategoryResult;
+ (ZFSearchSetByCategoryResponse*) searchSetByCategoryResponse;
@end
