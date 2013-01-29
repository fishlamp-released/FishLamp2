//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapKeyringAddKeyPlain.h
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



@class ZFKeyringAddKeyPlain;
@class ZFKeyringAddKeyPlainResponse;

// --------------------------------------------------------------------
// ZFApiSoapKeyringAddKeyPlain
// --------------------------------------------------------------------
@interface ZFApiSoapKeyringAddKeyPlain : NSObject{ 
@private
	ZFKeyringAddKeyPlain* _input;
	ZFKeyringAddKeyPlainResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFKeyringAddKeyPlain* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFKeyringAddKeyPlainResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapKeyringAddKeyPlain*) apiSoapKeyringAddKeyPlain; 

@end

@interface ZFApiSoapKeyringAddKeyPlain (ValueProperties) 
@end


@interface ZFApiSoapKeyringAddKeyPlain (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFKeyringAddKeyPlain* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFKeyringAddKeyPlainResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

