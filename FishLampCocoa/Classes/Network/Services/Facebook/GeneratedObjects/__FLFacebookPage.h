// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookPage.h
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//


#import "FLFacebookNamedObject.h"

// --------------------------------------------------------------------
// FLFacebookPage
// --------------------------------------------------------------------
@interface FLFacebookPage : FLFacebookNamedObject<NSCopying, NSCoding>{ 
@private
    NSString* __category;
    NSNumber* __likes;
} 


@property (readwrite, strong, nonatomic) NSString* category;

@property (readwrite, strong, nonatomic) NSNumber* likes;

+ (NSString*) categoryKey;

+ (NSString*) likesKey;

+ (FLFacebookPage*) facebookPage; 

@end

@interface FLFacebookPage (ValueProperties) 

@property (readwrite, assign, nonatomic) int likesValue;
@end

// [/Generated]
