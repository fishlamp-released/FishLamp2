//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapGetCategories.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Loads full list of supported categories. <A href="/Zenfolio/help/api/ref/methods/getcategories">More...</A>
*/



@class FLZenfolioGetCategories;
@class FLZenfolioGetCategoriesResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapGetCategories
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapGetCategories : NSObject{ 
@private
	FLZenfolioGetCategories* _input;
	FLZenfolioGetCategoriesResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioGetCategories* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioGetCategoriesResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapGetCategories*) apiSoapGetCategories; 

@end

@interface FLZenfolioApiSoapGetCategories (ValueProperties) 
@end


@interface FLZenfolioApiSoapGetCategories (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioGetCategories* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioGetCategoriesResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

