//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFCreateVideoFromUrlHttpPostIn.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFCreateVideoFromUrlHttpPostIn
// --------------------------------------------------------------------
@interface ZFCreateVideoFromUrlHttpPostIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _galleryId;
	NSString* _url;
	NSString* _cookies;
} 


@property (readwrite, retain, nonatomic) NSString* cookies;

@property (readwrite, retain, nonatomic) NSString* galleryId;

@property (readwrite, retain, nonatomic) NSString* url;

+ (NSString*) cookiesKey;

+ (NSString*) galleryIdKey;

+ (NSString*) urlKey;

+ (ZFCreateVideoFromUrlHttpPostIn*) createVideoFromUrlHttpPostIn; 

@end

@interface ZFCreateVideoFromUrlHttpPostIn (ValueProperties) 
@end

