//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioLoadPhotoResponse.h
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
// FLZenfolioLoadPhotoResponse
// --------------------------------------------------------------------
@interface FLZenfolioLoadPhotoResponse : NSObject<NSCoding, NSCopying>{ 
@private
	FLZenfolioPhoto* _LoadPhotoResult;
} 


@property (readwrite, retain, nonatomic) FLZenfolioPhoto* LoadPhotoResult;

+ (NSString*) LoadPhotoResultKey;

+ (FLZenfolioLoadPhotoResponse*) loadPhotoResponse; 

@end

@interface FLZenfolioLoadPhotoResponse (ValueProperties) 
@end

