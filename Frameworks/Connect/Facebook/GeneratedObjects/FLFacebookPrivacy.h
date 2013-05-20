// 
// FLFacebookPrivacy.h
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
// Copywrite (C) 2013 GreenTongue Software, LLC. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
// 
#import "FLModelObject.h"
@interface FLFacebookPrivacy : FLModelObject {
@private
    NSString* _value;
    NSString* _friends;
    NSString* _networks;
    NSString* _deny;
    NSString* _description;
}

@property (readwrite, strong, nonatomic) NSString* value;
@property (readwrite, strong, nonatomic) NSString* friends;
@property (readwrite, strong, nonatomic) NSString* networks;
@property (readwrite, strong, nonatomic) NSString* deny;
@property (readwrite, strong, nonatomic) NSString* description;
+(FLFacebookPrivacy) privacy;
@end
