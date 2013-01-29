//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfAuthenticateResponse.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfAuthenticateResponse
// --------------------------------------------------------------------
@interface FLZfAuthenticateResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _AuthenticateResult;
} 


@property (readwrite, retain, nonatomic) NSString* AuthenticateResult;

+ (NSString*) AuthenticateResultKey;

+ (FLZfAuthenticateResponse*) authenticateResponse; 

@end

@interface FLZfAuthenticateResponse (ValueProperties) 
@end

