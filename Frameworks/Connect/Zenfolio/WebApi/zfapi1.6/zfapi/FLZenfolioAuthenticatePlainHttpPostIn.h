//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioAuthenticatePlainHttpPostIn.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioAuthenticatePlainHttpPostIn
// --------------------------------------------------------------------
@interface FLZenfolioAuthenticatePlainHttpPostIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _loginName;
	NSString* _password;
} 


@property (readwrite, retain, nonatomic) NSString* loginName;

@property (readwrite, retain, nonatomic) NSString* password;

+ (NSString*) loginNameKey;

+ (NSString*) passwordKey;

+ (FLZenfolioAuthenticatePlainHttpPostIn*) authenticatePlainHttpPostIn; 

@end

@interface FLZenfolioAuthenticatePlainHttpPostIn (ValueProperties) 
@end

