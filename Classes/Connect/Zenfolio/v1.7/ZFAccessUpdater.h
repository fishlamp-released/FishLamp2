// 
// ZFAccessUpdater.h
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
@class FLObjectDescriber;
@interface ZFAccessUpdater : FLModelObject {
@private
    NSString* _password;
    NSString* _passwordHint;
    NSString* _accessMask;
    NSString* _accessType;
    BOOL _isDerived;
    NSMutableArray* _viewers;
}

@property (readwrite, strong, nonatomic) NSString* password;
@property (readwrite, strong, nonatomic) NSString* passwordHint;
@property (readwrite, strong, nonatomic) NSString* accessMask;
@property (readwrite, strong, nonatomic) NSString* accessType;
@property (readwrite, assign, nonatomic) BOOL isDerived;
@property (readwrite, strong, nonatomic) NSMutableArray* viewers;
+(ZFAccessUpdater*) accessUpdater;
@end
