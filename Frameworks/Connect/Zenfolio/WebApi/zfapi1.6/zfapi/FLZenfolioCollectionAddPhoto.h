//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioCollectionAddPhoto.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioCollectionAddPhoto
// --------------------------------------------------------------------
@interface FLZenfolioCollectionAddPhoto : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _collectionId;
	NSNumber* _photoId;
} 


@property (readwrite, retain, nonatomic) NSNumber* collectionId;

@property (readwrite, retain, nonatomic) NSNumber* photoId;

+ (NSString*) collectionIdKey;

+ (NSString*) photoIdKey;

+ (FLZenfolioCollectionAddPhoto*) collectionAddPhoto; 

@end

@interface FLZenfolioCollectionAddPhoto (ValueProperties) 

@property (readwrite, assign, nonatomic) int collectionIdValue;

@property (readwrite, assign, nonatomic) int photoIdValue;
@end

