//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfLoadPhotoSetHttpGetIn.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfLoadPhotoSetHttpGetIn
// --------------------------------------------------------------------
@interface FLZfLoadPhotoSetHttpGetIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _photoSetId;
	NSString* _level;
	NSString* _includePhotos;
} 


@property (readwrite, retain, nonatomic) NSString* includePhotos;

@property (readwrite, retain, nonatomic) NSString* level;

@property (readwrite, retain, nonatomic) NSString* photoSetId;

+ (NSString*) includePhotosKey;

+ (NSString*) levelKey;

+ (NSString*) photoSetIdKey;

+ (FLZfLoadPhotoSetHttpGetIn*) loadPhotoSetHttpGetIn; 

@end

@interface FLZfLoadPhotoSetHttpGetIn (ValueProperties) 
@end

