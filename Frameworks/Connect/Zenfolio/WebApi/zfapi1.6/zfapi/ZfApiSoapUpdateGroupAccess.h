//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapUpdateGroupAccess.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Updates photoset group access descriptor. <A href="/zf/help/api/ref/methods/updategroupaccess">More...</A>
*/



@class ZFUpdateGroupAccess;
@class ZFUpdateGroupAccessResponse;

// --------------------------------------------------------------------
// ZFApiSoapUpdateGroupAccess
// --------------------------------------------------------------------
@interface ZFApiSoapUpdateGroupAccess : NSObject{ 
@private
	ZFUpdateGroupAccess* _input;
	ZFUpdateGroupAccessResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFUpdateGroupAccess* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFUpdateGroupAccessResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapUpdateGroupAccess*) apiSoapUpdateGroupAccess; 

@end

@interface ZFApiSoapUpdateGroupAccess (ValueProperties) 
@end


@interface ZFApiSoapUpdateGroupAccess (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFUpdateGroupAccess* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFUpdateGroupAccessResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

