//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioLoadPublicProfileResponse.h
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
// FLZenfolioLoadPublicProfileResponse
// --------------------------------------------------------------------
@interface FLZenfolioLoadPublicProfileResponse : NSObject<NSCoding, NSCopying>{ 
@private
	FLZenfolioUser* _LoadPublicProfileResult;
} 


@property (readwrite, retain, nonatomic) FLZenfolioUser* LoadPublicProfileResult;

+ (NSString*) LoadPublicProfileResultKey;

+ (FLZenfolioLoadPublicProfileResponse*) loadPublicProfileResponse; 

@end

@interface FLZenfolioLoadPublicProfileResponse (ValueProperties) 
@end

