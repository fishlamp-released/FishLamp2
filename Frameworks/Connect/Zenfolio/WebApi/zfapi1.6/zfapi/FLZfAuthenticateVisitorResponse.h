//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfAuthenticateVisitorResponse.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfAuthenticateVisitorResponse
// --------------------------------------------------------------------
@interface FLZfAuthenticateVisitorResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _AuthenticateVisitorResult;
} 


@property (readwrite, retain, nonatomic) NSString* AuthenticateVisitorResult;

+ (NSString*) AuthenticateVisitorResultKey;

+ (FLZfAuthenticateVisitorResponse*) authenticateVisitorResponse; 

@end

@interface FLZfAuthenticateVisitorResponse (ValueProperties) 
@end

