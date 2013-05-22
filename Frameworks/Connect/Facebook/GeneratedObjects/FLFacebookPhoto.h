// 
// FLFacebookPhoto.h
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
@class FLFacebookNamedObject
@interface FLFacebookPhoto : FLModelObject {
@private
    FLFacebookNamedObject* _from;
    NSString* _source;
    int _height;
    NSMutableArray* _tags;
    NSDate* _updated_time;
    int _width;
    NSString* _link;
    NSString* _icon;
    NSDate* _created_time;
}

@property (readwrite, strong, nonatomic) FLFacebookNamedObject* from;
@property (readwrite, strong, nonatomic) NSString* source;
@property (readwrite, assign, nonatomic) int height;
@property (readwrite, strong, nonatomic) NSMutableArray* tags;
@property (readwrite, strong, nonatomic) NSDate* updated_time;
@property (readwrite, assign, nonatomic) int width;
@property (readwrite, strong, nonatomic) NSString* link;
@property (readwrite, strong, nonatomic) NSString* icon;
@property (readwrite, strong, nonatomic) NSDate* created_time;
+(FLFacebookPhoto) photo;
@end