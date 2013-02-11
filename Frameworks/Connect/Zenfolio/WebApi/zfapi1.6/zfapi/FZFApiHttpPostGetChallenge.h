//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpPostGetChallenge.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Generates authentication challenge. <A href="/Zenfolio/help/api/ref/methods/getchallenge">More...</A>
*/



@class FLZenfolioGetChallengeHttpPostIn;
@class FLZenfolioAuthChallenge;

// --------------------------------------------------------------------
// FLZenfolioApiHttpPostGetChallenge
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpPostGetChallenge : NSObject{ 
@private
	FLZenfolioGetChallengeHttpPostIn* _input;
	FLZenfolioAuthChallenge* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioGetChallengeHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioAuthChallenge* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpPostGetChallenge*) apiHttpPostGetChallenge; 

@end

@interface FLZenfolioApiHttpPostGetChallenge (ValueProperties) 
@end


@interface FLZenfolioApiHttpPostGetChallenge (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioGetChallengeHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioAuthChallenge* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

