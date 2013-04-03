//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoap.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


#import "FLNetworkServerContext.h"

// --------------------------------------------------------------------
// ZFApiSoap
// --------------------------------------------------------------------
@interface ZFApiSoap : FLNetworkServerContext{ 
@private
} 

FLSingletonProperty(ZFApiSoap); // See FLSingleton.h/m 


+ (ZFApiSoap*) apiSoap; 

@end

@interface ZFApiSoap (ValueProperties) 
@end

