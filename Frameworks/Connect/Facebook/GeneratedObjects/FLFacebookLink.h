// 
// FLFacebookLink.h
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
@class FLFacebookObject
@interface FLFacebookLink : FLModelObject {
@private
    FLFacebookObject* _from;
    NSDate* _created_time;
    NSString* _message;
    NSString* _picture;
    NSString* _link;
    NSString* _description;
    NSString* _icon;
    NSString* _caption;
}

@property (readwrite, strong, nonatomic) FLFacebookObject* from;
@property (readwrite, strong, nonatomic) NSDate* created_time;
@property (readwrite, strong, nonatomic) NSString* message;
@property (readwrite, strong, nonatomic) NSString* picture;
@property (readwrite, strong, nonatomic) NSString* link;
@property (readwrite, strong, nonatomic) NSString* description;
@property (readwrite, strong, nonatomic) NSString* icon;
@property (readwrite, strong, nonatomic) NSString* caption;
+(FLFacebookLink) link;
@end