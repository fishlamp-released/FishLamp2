//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfCreatePhotoFromUrl.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfCreatePhotoFromUrl
// --------------------------------------------------------------------
@interface FLZfCreatePhotoFromUrl : NSObject<NSCoding, NSCopying>{ 
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

+ (FLZfCreatePhotoFromUrl*) createPhotoFromUrl; 

@end

@interface FLZfCreatePhotoFromUrl (ValueProperties) 

@property (readwrite, assign, nonatomic) int galleryIdValue;
@end

