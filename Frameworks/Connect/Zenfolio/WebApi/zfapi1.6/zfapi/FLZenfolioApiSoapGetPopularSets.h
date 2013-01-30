//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapGetPopularSets.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Retrieves photo sets in order of popularity (most viewed at the top). <A href="/Zenfolio/help/api/ref/methods/getpopularsets">More...</A>
*/



@class FLZenfolioGetPopularSets;
@class FLZenfolioGetPopularSetsResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapGetPopularSets
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapGetPopularSets : NSObject{ 
@private
	FLZenfolioGetPopularSets* _input;
	FLZenfolioGetPopularSetsResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioGetPopularSets* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioGetPopularSetsResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapGetPopularSets*) apiSoapGetPopularSets; 

@end

@interface FLZenfolioApiSoapGetPopularSets (ValueProperties) 
@end


@interface FLZenfolioApiSoapGetPopularSets (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioGetPopularSets* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioGetPopularSetsResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

