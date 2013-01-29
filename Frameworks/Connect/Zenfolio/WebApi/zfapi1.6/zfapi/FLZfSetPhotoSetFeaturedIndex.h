//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfSetPhotoSetFeaturedIndex.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfSetPhotoSetFeaturedIndex
// --------------------------------------------------------------------
@interface FLZfSetPhotoSetFeaturedIndex : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _photoSetId;
	NSNumber* _index;
} 


@property (readwrite, retain, nonatomic) NSNumber* index;

@property (readwrite, retain, nonatomic) NSNumber* photoSetId;

+ (NSString*) indexKey;

+ (NSString*) photoSetIdKey;

+ (FLZfSetPhotoSetFeaturedIndex*) setPhotoSetFeaturedIndex; 

@end

@interface FLZfSetPhotoSetFeaturedIndex (ValueProperties) 

@property (readwrite, assign, nonatomic) int photoSetIdValue;

@property (readwrite, assign, nonatomic) int indexValue;
@end

