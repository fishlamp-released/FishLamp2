//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioSetPhotoSetFeaturedIndexHttpGetIn.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioSetPhotoSetFeaturedIndexHttpGetIn
// --------------------------------------------------------------------
@interface FLZenfolioSetPhotoSetFeaturedIndexHttpGetIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _photoSetId;
	NSString* _index;
} 


@property (readwrite, retain, nonatomic) NSString* index;

@property (readwrite, retain, nonatomic) NSString* photoSetId;

+ (NSString*) indexKey;

+ (NSString*) photoSetIdKey;

+ (FLZenfolioSetPhotoSetFeaturedIndexHttpGetIn*) setPhotoSetFeaturedIndexHttpGetIn; 

@end

@interface FLZenfolioSetPhotoSetFeaturedIndexHttpGetIn (ValueProperties) 
@end
