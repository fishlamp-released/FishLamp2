//	This file was generated at 7/3/11 2:38 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookFetchStatusListResponse.h
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//


@class GtFacebookPagingResponse;
@class GtFacebookPost;

// --------------------------------------------------------------------
// GtFacebookFetchStatusListResponse
// --------------------------------------------------------------------
@interface GtFacebookFetchStatusListResponse : NSObject<NSCopying, NSCoding>{ 
@private
	GtFacebookPagingResponse* m_paging;
	NSMutableArray* m_data;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* data;
// Type: GtFacebookPost*, forKey: post

@property (readwrite, retain, nonatomic) GtFacebookPagingResponse* paging;

+ (NSString*) dataKey;

+ (NSString*) pagingKey;

+ (GtFacebookFetchStatusListResponse*) facebookFetchStatusListResponse; 

@end

@interface GtFacebookFetchStatusListResponse (ValueProperties) 
@end

