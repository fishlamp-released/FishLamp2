//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFKeyringAddKeyPlainResponse.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFKeyringAddKeyPlainResponse
// --------------------------------------------------------------------
@interface ZFKeyringAddKeyPlainResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _KeyringAddKeyPlainResult;
} 


@property (readwrite, retain, nonatomic) NSString* KeyringAddKeyPlainResult;

+ (NSString*) KeyringAddKeyPlainResultKey;

+ (ZFKeyringAddKeyPlainResponse*) keyringAddKeyPlainResponse; 

@end

@interface ZFKeyringAddKeyPlainResponse (ValueProperties) 
@end

