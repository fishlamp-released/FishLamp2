// 
// FLFacebookNamedObject.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 5/28/13 2:04 PM with PackMule (3.0.0.1)
// 
// Project: FishLamp Connect
// Schema: FishLampFacebook
// 
// Copyright 2013 (c) GreenTongue Software, LLC
// 

#import "FLFacebookObject.h"
@interface FLFacebookNamedObject : FLFacebookObject {
@private
    NSString* _name;
}

@property (readwrite, strong, nonatomic) NSString* name;
+(FLFacebookNamedObject*) facebookNamedObject;
@end
