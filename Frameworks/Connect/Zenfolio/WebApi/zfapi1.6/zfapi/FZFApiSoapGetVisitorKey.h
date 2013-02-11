//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapGetVisitorKey.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Returns the visitor key of the currently authenticated user. <A href="/Zenfolio/help/api/ref/methods/getvisitorkey">More...</A>
*/



@class FLZenfolioGetVisitorKey;
@class FLZenfolioGetVisitorKeyResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapGetVisitorKey
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapGetVisitorKey : NSObject{ 
@private
	FLZenfolioGetVisitorKey* _input;
	FLZenfolioGetVisitorKeyResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioGetVisitorKey* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioGetVisitorKeyResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapGetVisitorKey*) apiSoapGetVisitorKey; 

@end

@interface FLZenfolioApiSoapGetVisitorKey (ValueProperties) 
@end


@interface FLZenfolioApiSoapGetVisitorKey (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioGetVisitorKey* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioGetVisitorKeyResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

