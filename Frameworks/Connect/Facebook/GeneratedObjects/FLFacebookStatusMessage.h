// 
// FLFacebookStatusMessage.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// 
// Project: FishLamp Connect
// Schema: FishLampFacebook
// 
// Generated by: Mike Fullerton @ 5/12/13 8:01 PM with PackMule (3.0.0.1)
// 
// Organization: GreenTongue Software, LLC
// 
// Copywrite (C) 2013 GreenTongue Software, LLC. All rights reserved.
// 
#import "FLModelObject.h"
@class FLFacebookNamedObject
@interface FLFacebookStatusMessage : FLModelObject {
@private
    NSString* _message;
    NSDate* _updated_time;
    FLFacebookNamedObject* _from;
}

@property (readwrite, strong, nonatomic) NSString* message;
@property (readwrite, strong, nonatomic) NSDate* updated_time;
@property (readwrite, strong, nonatomic) FLFacebookNamedObject* from;
+(FLFacebookStatusMessage) statusMessage;
@end
