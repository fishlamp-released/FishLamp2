//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFCreateVideoFromUrl.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFCreateVideoFromUrl
// --------------------------------------------------------------------
@interface ZFCreateVideoFromUrl : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _galleryId;
	NSString* _url;
	NSString* _cookies;
} 


@property (readwrite, retain, nonatomic) NSString* cookies;

@property (readwrite, retain, nonatomic) NSNumber* galleryId;

@property (readwrite, retain, nonatomic) NSString* url;

+ (NSString*) cookiesKey;

+ (NSString*) galleryIdKey;

+ (NSString*) urlKey;

+ (ZFCreateVideoFromUrl*) createVideoFromUrl; 

@end

@interface ZFCreateVideoFromUrl (ValueProperties) 

@property (readwrite, assign, nonatomic) int galleryIdValue;
@end

