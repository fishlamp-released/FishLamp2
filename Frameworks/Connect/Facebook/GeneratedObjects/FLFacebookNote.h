// 
// FLFacebookNote.h
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
@interface FLFacebookNote : FLModelObject {
@private
    NSDate* _updated_time;
    NSString* _message;
    NSString* _subject;
    NSString* _icon;
    NSDate* _created_time;
    FLFacebookNamedObject* _from;
}

@property (readwrite, strong, nonatomic) NSDate* updated_time;
@property (readwrite, strong, nonatomic) NSString* message;
@property (readwrite, strong, nonatomic) NSString* subject;
@property (readwrite, strong, nonatomic) NSString* icon;
@property (readwrite, strong, nonatomic) NSDate* created_time;
@property (readwrite, strong, nonatomic) FLFacebookNamedObject* from;
+(FLFacebookNote) note;
@end
