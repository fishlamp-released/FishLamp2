// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookPlace.h
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//


#import "FLFacebookNamedObject.h"

// --------------------------------------------------------------------
// FLFacebookPlace
// --------------------------------------------------------------------
@interface FLFacebookPlace : FLFacebookNamedObject<NSCopying, NSCoding>{ 
@private
    NSString* __location;
} 


@property (readwrite, strong, nonatomic) NSString* location;

+ (NSString*) locationKey;

+ (FLFacebookPlace*) facebookPlace; 

@end

@interface FLFacebookPlace (ValueProperties) 
@end

// [/Generated]
