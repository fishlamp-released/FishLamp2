//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiSoapUpdateGroupAccess.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Updates photoset group access descriptor. <A href="/zf/help/api/ref/methods/updategroupaccess">More...</A>
*/



@class FLZfUpdateGroupAccess;
@class FLZfUpdateGroupAccessResponse;

// --------------------------------------------------------------------
// FLZfApiSoapUpdateGroupAccess
// --------------------------------------------------------------------
@interface FLZfApiSoapUpdateGroupAccess : NSObject{ 
@private
	FLZfUpdateGroupAccess* _input;
	FLZfUpdateGroupAccessResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZfUpdateGroupAccess* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfUpdateGroupAccessResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiSoapUpdateGroupAccess*) apiSoapUpdateGroupAccess; 

@end

@interface FLZfApiSoapUpdateGroupAccess (ValueProperties) 
@end


@interface FLZfApiSoapUpdateGroupAccess (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfUpdateGroupAccess* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfUpdateGroupAccessResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

