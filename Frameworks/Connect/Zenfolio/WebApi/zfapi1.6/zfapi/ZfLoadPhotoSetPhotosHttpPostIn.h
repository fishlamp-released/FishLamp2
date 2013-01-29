//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLoadPhotoSetPhotosHttpPostIn.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFLoadPhotoSetPhotosHttpPostIn
// --------------------------------------------------------------------
@interface ZFLoadPhotoSetPhotosHttpPostIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _photoSetId;
	NSString* _startingIndex;
	NSString* _numberOfPhotos;
} 


@property (readwrite, retain, nonatomic) NSString* numberOfPhotos;

@property (readwrite, retain, nonatomic) NSString* photoSetId;

@property (readwrite, retain, nonatomic) NSString* startingIndex;

+ (NSString*) numberOfPhotosKey;

+ (NSString*) photoSetIdKey;

+ (NSString*) startingIndexKey;

+ (ZFLoadPhotoSetPhotosHttpPostIn*) loadPhotoSetPhotosHttpPostIn; 

@end

@interface ZFLoadPhotoSetPhotosHttpPostIn (ValueProperties) 
@end

