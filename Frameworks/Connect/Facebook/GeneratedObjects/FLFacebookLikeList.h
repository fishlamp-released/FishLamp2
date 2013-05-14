// 
// FLFacebookLikeList.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// 
// Project: FishLamp Connect
// Schema: FishLampFacebook
// 
// Generated by: Mike Fullerton @ 5/12/13 8:01 PM with PackMule (3.0.0.1)
// 
// Organization: GreenTongue Software, LLC
// 
// Copywrite (C) 2013 GreenTongue Software, LLC. All rights reserved.
// 
#import "FLModelObject.h"
@interface FLFacebookLikeList : FLModelObject {
@private
    int _count;
    NSMutableArray* _data;
}

@property (readwrite, assign, nonatomic) int count;
@property (readwrite, strong, nonatomic) NSMutableArray* data;
+(FLFacebookLikeList) likeList;
@end
