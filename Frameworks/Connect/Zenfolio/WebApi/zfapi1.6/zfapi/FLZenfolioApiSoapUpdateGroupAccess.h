//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapUpdateGroupAccess.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Updates photoset group access descriptor. <A href="/Zenfolio/help/api/ref/methods/updategroupaccess">More...</A>
*/



@class FLZenfolioUpdateGroupAccess;
@class FLZenfolioUpdateGroupAccessResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapUpdateGroupAccess
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapUpdateGroupAccess : NSObject{ 
@private
	FLZenfolioUpdateGroupAccess* _input;
	FLZenfolioUpdateGroupAccessResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioUpdateGroupAccess* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioUpdateGroupAccessResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapUpdateGroupAccess*) apiSoapUpdateGroupAccess; 

@end

@interface FLZenfolioApiSoapUpdateGroupAccess (ValueProperties) 
@end


@interface FLZenfolioApiSoapUpdateGroupAccess (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioUpdateGroupAccess* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioUpdateGroupAccessResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

