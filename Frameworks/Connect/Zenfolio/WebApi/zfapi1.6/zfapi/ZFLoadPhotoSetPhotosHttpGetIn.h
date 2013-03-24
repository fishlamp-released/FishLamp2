//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLoadPhotoSetPhotosHttpGetIn.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFLoadPhotoSetPhotosHttpGetIn
// --------------------------------------------------------------------
@interface ZFLoadPhotoSetPhotosHttpGetIn : NSObject<NSCoding, NSCopying>{ 
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

+ (ZFLoadPhotoSetPhotosHttpGetIn*) loadPhotoSetPhotosHttpGetIn; 

@end

@interface ZFLoadPhotoSetPhotosHttpGetIn (ValueProperties) 
@end

