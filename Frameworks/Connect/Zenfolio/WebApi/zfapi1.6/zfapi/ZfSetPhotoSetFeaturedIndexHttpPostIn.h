//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFSetPhotoSetFeaturedIndexHttpPostIn.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFSetPhotoSetFeaturedIndexHttpPostIn
// --------------------------------------------------------------------
@interface ZFSetPhotoSetFeaturedIndexHttpPostIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _photoSetId;
	NSString* _index;
} 


@property (readwrite, retain, nonatomic) NSString* index;

@property (readwrite, retain, nonatomic) NSString* photoSetId;

+ (NSString*) indexKey;

+ (NSString*) photoSetIdKey;

+ (ZFSetPhotoSetFeaturedIndexHttpPostIn*) setPhotoSetFeaturedIndexHttpPostIn; 

@end

@interface ZFSetPhotoSetFeaturedIndexHttpPostIn (ValueProperties) 
@end

