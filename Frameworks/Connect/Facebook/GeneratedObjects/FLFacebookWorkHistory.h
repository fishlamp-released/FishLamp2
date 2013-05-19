// 
// FLFacebookWorkHistory.h
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
@interface FLFacebookWorkHistory : FLModelObject {
@private
    FLFacebookNamedObject* _employer;
    NSDate* _start_date;
    NSDate* _end_date;
    FLFacebookNamedObject* _position;
    FLFacebookNamedObject* _location;
}

@property (readwrite, strong, nonatomic) FLFacebookNamedObject* employer;
@property (readwrite, strong, nonatomic) NSDate* start_date;
@property (readwrite, strong, nonatomic) NSDate* end_date;
@property (readwrite, strong, nonatomic) FLFacebookNamedObject* position;
@property (readwrite, strong, nonatomic) FLFacebookNamedObject* location;
+(FLFacebookWorkHistory) workHistory;
@end
