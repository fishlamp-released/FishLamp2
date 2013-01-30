//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioAuthenticatePlainResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioAuthenticatePlainResponse
// --------------------------------------------------------------------
@interface FLZenfolioAuthenticatePlainResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _AuthenticatePlainResult;
} 


@property (readwrite, retain, nonatomic) NSString* AuthenticatePlainResult;

+ (NSString*) AuthenticatePlainResultKey;

+ (FLZenfolioAuthenticatePlainResponse*) authenticatePlainResponse; 

@end

@interface FLZenfolioAuthenticatePlainResponse (ValueProperties) 
@end

