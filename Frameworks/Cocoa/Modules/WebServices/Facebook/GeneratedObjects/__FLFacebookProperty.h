// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookProperty.h
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//



// --------------------------------------------------------------------
// FLFacebookProperty
// --------------------------------------------------------------------
@interface FLFacebookProperty : NSObject<NSCopying, NSCoding>{ 
@private
    NSString* __text;
    NSString* __name;
    NSString* __href;
} 


@property (readwrite, strong, nonatomic) NSString* href;

@property (readwrite, strong, nonatomic) NSString* name;

@property (readwrite, strong, nonatomic) NSString* text;

+ (NSString*) hrefKey;

+ (NSString*) nameKey;

+ (NSString*) textKey;

+ (FLFacebookProperty*) facebookProperty; 

@end

@interface FLFacebookProperty (ValueProperties) 
@end

// [/Generated]
