// 
// ZFAccessDescriptor.h
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
@class FLObjectDescriber;
@interface ZFAccessDescriptor : FLModelObject {
@private
    NSString* _accessType;
    BOOL _isDerived;
    NSString* _accessMask;
    NSString* _srcPasswordHint;
    NSMutableArray* _viewers;
    NSString* _passwordHint;
    long _realmId;
}

@property (readwrite, strong, nonatomic) NSString* accessType;
@property (readwrite, assign, nonatomic) BOOL isDerived;
@property (readwrite, strong, nonatomic) NSString* accessMask;
@property (readwrite, strong, nonatomic) NSString* srcPasswordHint;
@property (readwrite, strong, nonatomic) NSMutableArray* viewers;
@property (readwrite, strong, nonatomic) NSString* passwordHint;
@property (readwrite, assign, nonatomic) long realmId;
+ (ZFAccessDescriptor*) accessDescriptor;
@end