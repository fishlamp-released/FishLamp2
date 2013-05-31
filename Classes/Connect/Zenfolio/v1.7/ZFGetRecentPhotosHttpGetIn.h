// 
// ZFGetRecentPhotosHttpGetIn.h
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
@interface ZFGetRecentPhotosHttpGetIn : FLModelObject {
@private
    NSString* _limit;
    NSString* _offset;
}

@property (readwrite, strong, nonatomic) NSString* limit;
@property (readwrite, strong, nonatomic) NSString* offset;
+ (ZFGetRecentPhotosHttpGetIn*) getRecentPhotosHttpGetIn;
@end
