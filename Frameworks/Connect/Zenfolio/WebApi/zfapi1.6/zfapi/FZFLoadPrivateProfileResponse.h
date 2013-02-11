//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioLoadPrivateProfileResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


@class FLZenfolioUser;

// --------------------------------------------------------------------
// FLZenfolioLoadPrivateProfileResponse
// --------------------------------------------------------------------
@interface FLZenfolioLoadPrivateProfileResponse : NSObject<NSCoding, NSCopying>{ 
@private
	FLZenfolioUser* _LoadPrivateProfileResult;
} 


@property (readwrite, retain, nonatomic) FLZenfolioUser* LoadPrivateProfileResult;

+ (NSString*) LoadPrivateProfileResultKey;

+ (FLZenfolioLoadPrivateProfileResponse*) loadPrivateProfileResponse; 

@end

@interface FLZenfolioLoadPrivateProfileResponse (ValueProperties) 
@end

