// [Generated]
//
// This file was generated at 6/18/12 2:01 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLTwitterError.h
// Project: FishLamp
// Schema: Twitter
//
// Copywrite (C) 2012 GreenTongue Software, LLC. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//



// --------------------------------------------------------------------
// FLTwitterError
// --------------------------------------------------------------------
@interface FLTwitterError : NSObject<NSCopying, NSCoding>{ 
@private
    NSString* __error;
    NSString* __request;
} 


@property (readwrite, strong, nonatomic) NSString* error;

@property (readwrite, strong, nonatomic) NSString* request;

+ (NSString*) errorKey;

+ (NSString*) requestKey;

+ (FLTwitterError*) twitterError; 

@end

@interface FLTwitterError (ValueProperties) 
@end

// [/Generated]
