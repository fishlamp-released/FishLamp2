//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioRotatePhotoResponse.h
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
// FLZenfolioRotatePhotoResponse
// --------------------------------------------------------------------
@interface FLZenfolioRotatePhotoResponse : NSObject<NSCoding, NSCopying>{ 
@private
	FLZenfolioPhoto* _RotatePhotoResult;
} 


@property (readwrite, retain, nonatomic) FLZenfolioPhoto* RotatePhotoResult;

+ (NSString*) RotatePhotoResultKey;

+ (FLZenfolioRotatePhotoResponse*) rotatePhotoResponse; 

@end

@interface FLZenfolioRotatePhotoResponse (ValueProperties) 
@end

