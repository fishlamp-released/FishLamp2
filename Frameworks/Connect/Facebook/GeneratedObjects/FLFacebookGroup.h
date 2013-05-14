// 
// FLFacebookGroup.h
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
@interface FLFacebookGroup : FLModelObject {
@private
    NSDate* _updated_time;
    NSString* _owner;
    NSString* _icon;
    NSString* _description;
    NSString* _privacy;
    NSString* _link;
}

@property (readwrite, strong, nonatomic) NSDate* updated_time;
@property (readwrite, strong, nonatomic) NSString* owner;
@property (readwrite, strong, nonatomic) NSString* icon;
@property (readwrite, strong, nonatomic) NSString* description;
@property (readwrite, strong, nonatomic) NSString* privacy;
@property (readwrite, strong, nonatomic) NSString* link;
+(FLFacebookGroup) group;
@end
