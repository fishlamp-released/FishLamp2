//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfAuthenticatePlainResponse.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfAuthenticatePlainResponse
// --------------------------------------------------------------------
@interface FLZfAuthenticatePlainResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _AuthenticatePlainResult;
} 


@property (readwrite, retain, nonatomic) NSString* AuthenticatePlainResult;

+ (NSString*) AuthenticatePlainResultKey;

+ (FLZfAuthenticatePlainResponse*) authenticatePlainResponse; 

@end

@interface FLZfAuthenticatePlainResponse (ValueProperties) 
@end

