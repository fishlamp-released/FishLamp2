// 
// ZFKeyringAddKeyPlainHttpGetIn.h
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

#import "FLModelObject.h"
@interface ZFKeyringAddKeyPlainHttpGetIn : FLModelObject {
@private
    NSString* _keyring;
    NSString* _realmId;
    NSString* _password;
}

@property (readwrite, strong, nonatomic) NSString* keyring;
@property (readwrite, strong, nonatomic) NSString* realmId;
@property (readwrite, strong, nonatomic) NSString* password;
+(ZFKeyringAddKeyPlainHttpGetIn*) keyringAddKeyPlainHttpGetIn;
@end
