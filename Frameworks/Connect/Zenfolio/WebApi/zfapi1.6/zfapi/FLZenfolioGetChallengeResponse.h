//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioGetChallengeResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


@class FLZenfolioAuthChallenge;

// --------------------------------------------------------------------
// FLZenfolioGetChallengeResponse
// --------------------------------------------------------------------
@interface FLZenfolioGetChallengeResponse : NSObject<NSCoding, NSCopying>{ 
@private
	FLZenfolioAuthChallenge* _GetChallengeResult;
} 


@property (readwrite, retain, nonatomic) FLZenfolioAuthChallenge* GetChallengeResult;

+ (NSString*) GetChallengeResultKey;

+ (FLZenfolioGetChallengeResponse*) getChallengeResponse; 

@end

@interface FLZenfolioGetChallengeResponse (ValueProperties) 
@end

