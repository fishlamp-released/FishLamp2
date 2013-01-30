//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapKeyringAddKeyPlain.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Adds a plaintext password to an existing keyring. <A href="/Zenfolio/help/api/ref/methods/keyringaddkeyplain">More...</A>
*/



@class FLZenfolioKeyringAddKeyPlain;
@class FLZenfolioKeyringAddKeyPlainResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapKeyringAddKeyPlain
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapKeyringAddKeyPlain : NSObject{ 
@private
	FLZenfolioKeyringAddKeyPlain* _input;
	FLZenfolioKeyringAddKeyPlainResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioKeyringAddKeyPlain* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioKeyringAddKeyPlainResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapKeyringAddKeyPlain*) apiSoapKeyringAddKeyPlain; 

@end

@interface FLZenfolioApiSoapKeyringAddKeyPlain (ValueProperties) 
@end


@interface FLZenfolioApiSoapKeyringAddKeyPlain (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioKeyringAddKeyPlain* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioKeyringAddKeyPlainResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

