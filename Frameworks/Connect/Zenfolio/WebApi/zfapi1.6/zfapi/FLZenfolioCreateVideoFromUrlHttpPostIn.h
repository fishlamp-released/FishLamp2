//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioCreateVideoFromUrlHttpPostIn.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioCreateVideoFromUrlHttpPostIn
// --------------------------------------------------------------------
@interface FLZenfolioCreateVideoFromUrlHttpPostIn : NSObject<NSCoding, NSCopying>{ 
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

+ (FLZenfolioCreateVideoFromUrlHttpPostIn*) createVideoFromUrlHttpPostIn; 

@end

@interface FLZenfolioCreateVideoFromUrlHttpPostIn (ValueProperties) 
@end

