//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfCollectionAddPhoto.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfCollectionAddPhoto
// --------------------------------------------------------------------
@interface FLZfCollectionAddPhoto : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _collectionId;
	NSNumber* _photoId;
} 


@property (readwrite, retain, nonatomic) NSNumber* collectionId;

@property (readwrite, retain, nonatomic) NSNumber* photoId;

+ (NSString*) collectionIdKey;

+ (NSString*) photoIdKey;

+ (FLZfCollectionAddPhoto*) collectionAddPhoto; 

@end

@interface FLZfCollectionAddPhoto (ValueProperties) 

@property (readwrite, assign, nonatomic) int collectionIdValue;

@property (readwrite, assign, nonatomic) int photoIdValue;
@end

