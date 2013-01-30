//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioCreatePhotoSetResponse.h
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
// FLZenfolioCreatePhotoSetResponse
// --------------------------------------------------------------------
@interface FLZenfolioCreatePhotoSetResponse : NSObject<NSCoding, NSCopying>{ 
@private
	FLZenfolioPhotoSet* _CreatePhotoSetResult;
} 


@property (readwrite, retain, nonatomic) FLZenfolioPhotoSet* CreatePhotoSetResult;

+ (NSString*) CreatePhotoSetResultKey;

+ (FLZenfolioCreatePhotoSetResponse*) createPhotoSetResponse; 

@end

@interface FLZenfolioCreatePhotoSetResponse (ValueProperties) 
@end

