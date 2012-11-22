// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookFetchStatusListResponse.h
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//


@class FLFacebookPagingResponse;
@class FLFacebookPost;

// --------------------------------------------------------------------
// FLFacebookFetchStatusListResponse
// --------------------------------------------------------------------
@interface FLFacebookFetchStatusListResponse : NSObject<NSCopying, NSCoding>{ 
@private
    FLFacebookPagingResponse* __paging;
    NSMutableArray* __data;
} 


@property (readwrite, strong, nonatomic) NSMutableArray* data;
/// Type: FLFacebookPost*, forKey: post

@property (readwrite, strong, nonatomic) FLFacebookPagingResponse* paging;

+ (NSString*) dataKey;

+ (NSString*) pagingKey;

+ (FLFacebookFetchStatusListResponse*) facebookFetchStatusListResponse; 

@end

@interface FLFacebookFetchStatusListResponse (ValueProperties) 
@end

// [/Generated]
