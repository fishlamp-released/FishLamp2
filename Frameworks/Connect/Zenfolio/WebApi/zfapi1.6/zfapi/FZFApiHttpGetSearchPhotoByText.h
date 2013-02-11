//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpGetSearchPhotoByText.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Searches photos using full-text search. <A href="/Zenfolio/help/api/ref/methods/searchphotobytext">More...</A>
*/



@class FLZenfolioSearchPhotoByTextHttpGetIn;
@class FLZenfolioPhotoResult;

// --------------------------------------------------------------------
// FLZenfolioApiHttpGetSearchPhotoByText
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpGetSearchPhotoByText : NSObject{ 
@private
	FLZenfolioSearchPhotoByTextHttpGetIn* _input;
	FLZenfolioPhotoResult* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioSearchPhotoByTextHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioPhotoResult* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpGetSearchPhotoByText*) apiHttpGetSearchPhotoByText; 

@end

@interface FLZenfolioApiHttpGetSearchPhotoByText (ValueProperties) 
@end


@interface FLZenfolioApiHttpGetSearchPhotoByText (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioSearchPhotoByTextHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioPhotoResult* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

