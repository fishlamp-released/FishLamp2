//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiSoapGetChallenge.h
//	Project: FishLamp WebAPI
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



@class FLZfGetChallenge;
@class FLZfGetChallengeResponse;

// --------------------------------------------------------------------
// FLZfApiSoapGetChallenge
// --------------------------------------------------------------------
@interface FLZfApiSoapGetChallenge : NSObject{ 
@private
	FLZfGetChallenge* _input;
	FLZfGetChallengeResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZfGetChallenge* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfGetChallengeResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiSoapGetChallenge*) apiSoapGetChallenge; 

@end

@interface FLZfApiSoapGetChallenge (ValueProperties) 
@end


@interface FLZfApiSoapGetChallenge (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfGetChallenge* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfGetChallengeResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

