// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookEmailObject.h
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//


#import "FLFacebookNamedObject.h"

// --------------------------------------------------------------------
// FLFacebookEmailObject
// --------------------------------------------------------------------
@interface FLFacebookEmailObject : FLFacebookNamedObject<NSCopying, NSCoding>{ 
@private
    NSString* __email;
} 


@property (readwrite, strong, nonatomic) NSString* email;

+ (NSString*) emailKey;

+ (FLFacebookEmailObject*) facebookEmailObject; 

@end

@interface FLFacebookEmailObject (ValueProperties) 
@end

// [/Generated]
