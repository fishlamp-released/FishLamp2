//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpGetGetChallenge.h
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



@class FLZenfolioGetChallengeHttpGetIn;
@class FLZenfolioAuthChallenge;

// --------------------------------------------------------------------
// FLZenfolioApiHttpGetGetChallenge
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpGetGetChallenge : NSObject{ 
@private
	FLZenfolioGetChallengeHttpGetIn* _input;
	FLZenfolioAuthChallenge* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioGetChallengeHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioAuthChallenge* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpGetGetChallenge*) apiHttpGetGetChallenge; 

@end

@interface FLZenfolioApiHttpGetGetChallenge (ValueProperties) 
@end


@interface FLZenfolioApiHttpGetGetChallenge (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioGetChallengeHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioAuthChallenge* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

