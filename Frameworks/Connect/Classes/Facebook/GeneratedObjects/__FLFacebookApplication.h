// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookApplication.h
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//


#import "FLFacebookNamedObject.h"

// --------------------------------------------------------------------
// FLFacebookApplication
// --------------------------------------------------------------------
@interface FLFacebookApplication : FLFacebookNamedObject<NSCopying, NSCoding>{ 
@private
    NSString* __category;
    NSString* __link;
    NSString* __description;
} 


@property (readwrite, strong, nonatomic) NSString* category;

@property (readwrite, strong, nonatomic) NSString* description;

@property (readwrite, strong, nonatomic) NSString* link;

+ (NSString*) categoryKey;

+ (NSString*) descriptionKey;

+ (NSString*) linkKey;

+ (FLFacebookApplication*) facebookApplication; 

@end

@interface FLFacebookApplication (ValueProperties) 
@end

// [/Generated]
