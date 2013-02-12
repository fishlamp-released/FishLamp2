//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapGetVersion.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Returns the API implementation version. <A href="/Zenfolio/help/api/ref/methods/getversion">More...</A>
*/



@class FLZenfolioGetVersion;
@class FLZenfolioGetVersionResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapGetVersion
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapGetVersion : NSObject{ 
@private
	FLZenfolioGetVersion* _input;
	FLZenfolioGetVersionResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioGetVersion* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioGetVersionResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapGetVersion*) apiSoapGetVersion; 

@end

@interface FLZenfolioApiSoapGetVersion (ValueProperties) 
@end


@interface FLZenfolioApiSoapGetVersion (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioGetVersion* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioGetVersionResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

