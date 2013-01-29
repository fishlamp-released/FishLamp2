//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpGetKeyringAddKeyPlain.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Adds a plaintext password to an existing keyring. <A href="/zf/help/api/ref/methods/keyringaddkeyplain">More...</A>
*/



@class FLZfKeyringAddKeyPlainHttpGetIn;

// --------------------------------------------------------------------
// FLZfApiHttpGetKeyringAddKeyPlain
// --------------------------------------------------------------------
@interface FLZfApiHttpGetKeyringAddKeyPlain : NSObject{ 
@private
	FLZfKeyringAddKeyPlainHttpGetIn* _input;
	NSString* _output;
} 


@property (readwrite, retain, nonatomic) FLZfKeyringAddKeyPlainHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpGetKeyringAddKeyPlain*) apiHttpGetKeyringAddKeyPlain; 

@end

@interface FLZfApiHttpGetKeyringAddKeyPlain (ValueProperties) 
@end


@interface FLZfApiHttpGetKeyringAddKeyPlain (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfKeyringAddKeyPlainHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

