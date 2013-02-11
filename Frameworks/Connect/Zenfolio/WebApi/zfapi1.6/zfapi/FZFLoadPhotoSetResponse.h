//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioLoadPhotoSetResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


@class FLZenfolioPhotoSet;

// --------------------------------------------------------------------
// FLZenfolioLoadPhotoSetResponse
// --------------------------------------------------------------------
@interface FLZenfolioLoadPhotoSetResponse : NSObject<NSCoding, NSCopying>{ 
@private
	FLZenfolioPhotoSet* _LoadPhotoSetResult;
} 


@property (readwrite, retain, nonatomic) FLZenfolioPhotoSet* LoadPhotoSetResult;

+ (NSString*) LoadPhotoSetResultKey;

+ (FLZenfolioLoadPhotoSetResponse*) loadPhotoSetResponse; 

@end

@interface FLZenfolioLoadPhotoSetResponse (ValueProperties) 
@end

