// 
// FLFacebookActionList.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 5/28/13 2:04 PM with PackMule (3.0.0.1)
// 
// Project: FishLamp Connect
// Schema: FishLampFacebook
// 
// Copyright 2013 (c) GreenTongue Software, LLC
// 

#import "FLModelObject.h"
@class FLFacebookAction;
@class FLObjectDescriber;
@interface FLFacebookActionList : FLModelObject {
@private
    int _count;
    NSMutableArray* _data;
}

@property (readwrite, assign, nonatomic) int count;
@property (readwrite, strong, nonatomic) NSMutableArray* data;
+(FLFacebookActionList*) facebookActionList;
@end