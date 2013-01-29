//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapGetVersion.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Returns the API implementation version. <A href="/zf/help/api/ref/methods/getversion">More...</A>
*/



@class ZFGetVersion;
@class ZFGetVersionResponse;

// --------------------------------------------------------------------
// ZFApiSoapGetVersion
// --------------------------------------------------------------------
@interface ZFApiSoapGetVersion : NSObject{ 
@private
	ZFGetVersion* _input;
	ZFGetVersionResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFGetVersion* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFGetVersionResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapGetVersion*) apiSoapGetVersion; 

@end

@interface ZFApiSoapGetVersion (ValueProperties) 
@end


@interface ZFApiSoapGetVersion (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFGetVersion* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFGetVersionResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

