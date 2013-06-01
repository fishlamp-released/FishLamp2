// 
// ZFExifTag.h
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
@interface ZFExifTag : FLModelObject {
@private
    int _id;
    NSString* _value;
    NSString* _displayValue;
}

@property (readwrite, assign, nonatomic) int id;
@property (readwrite, strong, nonatomic) NSString* value;
@property (readwrite, strong, nonatomic) NSString* displayValue;
+ (ZFExifTag*) exifTag;
@end
