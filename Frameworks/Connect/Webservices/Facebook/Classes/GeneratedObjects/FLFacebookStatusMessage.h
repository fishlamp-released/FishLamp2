// 
// FLFacebookStatusMessage.h
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
@class FLFacebookNamedObject;
@interface FLFacebookStatusMessage : FLFacebookObject {
@private
    NSString* _message;
    NSDate* _updated_time;
    FLFacebookNamedObject* _from;
}

@property (readwrite, strong, nonatomic) NSString* message;
@property (readwrite, strong, nonatomic) NSDate* updated_time;
@property (readwrite, strong, nonatomic) FLFacebookNamedObject* from;
+(FLFacebookStatusMessage*) facebookStatusMessage;
@end