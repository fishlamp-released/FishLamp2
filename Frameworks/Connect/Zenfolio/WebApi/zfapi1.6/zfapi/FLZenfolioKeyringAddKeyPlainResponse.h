//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioKeyringAddKeyPlainResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioKeyringAddKeyPlainResponse
// --------------------------------------------------------------------
@interface FLZenfolioKeyringAddKeyPlainResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _KeyringAddKeyPlainResult;
} 


@property (readwrite, retain, nonatomic) NSString* KeyringAddKeyPlainResult;

+ (NSString*) KeyringAddKeyPlainResultKey;

+ (FLZenfolioKeyringAddKeyPlainResponse*) keyringAddKeyPlainResponse; 

@end

@interface FLZenfolioKeyringAddKeyPlainResponse (ValueProperties) 
@end

