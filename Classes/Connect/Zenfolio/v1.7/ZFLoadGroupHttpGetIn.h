// 
// ZFLoadGroupHttpGetIn.h
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
@interface ZFLoadGroupHttpGetIn : FLModelObject {
@private
    NSString* _groupId;
    NSString* _level;
    NSString* _includeChildren;
}

@property (readwrite, strong, nonatomic) NSString* groupId;
@property (readwrite, strong, nonatomic) NSString* level;
@property (readwrite, strong, nonatomic) NSString* includeChildren;
+ (ZFLoadGroupHttpGetIn*) loadGroupHttpGetIn;
@end
