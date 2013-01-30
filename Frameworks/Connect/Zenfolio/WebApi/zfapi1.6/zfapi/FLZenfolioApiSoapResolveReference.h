//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapResolveReference.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Resolves a group or gallery reference. <A href="/Zenfolio/help/api/ref/methods/resolvereference">More...</A>
*/



@class FLZenfolioResolveReference;
@class FLZenfolioResolveReferenceResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapResolveReference
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapResolveReference : NSObject{ 
@private
	FLZenfolioResolveReference* _input;
	FLZenfolioResolveReferenceResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioResolveReference* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioResolveReferenceResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapResolveReference*) apiSoapResolveReference; 

@end

@interface FLZenfolioApiSoapResolveReference (ValueProperties) 
@end


@interface FLZenfolioApiSoapResolveReference (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioResolveReference* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioResolveReferenceResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

