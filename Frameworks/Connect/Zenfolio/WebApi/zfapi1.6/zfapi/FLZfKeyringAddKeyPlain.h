//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfKeyringAddKeyPlain.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfKeyringAddKeyPlain
// --------------------------------------------------------------------
@interface FLZfKeyringAddKeyPlain : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _keyring;
	NSNumber* _realmId;
	NSString* _password;
} 


@property (readwrite, retain, nonatomic) NSString* keyring;

@property (readwrite, retain, nonatomic) NSString* password;

@property (readwrite, retain, nonatomic) NSNumber* realmId;

+ (NSString*) keyringKey;

+ (NSString*) passwordKey;

+ (NSString*) realmIdKey;

+ (FLZfKeyringAddKeyPlain*) keyringAddKeyPlain; 

@end

@interface FLZfKeyringAddKeyPlain (ValueProperties) 

@property (readwrite, assign, nonatomic) int realmIdValue;
@end

