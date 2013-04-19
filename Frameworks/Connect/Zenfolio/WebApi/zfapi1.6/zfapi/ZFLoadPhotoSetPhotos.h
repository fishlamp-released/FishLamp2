//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLoadPhotoSetPhotos.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFLoadPhotoSetPhotos
// --------------------------------------------------------------------
@interface ZFLoadPhotoSetPhotos : NSObject<NSCoding, NSCopying>{ 
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

+ (ZFLoadPhotoSetPhotos*) loadPhotoSetPhotos; 

@end

@interface ZFLoadPhotoSetPhotos (ValueProperties) 

@property (readwrite, assign, nonatomic) int photoSetIdValue;

@property (readwrite, assign, nonatomic) int startingIndexValue;

@property (readwrite, assign, nonatomic) int numberOfPhotosValue;
@end
