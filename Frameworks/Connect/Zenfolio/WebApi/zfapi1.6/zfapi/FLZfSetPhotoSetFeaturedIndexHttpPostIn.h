//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfSetPhotoSetFeaturedIndexHttpPostIn.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfSetPhotoSetFeaturedIndexHttpPostIn
// --------------------------------------------------------------------
@interface FLZfSetPhotoSetFeaturedIndexHttpPostIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _photoSetId;
	NSString* _index;
} 


@property (readwrite, retain, nonatomic) NSString* index;

@property (readwrite, retain, nonatomic) NSString* photoSetId;

+ (NSString*) indexKey;

+ (NSString*) photoSetIdKey;

+ (FLZfSetPhotoSetFeaturedIndexHttpPostIn*) setPhotoSetFeaturedIndexHttpPostIn; 

@end

@interface FLZfSetPhotoSetFeaturedIndexHttpPostIn (ValueProperties) 
@end

