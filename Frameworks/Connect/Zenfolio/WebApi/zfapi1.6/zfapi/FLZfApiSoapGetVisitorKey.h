//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiSoapGetVisitorKey.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Returns the visitor key of the currently authenticated user. <A href="/zf/help/api/ref/methods/getvisitorkey">More...</A>
*/



@class FLZfGetVisitorKey;
@class FLZfGetVisitorKeyResponse;

// --------------------------------------------------------------------
// FLZfApiSoapGetVisitorKey
// --------------------------------------------------------------------
@interface FLZfApiSoapGetVisitorKey : NSObject{ 
@private
	FLZfGetVisitorKey* _input;
	FLZfGetVisitorKeyResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZfGetVisitorKey* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfGetVisitorKeyResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiSoapGetVisitorKey*) apiSoapGetVisitorKey; 

@end

@interface FLZfApiSoapGetVisitorKey (ValueProperties) 
@end


@interface FLZfApiSoapGetVisitorKey (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfGetVisitorKey* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfGetVisitorKeyResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

