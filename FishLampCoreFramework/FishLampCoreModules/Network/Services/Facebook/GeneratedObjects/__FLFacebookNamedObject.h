// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookNamedObject.h
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//


#import "FLFacebookObject.h"

// --------------------------------------------------------------------
// FLFacebookNamedObject
// --------------------------------------------------------------------
@interface FLFacebookNamedObject : FLFacebookObject<NSCopying, NSCoding>{ 
@private
    NSString* __name;
} 


@property (readwrite, strong, nonatomic) NSString* name;

+ (NSString*) nameKey;

+ (FLFacebookNamedObject*) facebookNamedObject; 

@end

@interface FLFacebookNamedObject (ValueProperties) 
@end

// [/Generated]
