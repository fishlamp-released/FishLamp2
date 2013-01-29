// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookPagingResponse.h
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//



// --------------------------------------------------------------------
// FLFacebookPagingResponse
// --------------------------------------------------------------------
@interface FLFacebookPagingResponse : NSObject<NSCopying, NSCoding>{ 
@private
    NSString* __previous;
    NSString* __next;
} 


@property (readwrite, strong, nonatomic) NSString* next;

@property (readwrite, strong, nonatomic) NSString* previous;

+ (NSString*) nextKey;

+ (NSString*) previousKey;

+ (FLFacebookPagingResponse*) facebookPagingResponse; 

@end

@interface FLFacebookPagingResponse (ValueProperties) 
@end

// [/Generated]
