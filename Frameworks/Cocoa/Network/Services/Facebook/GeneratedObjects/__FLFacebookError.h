// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookError.h
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//



// --------------------------------------------------------------------
// FLFacebookError
// --------------------------------------------------------------------
@interface FLFacebookError : NSObject<NSCopying, NSCoding>{ 
@private
    NSString* __error_reason;
    NSString* __error;
    NSString* __error_description;
    NSString* __externalUrl;
} 


@property (readwrite, strong, nonatomic) NSString* error;

@property (readwrite, strong, nonatomic) NSString* error_description;

@property (readwrite, strong, nonatomic) NSString* error_reason;

@property (readwrite, strong, nonatomic) NSString* externalUrl;

+ (NSString*) errorKey;

+ (NSString*) error_descriptionKey;

+ (NSString*) error_reasonKey;

+ (NSString*) externalUrlKey;

+ (FLFacebookError*) facebookError; 

@end

@interface FLFacebookError (ValueProperties) 
@end

// [/Generated]
