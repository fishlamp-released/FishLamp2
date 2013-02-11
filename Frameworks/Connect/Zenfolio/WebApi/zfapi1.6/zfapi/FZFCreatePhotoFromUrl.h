//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioCreatePhotoFromUrl.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioCreatePhotoFromUrl
// --------------------------------------------------------------------
@interface FLZenfolioCreatePhotoFromUrl : NSObject<NSCoding, NSCopying>{ 
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

+ (FLZenfolioCreatePhotoFromUrl*) createPhotoFromUrl; 

@end

@interface FLZenfolioCreatePhotoFromUrl (ValueProperties) 

@property (readwrite, assign, nonatomic) int galleryIdValue;
@end

