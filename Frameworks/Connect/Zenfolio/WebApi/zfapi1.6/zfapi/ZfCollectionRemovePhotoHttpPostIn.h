//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFCollectionRemovePhotoHttpPostIn.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFCollectionRemovePhotoHttpPostIn
// --------------------------------------------------------------------
@interface ZFCollectionRemovePhotoHttpPostIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _collectionId;
	NSString* _photoId;
} 


@property (readwrite, retain, nonatomic) NSString* collectionId;

@property (readwrite, retain, nonatomic) NSString* photoId;

+ (NSString*) collectionIdKey;

+ (NSString*) photoIdKey;

+ (ZFCollectionRemovePhotoHttpPostIn*) collectionRemovePhotoHttpPostIn; 

@end

@interface ZFCollectionRemovePhotoHttpPostIn (ValueProperties) 
@end

