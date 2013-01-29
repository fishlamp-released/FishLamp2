//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFGetChallengeResponse.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class ZFAuthChallenge;

// --------------------------------------------------------------------
// ZFGetChallengeResponse
// --------------------------------------------------------------------
@interface ZFGetChallengeResponse : NSObject<NSCoding, NSCopying>{ 
@private
	ZFAuthChallenge* _GetChallengeResult;
} 


@property (readwrite, retain, nonatomic) ZFAuthChallenge* GetChallengeResult;

+ (NSString*) GetChallengeResultKey;

+ (ZFGetChallengeResponse*) getChallengeResponse; 

@end

@interface ZFGetChallengeResponse (ValueProperties) 
@end

