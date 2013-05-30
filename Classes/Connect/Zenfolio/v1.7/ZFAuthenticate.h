// 
// ZFAuthenticate.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 5/30/13 4:42 PM with PackMule (3.0.0.1)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "FLModelObject.h"
@interface ZFAuthenticate : FLModelObject {
@private
    NSData* _challenge;
    NSData* _proof;
}

@property (readwrite, strong, nonatomic) NSData* challenge;
@property (readwrite, strong, nonatomic) NSData* proof;
+(ZFAuthenticate*) authenticate;
@end
