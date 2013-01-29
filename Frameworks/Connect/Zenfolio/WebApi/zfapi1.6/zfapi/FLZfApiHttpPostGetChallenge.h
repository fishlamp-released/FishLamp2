//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpPostGetChallenge.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Generates authentication challenge. <A href="/zf/help/api/ref/methods/getchallenge">More...</A>
*/



@class FLZfGetChallengeHttpPostIn;
@class FLZfAuthChallenge;

// --------------------------------------------------------------------
// FLZfApiHttpPostGetChallenge
// --------------------------------------------------------------------
@interface FLZfApiHttpPostGetChallenge : NSObject{ 
@private
	FLZfGetChallengeHttpPostIn* _input;
	FLZfAuthChallenge* _output;
} 


@property (readwrite, retain, nonatomic) FLZfGetChallengeHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfAuthChallenge* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpPostGetChallenge*) apiHttpPostGetChallenge; 

@end

@interface FLZfApiHttpPostGetChallenge (ValueProperties) 
@end


@interface FLZfApiHttpPostGetChallenge (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfGetChallengeHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfAuthChallenge* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

