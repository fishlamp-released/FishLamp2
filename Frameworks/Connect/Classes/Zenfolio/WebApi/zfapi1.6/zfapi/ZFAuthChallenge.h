//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFAuthChallenge.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFAuthChallenge
// --------------------------------------------------------------------
@interface ZFAuthChallenge : NSObject<NSCoding, NSCopying>{ 
@private
	NSData* _PasswordSalt;
	NSData* _Challenge;
} 


@property (readwrite, retain, nonatomic) NSData* Challenge;

@property (readwrite, retain, nonatomic) NSData* PasswordSalt;

+ (NSString*) ChallengeKey;

+ (NSString*) PasswordSaltKey;

+ (ZFAuthChallenge*) authChallenge; 

@end

@interface ZFAuthChallenge (ValueProperties) 
@end

