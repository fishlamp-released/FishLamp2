//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfKeyringAddKeyPlainHttpGetIn.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfKeyringAddKeyPlainHttpGetIn
// --------------------------------------------------------------------
@interface FLZfKeyringAddKeyPlainHttpGetIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _keyring;
	NSString* _realmId;
	NSString* _password;
} 


@property (readwrite, retain, nonatomic) NSString* keyring;

@property (readwrite, retain, nonatomic) NSString* password;

@property (readwrite, retain, nonatomic) NSString* realmId;

+ (NSString*) keyringKey;

+ (NSString*) passwordKey;

+ (NSString*) realmIdKey;

+ (FLZfKeyringAddKeyPlainHttpGetIn*) keyringAddKeyPlainHttpGetIn; 

@end

@interface FLZfKeyringAddKeyPlainHttpGetIn (ValueProperties) 
@end

