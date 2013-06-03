// 
// ZFFile.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/3/13 10:43 AM with PackMule (3.0.1.100)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "FLModelObject.h"


@interface ZFFile : FLModelObject {
@private
    unsigned int _height;
    NSString* _urlCore;
    NSString* _sequence;
    long _id;
    NSString* _mimeType;
    unsigned int _width;
    NSString* _urlHost;
}

@property (readwrite, assign, nonatomic) unsigned int height;
@property (readwrite, assign, nonatomic) long id;
@property (readwrite, strong, nonatomic) NSString* mimeType;
@property (readwrite, strong, nonatomic) NSString* sequence;
@property (readwrite, strong, nonatomic) NSString* urlCore;
@property (readwrite, strong, nonatomic) NSString* urlHost;
@property (readwrite, assign, nonatomic) unsigned int width;

+ (ZFFile*) file;

@end
