//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoap.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


#import "FLNetworkServerContext.h"

// --------------------------------------------------------------------
// FLZenfolioApiSoap
// --------------------------------------------------------------------
@interface FLZenfolioApiSoap : FLNetworkServerContext{ 
@private
} 

FLSingletonProperty(FLZenfolioApiSoap); // See FLSingleton.h/m 


+ (FLZenfolioApiSoap*) apiSoap; 

@end

@interface FLZenfolioApiSoap (ValueProperties) 
@end

