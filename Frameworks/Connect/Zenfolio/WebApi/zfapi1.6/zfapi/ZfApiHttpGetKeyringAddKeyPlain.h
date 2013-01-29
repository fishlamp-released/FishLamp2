//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpGetKeyringAddKeyPlain.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Adds a plaintext password to an existing keyring. <A href="/zf/help/api/ref/methods/keyringaddkeyplain">More...</A>
*/



@class ZFKeyringAddKeyPlainHttpGetIn;

// --------------------------------------------------------------------
// ZFApiHttpGetKeyringAddKeyPlain
// --------------------------------------------------------------------
@interface ZFApiHttpGetKeyringAddKeyPlain : NSObject{ 
@private
	ZFKeyringAddKeyPlainHttpGetIn* _input;
	NSString* _output;
} 


@property (readwrite, retain, nonatomic) ZFKeyringAddKeyPlainHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpGetKeyringAddKeyPlain*) apiHttpGetKeyringAddKeyPlain; 

@end

@interface ZFApiHttpGetKeyringAddKeyPlain (ValueProperties) 
@end


@interface ZFApiHttpGetKeyringAddKeyPlain (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFKeyringAddKeyPlainHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

