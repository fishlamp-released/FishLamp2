//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapGetRecentSets.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Retrieves recently added photo sets (most recent at the top). <A href="/Zenfolio/help/api/ref/methods/getrecentsets">More...</A>
*/



@class FLZenfolioGetRecentSets;
@class FLZenfolioGetRecentSetsResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapGetRecentSets
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapGetRecentSets : NSObject{ 
@private
	FLZenfolioGetRecentSets* _input;
	FLZenfolioGetRecentSetsResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioGetRecentSets* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioGetRecentSetsResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapGetRecentSets*) apiSoapGetRecentSets; 

@end

@interface FLZenfolioApiSoapGetRecentSets (ValueProperties) 
@end


@interface FLZenfolioApiSoapGetRecentSets (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioGetRecentSets* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioGetRecentSetsResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

