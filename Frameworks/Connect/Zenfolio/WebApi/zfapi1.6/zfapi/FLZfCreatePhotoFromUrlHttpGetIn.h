//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfCreatePhotoFromUrlHttpGetIn.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfCreatePhotoFromUrlHttpGetIn
// --------------------------------------------------------------------
@interface FLZfCreatePhotoFromUrlHttpGetIn : NSObject<NSCoding, NSCopying>{ 
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

+ (FLZfCreatePhotoFromUrlHttpGetIn*) createPhotoFromUrlHttpGetIn; 

@end

@interface FLZfCreatePhotoFromUrlHttpGetIn (ValueProperties) 
@end

