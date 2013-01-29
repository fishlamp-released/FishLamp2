//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfAuthenticateHttpGetIn.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfAuthenticateHttpGetIn
// --------------------------------------------------------------------
@interface FLZfAuthenticateHttpGetIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSMutableArray* _challenge;
	NSMutableArray* _proof;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* challenge;
// Type: NSString*, forKey: String

@property (readwrite, retain, nonatomic) NSMutableArray* proof;
// Type: NSString*, forKey: String

+ (NSString*) challengeKey;

+ (NSString*) proofKey;

+ (FLZfAuthenticateHttpGetIn*) authenticateHttpGetIn; 

@end

@interface FLZfAuthenticateHttpGetIn (ValueProperties) 
@end

