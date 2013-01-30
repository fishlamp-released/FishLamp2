//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapSearchSetByText.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Searches photo sets using fullt-text search. <A href="/Zenfolio/help/api/ref/methods/searchsetbytext">More...</A>
*/



@class FLZenfolioSearchSetByText;
@class FLZenfolioSearchSetByTextResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapSearchSetByText
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapSearchSetByText : NSObject{ 
@private
	FLZenfolioSearchSetByText* _input;
	FLZenfolioSearchSetByTextResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioSearchSetByText* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioSearchSetByTextResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapSearchSetByText*) apiSoapSearchSetByText; 

@end

@interface FLZenfolioApiSoapSearchSetByText (ValueProperties) 
@end


@interface FLZenfolioApiSoapSearchSetByText (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioSearchSetByText* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioSearchSetByTextResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

