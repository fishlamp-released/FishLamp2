//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpPostResolveReference.h
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



@class FLZenfolioResolveReferenceHttpPostIn;
@class FLZenfolioResolveResult;

// --------------------------------------------------------------------
// FLZenfolioApiHttpPostResolveReference
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpPostResolveReference : NSObject{ 
@private
	FLZenfolioResolveReferenceHttpPostIn* _input;
	FLZenfolioResolveResult* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioResolveReferenceHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioResolveResult* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpPostResolveReference*) apiHttpPostResolveReference; 

@end

@interface FLZenfolioApiHttpPostResolveReference (ValueProperties) 
@end


@interface FLZenfolioApiHttpPostResolveReference (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioResolveReferenceHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioResolveResult* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

