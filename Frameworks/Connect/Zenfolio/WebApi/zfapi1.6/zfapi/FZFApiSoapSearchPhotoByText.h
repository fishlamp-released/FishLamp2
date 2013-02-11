//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapSearchPhotoByText.h
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



@class FLZenfolioSearchPhotoByText;
@class FLZenfolioSearchPhotoByTextResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapSearchPhotoByText
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapSearchPhotoByText : NSObject{ 
@private
	FLZenfolioSearchPhotoByText* _input;
	FLZenfolioSearchPhotoByTextResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioSearchPhotoByText* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioSearchPhotoByTextResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapSearchPhotoByText*) apiSoapSearchPhotoByText; 

@end

@interface FLZenfolioApiSoapSearchPhotoByText (ValueProperties) 
@end


@interface FLZenfolioApiSoapSearchPhotoByText (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioSearchPhotoByText* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioSearchPhotoByTextResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

