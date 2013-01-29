//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfAuthChallenge.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfAuthChallenge
// --------------------------------------------------------------------
@interface FLZfAuthChallenge : NSObject<NSCoding, NSCopying>{ 
@private
	NSData* _PasswordSalt;
	NSData* _Challenge;
} 


@property (readwrite, retain, nonatomic) NSData* Challenge;

@property (readwrite, retain, nonatomic) NSData* PasswordSalt;

+ (NSString*) ChallengeKey;

+ (NSString*) PasswordSaltKey;

+ (FLZfAuthChallenge*) authChallenge; 

@end

@interface FLZfAuthChallenge (ValueProperties) 
@end

