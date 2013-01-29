//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiSoapGetPopularSets.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Retrieves photo sets in order of popularity (most viewed at the top). <A href="/zf/help/api/ref/methods/getpopularsets">More...</A>
*/



@class FLZfGetPopularSets;
@class FLZfGetPopularSetsResponse;

// --------------------------------------------------------------------
// FLZfApiSoapGetPopularSets
// --------------------------------------------------------------------
@interface FLZfApiSoapGetPopularSets : NSObject{ 
@private
	FLZfGetPopularSets* _input;
	FLZfGetPopularSetsResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZfGetPopularSets* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfGetPopularSetsResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiSoapGetPopularSets*) apiSoapGetPopularSets; 

@end

@interface FLZfApiSoapGetPopularSets (ValueProperties) 
@end


@interface FLZfApiSoapGetPopularSets (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfGetPopularSets* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfGetPopularSetsResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

