//	This file was generated at 7/3/11 2:38 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookPagingResponse.h
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//



// --------------------------------------------------------------------
// GtFacebookPagingResponse
// --------------------------------------------------------------------
@interface GtFacebookPagingResponse : NSObject<NSCopying, NSCoding>{ 
@private
	NSString* m_previous;
	NSString* m_next;
} 


@property (readwrite, retain, nonatomic) NSString* next;

@property (readwrite, retain, nonatomic) NSString* previous;

+ (NSString*) nextKey;

+ (NSString*) previousKey;

+ (GtFacebookPagingResponse*) facebookPagingResponse; 

@end

@interface GtFacebookPagingResponse (ValueProperties) 
@end

