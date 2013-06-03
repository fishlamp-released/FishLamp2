// 
// ZFGroupUpdater.h
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


@interface ZFGroupUpdater : FLModelObject {
@private
    NSString* _title;
    NSString* _caption;
    NSString* _customReference;
}

@property (readwrite, strong, nonatomic) NSString* caption;
@property (readwrite, strong, nonatomic) NSString* customReference;
@property (readwrite, strong, nonatomic) NSString* title;

+ (ZFGroupUpdater*) groupUpdater;

@end
