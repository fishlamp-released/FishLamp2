//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioUpdatePhotoSetResponse.h
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
// FLZenfolioUpdatePhotoSetResponse
// --------------------------------------------------------------------
@interface FLZenfolioUpdatePhotoSetResponse : NSObject<NSCoding, NSCopying>{ 
@private
	FLZenfolioPhotoSet* _UpdatePhotoSetResult;
} 


@property (readwrite, retain, nonatomic) FLZenfolioPhotoSet* UpdatePhotoSetResult;

+ (NSString*) UpdatePhotoSetResultKey;

+ (FLZenfolioUpdatePhotoSetResponse*) updatePhotoSetResponse; 

@end

@interface FLZenfolioUpdatePhotoSetResponse (ValueProperties) 
@end

