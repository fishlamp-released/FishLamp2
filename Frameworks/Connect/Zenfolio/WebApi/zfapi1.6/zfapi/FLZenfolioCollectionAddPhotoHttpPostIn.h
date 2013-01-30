//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioCollectionAddPhotoHttpPostIn.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioCollectionAddPhotoHttpPostIn
// --------------------------------------------------------------------
@interface FLZenfolioCollectionAddPhotoHttpPostIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _collectionId;
	NSString* _photoId;
} 


@property (readwrite, retain, nonatomic) NSString* collectionId;

@property (readwrite, retain, nonatomic) NSString* photoId;

+ (NSString*) collectionIdKey;

+ (NSString*) photoIdKey;

+ (FLZenfolioCollectionAddPhotoHttpPostIn*) collectionAddPhotoHttpPostIn; 

@end

@interface FLZenfolioCollectionAddPhotoHttpPostIn (ValueProperties) 
@end

