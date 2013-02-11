//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioAuthenticateResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioAuthenticateResponse
// --------------------------------------------------------------------
@interface FLZenfolioAuthenticateResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _AuthenticateResult;
} 


@property (readwrite, retain, nonatomic) NSString* AuthenticateResult;

+ (NSString*) AuthenticateResultKey;

+ (FLZenfolioAuthenticateResponse*) authenticateResponse; 

@end

@interface FLZenfolioAuthenticateResponse (ValueProperties) 
@end

