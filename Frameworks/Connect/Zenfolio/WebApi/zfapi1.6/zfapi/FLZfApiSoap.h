//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiSoap.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


#import "FLNetworkServerContext.h"

// --------------------------------------------------------------------
// FLZfApiSoap
// --------------------------------------------------------------------
@interface FLZfApiSoap : FLNetworkServerContext{ 
@private
} 

FLSingletonProperty(FLZfApiSoap); // See FLSingleton.h/m 


+ (FLZfApiSoap*) apiSoap; 

@end

@interface FLZfApiSoap (ValueProperties) 
@end

