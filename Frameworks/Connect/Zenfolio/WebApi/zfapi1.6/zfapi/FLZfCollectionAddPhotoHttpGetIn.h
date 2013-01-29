//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfCollectionAddPhotoHttpGetIn.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfCollectionAddPhotoHttpGetIn
// --------------------------------------------------------------------
@interface FLZfCollectionAddPhotoHttpGetIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _collectionId;
	NSString* _photoId;
} 


@property (readwrite, retain, nonatomic) NSString* collectionId;

@property (readwrite, retain, nonatomic) NSString* photoId;

+ (NSString*) collectionIdKey;

+ (NSString*) photoIdKey;

+ (FLZfCollectionAddPhotoHttpGetIn*) collectionAddPhotoHttpGetIn; 

@end

@interface FLZfCollectionAddPhotoHttpGetIn (ValueProperties) 
@end

