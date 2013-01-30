//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapAuthenticatePlain.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Performs plain-text authentication. HTTPS only. <A href="/Zenfolio/help/api/ref/methods/authenticateplain">More...</A>
*/



@class FLZenfolioAuthenticatePlain;
@class FLZenfolioAuthenticatePlainResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapAuthenticatePlain
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapAuthenticatePlain : NSObject{ 
@private
	FLZenfolioAuthenticatePlain* _input;
	FLZenfolioAuthenticatePlainResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioAuthenticatePlain* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioAuthenticatePlainResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapAuthenticatePlain*) apiSoapAuthenticatePlain; 

@end

@interface FLZenfolioApiSoapAuthenticatePlain (ValueProperties) 
@end


@interface FLZenfolioApiSoapAuthenticatePlain (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioAuthenticatePlain* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioAuthenticatePlainResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

