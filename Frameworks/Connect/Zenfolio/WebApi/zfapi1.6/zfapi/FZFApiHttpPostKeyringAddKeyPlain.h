//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpPostKeyringAddKeyPlain.h
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



@class FLZenfolioKeyringAddKeyPlainHttpPostIn;

// --------------------------------------------------------------------
// FLZenfolioApiHttpPostKeyringAddKeyPlain
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpPostKeyringAddKeyPlain : NSObject{ 
@private
	FLZenfolioKeyringAddKeyPlainHttpPostIn* _input;
	NSString* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioKeyringAddKeyPlainHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpPostKeyringAddKeyPlain*) apiHttpPostKeyringAddKeyPlain; 

@end

@interface FLZenfolioApiHttpPostKeyringAddKeyPlain (ValueProperties) 
@end


@interface FLZenfolioApiHttpPostKeyringAddKeyPlain (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioKeyringAddKeyPlainHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

