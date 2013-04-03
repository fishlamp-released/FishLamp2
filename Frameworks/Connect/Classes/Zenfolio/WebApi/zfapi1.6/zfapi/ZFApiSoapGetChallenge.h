//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapGetChallenge.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Generates authentication challenge. <A href="/Zenfolio/help/api/ref/methods/getchallenge">More...</A>
*/



@class ZFGetChallenge;
@class ZFGetChallengeResponse;

// --------------------------------------------------------------------
// ZFApiSoapGetChallenge
// --------------------------------------------------------------------
@interface ZFApiSoapGetChallenge : NSObject{ 
@private
	ZFGetChallenge* _input;
	ZFGetChallengeResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFGetChallenge* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFGetChallengeResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapGetChallenge*) apiSoapGetChallenge; 

@end

@interface ZFApiSoapGetChallenge (ValueProperties) 
@end


@interface ZFApiSoapGetChallenge (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFGetChallenge* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFGetChallengeResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

