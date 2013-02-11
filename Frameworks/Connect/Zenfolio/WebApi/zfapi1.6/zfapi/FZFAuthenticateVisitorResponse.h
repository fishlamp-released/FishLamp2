//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioAuthenticateVisitorResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioAuthenticateVisitorResponse
// --------------------------------------------------------------------
@interface FLZenfolioAuthenticateVisitorResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _AuthenticateVisitorResult;
} 


@property (readwrite, retain, nonatomic) NSString* AuthenticateVisitorResult;

+ (NSString*) AuthenticateVisitorResultKey;

+ (FLZenfolioAuthenticateVisitorResponse*) authenticateVisitorResponse; 

@end

@interface FLZenfolioAuthenticateVisitorResponse (ValueProperties) 
@end

