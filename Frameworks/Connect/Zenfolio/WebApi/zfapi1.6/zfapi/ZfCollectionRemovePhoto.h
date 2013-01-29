//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFCollectionRemovePhoto.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFCollectionRemovePhoto
// --------------------------------------------------------------------
@interface ZFCollectionRemovePhoto : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _collectionId;
	NSNumber* _photoId;
} 


@property (readwrite, retain, nonatomic) NSNumber* collectionId;

@property (readwrite, retain, nonatomic) NSNumber* photoId;

+ (NSString*) collectionIdKey;

+ (NSString*) photoIdKey;

+ (ZFCollectionRemovePhoto*) collectionRemovePhoto; 

@end

@interface ZFCollectionRemovePhoto (ValueProperties) 

@property (readwrite, assign, nonatomic) int collectionIdValue;

@property (readwrite, assign, nonatomic) int photoIdValue;
@end

