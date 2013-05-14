// 
// FLFacebookEmployer.h
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
@interface FLFacebookEmployer : FLModelObject {
@private
    NSString* _employer;
    NSDate* _start_date;
    NSDate* _end_date;
    NSString* _position;
    NSString* _location;
}

@property (readwrite, strong, nonatomic) NSString* employer;
@property (readwrite, strong, nonatomic) NSDate* start_date;
@property (readwrite, strong, nonatomic) NSDate* end_date;
@property (readwrite, strong, nonatomic) NSString* position;
@property (readwrite, strong, nonatomic) NSString* location;
+(FLFacebookEmployer) employer;
@end
