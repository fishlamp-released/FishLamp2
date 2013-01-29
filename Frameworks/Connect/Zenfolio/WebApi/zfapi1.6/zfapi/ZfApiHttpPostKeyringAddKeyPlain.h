//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpPostKeyringAddKeyPlain.h
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



@class ZFKeyringAddKeyPlainHttpPostIn;

// --------------------------------------------------------------------
// ZFApiHttpPostKeyringAddKeyPlain
// --------------------------------------------------------------------
@interface ZFApiHttpPostKeyringAddKeyPlain : NSObject{ 
@private
	ZFKeyringAddKeyPlainHttpPostIn* _input;
	NSString* _output;
} 


@property (readwrite, retain, nonatomic) ZFKeyringAddKeyPlainHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpPostKeyringAddKeyPlain*) apiHttpPostKeyringAddKeyPlain; 

@end

@interface ZFApiHttpPostKeyringAddKeyPlain (ValueProperties) 
@end


@interface ZFApiHttpPostKeyringAddKeyPlain (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFKeyringAddKeyPlainHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

