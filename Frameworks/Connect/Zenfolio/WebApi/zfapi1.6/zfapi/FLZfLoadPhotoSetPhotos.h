//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfLoadPhotoSetPhotos.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfLoadPhotoSetPhotos
// --------------------------------------------------------------------
@interface FLZfLoadPhotoSetPhotos : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _photoSetId;
	NSNumber* _startingIndex;
	NSNumber* _numberOfPhotos;
} 


@property (readwrite, retain, nonatomic) NSNumber* numberOfPhotos;

@property (readwrite, retain, nonatomic) NSNumber* photoSetId;

@property (readwrite, retain, nonatomic) NSNumber* startingIndex;

+ (NSString*) numberOfPhotosKey;

+ (NSString*) photoSetIdKey;

+ (NSString*) startingIndexKey;

+ (FLZfLoadPhotoSetPhotos*) loadPhotoSetPhotos; 

@end

@interface FLZfLoadPhotoSetPhotos (ValueProperties) 

@property (readwrite, assign, nonatomic) int photoSetIdValue;

@property (readwrite, assign, nonatomic) int startingIndexValue;

@property (readwrite, assign, nonatomic) int numberOfPhotosValue;
@end

