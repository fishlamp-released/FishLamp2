// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookObject.h
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//



// --------------------------------------------------------------------
// FLFacebookObject
// --------------------------------------------------------------------
@interface FLFacebookObject : NSObject<NSCopying, NSCoding>{ 
@private
    NSString* __id;
} 


@property (readwrite, strong, nonatomic) NSString* id;

+ (NSString*) idKey;

+ (FLFacebookObject*) facebookObject; 

@end

@interface FLFacebookObject (ValueProperties) 
@end

// [/Generated]
