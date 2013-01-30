//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioAuthenticateHttpPostIn.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioAuthenticateHttpPostIn
// --------------------------------------------------------------------
@interface FLZenfolioAuthenticateHttpPostIn : NSObject<NSCoding, NSCopying>{ 
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

+ (FLZenfolioAuthenticateHttpPostIn*) authenticateHttpPostIn; 

@end

@interface FLZenfolioAuthenticateHttpPostIn (ValueProperties) 
@end

