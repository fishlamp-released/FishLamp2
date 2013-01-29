//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiSoapGetVersion.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Returns the API implementation version. <A href="/zf/help/api/ref/methods/getversion">More...</A>
*/



@class FLZfGetVersion;
@class FLZfGetVersionResponse;

// --------------------------------------------------------------------
// FLZfApiSoapGetVersion
// --------------------------------------------------------------------
@interface FLZfApiSoapGetVersion : NSObject{ 
@private
	FLZfGetVersion* _input;
	FLZfGetVersionResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZfGetVersion* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfGetVersionResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiSoapGetVersion*) apiSoapGetVersion; 

@end

@interface FLZfApiSoapGetVersion (ValueProperties) 
@end


@interface FLZfApiSoapGetVersion (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfGetVersion* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfGetVersionResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

