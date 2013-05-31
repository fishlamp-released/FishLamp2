// 
// ZFGroupElement.h
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
@class ZFAccessDescriptor;
@interface ZFGroupElement : FLModelObject {
@private
    BOOL _hideBranding;
    long _id;
    NSString* _title;
    int _groupIndex;
    NSString* _owner;
    ZFAccessDescriptor* _accessDescriptor;
}

@property (readwrite, assign, nonatomic) BOOL hideBranding;
@property (readwrite, assign, nonatomic) long id;
@property (readwrite, strong, nonatomic) NSString* title;
@property (readwrite, assign, nonatomic) int groupIndex;
@property (readwrite, strong, nonatomic) NSString* owner;
@property (readwrite, strong, nonatomic) ZFAccessDescriptor* accessDescriptor;
+ (ZFGroupElement*) groupElement;
@end