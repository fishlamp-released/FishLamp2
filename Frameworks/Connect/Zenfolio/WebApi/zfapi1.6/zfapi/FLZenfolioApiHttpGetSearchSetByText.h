//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpGetSearchSetByText.h
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



@class FLZenfolioSearchSetByTextHttpGetIn;
@class FLZenfolioPhotoSetResult;

// --------------------------------------------------------------------
// FLZenfolioApiHttpGetSearchSetByText
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpGetSearchSetByText : NSObject{ 
@private
	FLZenfolioSearchSetByTextHttpGetIn* _input;
	FLZenfolioPhotoSetResult* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioSearchSetByTextHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioPhotoSetResult* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpGetSearchSetByText*) apiHttpGetSearchSetByText; 

@end

@interface FLZenfolioApiHttpGetSearchSetByText (ValueProperties) 
@end


@interface FLZenfolioApiHttpGetSearchSetByText (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioSearchSetByTextHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioPhotoSetResult* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end
