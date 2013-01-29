//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpGetSearchSetByText.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Searches photo sets using fullt-text search. <A href="/zf/help/api/ref/methods/searchsetbytext">More...</A>
*/



@class FLZfSearchSetByTextHttpGetIn;
@class FLZfPhotoSetResult;

// --------------------------------------------------------------------
// FLZfApiHttpGetSearchSetByText
// --------------------------------------------------------------------
@interface FLZfApiHttpGetSearchSetByText : NSObject{ 
@private
	FLZfSearchSetByTextHttpGetIn* _input;
	FLZfPhotoSetResult* _output;
} 


@property (readwrite, retain, nonatomic) FLZfSearchSetByTextHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfPhotoSetResult* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpGetSearchSetByText*) apiHttpGetSearchSetByText; 

@end

@interface FLZfApiHttpGetSearchSetByText (ValueProperties) 
@end


@interface FLZfApiHttpGetSearchSetByText (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfSearchSetByTextHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfPhotoSetResult* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

