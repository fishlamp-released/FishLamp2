//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiSoapResolveReference.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Resolves a group or gallery reference. <A href="/zf/help/api/ref/methods/resolvereference">More...</A>
*/



@class FLZfResolveReference;
@class FLZfResolveReferenceResponse;

// --------------------------------------------------------------------
// FLZfApiSoapResolveReference
// --------------------------------------------------------------------
@interface FLZfApiSoapResolveReference : NSObject{ 
@private
	FLZfResolveReference* _input;
	FLZfResolveReferenceResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZfResolveReference* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfResolveReferenceResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiSoapResolveReference*) apiSoapResolveReference; 

@end

@interface FLZfApiSoapResolveReference (ValueProperties) 
@end


@interface FLZfApiSoapResolveReference (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfResolveReference* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfResolveReferenceResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

