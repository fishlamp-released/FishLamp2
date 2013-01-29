//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFCreatePhotoFromUrl.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFCreatePhotoFromUrl
// --------------------------------------------------------------------
@interface ZFCreatePhotoFromUrl : NSObject<NSCoding, NSCopying>{ 
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

+ (ZFCreatePhotoFromUrl*) createPhotoFromUrl; 

@end

@interface ZFCreatePhotoFromUrl (ValueProperties) 

@property (readwrite, assign, nonatomic) int galleryIdValue;
@end

