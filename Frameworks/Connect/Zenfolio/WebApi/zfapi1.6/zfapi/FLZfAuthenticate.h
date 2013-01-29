//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfAuthenticate.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfAuthenticate
// --------------------------------------------------------------------
@interface FLZfAuthenticate : NSObject<NSCoding, NSCopying>{ 
@private
	NSData* _challenge;
	NSData* _proof;
} 


@property (readwrite, retain, nonatomic) NSData* challenge;

@property (readwrite, retain, nonatomic) NSData* proof;

+ (NSString*) challengeKey;

+ (NSString*) proofKey;

+ (FLZfAuthenticate*) authenticate; 

@end

@interface FLZfAuthenticate (ValueProperties) 
@end

