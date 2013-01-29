//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFAuthenticateResponse.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFAuthenticateResponse
// --------------------------------------------------------------------
@interface ZFAuthenticateResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _AuthenticateResult;
} 


@property (readwrite, retain, nonatomic) NSString* AuthenticateResult;

+ (NSString*) AuthenticateResultKey;

+ (ZFAuthenticateResponse*) authenticateResponse; 

@end

@interface ZFAuthenticateResponse (ValueProperties) 
@end

