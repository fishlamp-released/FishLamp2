//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiSoapAuthenticatePlain.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Performs plain-text authentication. HTTPS only. <A href="/zf/help/api/ref/methods/authenticateplain">More...</A>
*/



@class FLZfAuthenticatePlain;
@class FLZfAuthenticatePlainResponse;

// --------------------------------------------------------------------
// FLZfApiSoapAuthenticatePlain
// --------------------------------------------------------------------
@interface FLZfApiSoapAuthenticatePlain : NSObject{ 
@private
	FLZfAuthenticatePlain* _input;
	FLZfAuthenticatePlainResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZfAuthenticatePlain* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfAuthenticatePlainResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiSoapAuthenticatePlain*) apiSoapAuthenticatePlain; 

@end

@interface FLZfApiSoapAuthenticatePlain (ValueProperties) 
@end


@interface FLZfApiSoapAuthenticatePlain (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfAuthenticatePlain* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfAuthenticatePlainResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

