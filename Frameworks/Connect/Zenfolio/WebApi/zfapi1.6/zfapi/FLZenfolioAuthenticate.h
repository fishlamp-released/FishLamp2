//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioAuthenticate.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioAuthenticate
// --------------------------------------------------------------------
@interface FLZenfolioAuthenticate : NSObject<NSCoding, NSCopying>{ 
@private
	NSData* _challenge;
	NSData* _proof;
} 


@property (readwrite, retain, nonatomic) NSData* challenge;

@property (readwrite, retain, nonatomic) NSData* proof;

+ (NSString*) challengeKey;

+ (NSString*) proofKey;

+ (FLZenfolioAuthenticate*) authenticate; 

@end

@interface FLZenfolioAuthenticate (ValueProperties) 
@end

