//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioLoadPhotoSetPhotosResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


@class FLZenfolioPhoto;

// --------------------------------------------------------------------
// FLZenfolioLoadPhotoSetPhotosResponse
// --------------------------------------------------------------------
@interface FLZenfolioLoadPhotoSetPhotosResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSMutableArray* _LoadPhotoSetPhotosResult;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* LoadPhotoSetPhotosResult;
// Type: FLZenfolioPhoto*, forKey: Photo

+ (NSString*) LoadPhotoSetPhotosResultKey;

+ (FLZenfolioLoadPhotoSetPhotosResponse*) loadPhotoSetPhotosResponse; 

@end

@interface FLZenfolioLoadPhotoSetPhotosResponse (ValueProperties) 
@end

