// 
// ZFAuthenticateHttpGetIn.h
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
@class FLObjectDescriber;
@interface ZFAuthenticateHttpGetIn : FLModelObject {
@private
    NSMutableArray* _challenge;
    NSMutableArray* _proof;
}

@property (readwrite, strong, nonatomic) NSMutableArray* challenge;
@property (readwrite, strong, nonatomic) NSMutableArray* proof;
+ (ZFAuthenticateHttpGetIn*) authenticateHttpGetIn;
@end
