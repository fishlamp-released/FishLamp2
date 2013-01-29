//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpGetGetChallenge.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Generates authentication challenge. <A href="/zf/help/api/ref/methods/getchallenge">More...</A>
*/



@class ZFGetChallengeHttpGetIn;
@class ZFAuthChallenge;

// --------------------------------------------------------------------
// ZFApiHttpGetGetChallenge
// --------------------------------------------------------------------
@interface ZFApiHttpGetGetChallenge : NSObject{ 
@private
	ZFGetChallengeHttpGetIn* _input;
	ZFAuthChallenge* _output;
} 


@property (readwrite, retain, nonatomic) ZFGetChallengeHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFAuthChallenge* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpGetGetChallenge*) apiHttpGetGetChallenge; 

@end

@interface ZFApiHttpGetGetChallenge (ValueProperties) 
@end


@interface ZFApiHttpGetGetChallenge (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFGetChallengeHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFAuthChallenge* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

