//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioLoadPhotoSetPhotosHttpPostIn.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioLoadPhotoSetPhotosHttpPostIn
// --------------------------------------------------------------------
@interface FLZenfolioLoadPhotoSetPhotosHttpPostIn : NSObject<NSCoding, NSCopying>{ 
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

+ (FLZenfolioLoadPhotoSetPhotosHttpPostIn*) loadPhotoSetPhotosHttpPostIn; 

@end

@interface FLZenfolioLoadPhotoSetPhotosHttpPostIn (ValueProperties) 
@end

