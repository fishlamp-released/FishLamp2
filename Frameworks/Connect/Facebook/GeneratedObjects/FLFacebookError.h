// 
// FLFacebookError.h
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
@interface FLFacebookError : FLModelObject {
@private
    NSString* _error_reason;
    NSString* _error_description;
    NSString* _externalUrl;
    NSString* _error;
}

@property (readwrite, strong, nonatomic) NSString* error_reason;
@property (readwrite, strong, nonatomic) NSString* error_description;
@property (readwrite, strong, nonatomic) NSString* externalUrl;
@property (readwrite, strong, nonatomic) NSString* error;
+(FLFacebookError) error;
@end