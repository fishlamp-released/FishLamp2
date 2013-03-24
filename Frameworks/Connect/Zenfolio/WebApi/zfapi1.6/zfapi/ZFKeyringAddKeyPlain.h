//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFKeyringAddKeyPlain.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFKeyringAddKeyPlain
// --------------------------------------------------------------------
@interface ZFKeyringAddKeyPlain : NSObject<NSCoding, NSCopying>{ 
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

+ (ZFKeyringAddKeyPlain*) keyringAddKeyPlain; 

@end

@interface ZFKeyringAddKeyPlain (ValueProperties) 

@property (readwrite, assign, nonatomic) int realmIdValue;
@end

