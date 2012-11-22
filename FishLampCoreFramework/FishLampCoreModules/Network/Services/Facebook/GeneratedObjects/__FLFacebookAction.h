// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookAction.h
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//



// --------------------------------------------------------------------
// FLFacebookAction
// --------------------------------------------------------------------
@interface FLFacebookAction : NSObject<NSCopying, NSCoding>{ 
@private
    NSString* __link;
    NSString* __name;
} 


@property (readwrite, strong, nonatomic) NSString* link;

@property (readwrite, strong, nonatomic) NSString* name;

+ (NSString*) linkKey;

+ (NSString*) nameKey;

+ (FLFacebookAction*) facebookAction; 

@end

@interface FLFacebookAction (ValueProperties) 
@end

// [/Generated]
