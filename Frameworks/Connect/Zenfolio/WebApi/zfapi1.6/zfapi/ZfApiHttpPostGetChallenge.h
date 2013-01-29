//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpPostGetChallenge.h
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



@class ZFGetChallengeHttpPostIn;
@class ZFAuthChallenge;

// --------------------------------------------------------------------
// ZFApiHttpPostGetChallenge
// --------------------------------------------------------------------
@interface ZFApiHttpPostGetChallenge : NSObject{ 
@private
	ZFGetChallengeHttpPostIn* _input;
	ZFAuthChallenge* _output;
} 


@property (readwrite, retain, nonatomic) ZFGetChallengeHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFAuthChallenge* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpPostGetChallenge*) apiHttpPostGetChallenge; 

@end

@interface ZFApiHttpPostGetChallenge (ValueProperties) 
@end


@interface ZFApiHttpPostGetChallenge (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFGetChallengeHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFAuthChallenge* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

