//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfKeyringAddKeyPlainResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfKeyringAddKeyPlainResponse
// --------------------------------------------------------------------
@interface FLZfKeyringAddKeyPlainResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _KeyringAddKeyPlainResult;
} 


@property (readwrite, retain, nonatomic) NSString* KeyringAddKeyPlainResult;

+ (NSString*) KeyringAddKeyPlainResultKey;

+ (FLZfKeyringAddKeyPlainResponse*) keyringAddKeyPlainResponse; 

@end

@interface FLZfKeyringAddKeyPlainResponse (ValueProperties) 
@end

