//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFAuthenticatePlainHttpGetIn.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFAuthenticatePlainHttpGetIn
// --------------------------------------------------------------------
@interface ZFAuthenticatePlainHttpGetIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _loginName;
	NSString* _password;
} 


@property (readwrite, retain, nonatomic) NSString* loginName;

@property (readwrite, retain, nonatomic) NSString* password;

+ (NSString*) loginNameKey;

+ (NSString*) passwordKey;

+ (ZFAuthenticatePlainHttpGetIn*) authenticatePlainHttpGetIn; 

@end

@interface ZFAuthenticatePlainHttpGetIn (ValueProperties) 
@end

