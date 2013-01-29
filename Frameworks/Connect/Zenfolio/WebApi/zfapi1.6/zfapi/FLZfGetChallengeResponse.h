//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfGetChallengeResponse.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class FLZfAuthChallenge;

// --------------------------------------------------------------------
// FLZfGetChallengeResponse
// --------------------------------------------------------------------
@interface FLZfGetChallengeResponse : NSObject<NSCoding, NSCopying>{ 
@private
	FLZfAuthChallenge* _GetChallengeResult;
} 


@property (readwrite, retain, nonatomic) FLZfAuthChallenge* GetChallengeResult;

+ (NSString*) GetChallengeResultKey;

+ (FLZfGetChallengeResponse*) getChallengeResponse; 

@end

@interface FLZfGetChallengeResponse (ValueProperties) 
@end

