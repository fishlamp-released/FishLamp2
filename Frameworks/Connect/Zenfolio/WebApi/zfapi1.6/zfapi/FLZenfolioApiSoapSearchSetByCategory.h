//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapSearchSetByCategory.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Searches photo sets by category id. <A href="/Zenfolio/help/api/ref/methods/searchsetbycategory">More...</A>
*/



@class FLZenfolioSearchSetByCategory;
@class FLZenfolioSearchSetByCategoryResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapSearchSetByCategory
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapSearchSetByCategory : NSObject{ 
@private
	FLZenfolioSearchSetByCategory* _input;
	FLZenfolioSearchSetByCategoryResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioSearchSetByCategory* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioSearchSetByCategoryResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapSearchSetByCategory*) apiSoapSearchSetByCategory; 

@end

@interface FLZenfolioApiSoapSearchSetByCategory (ValueProperties) 
@end


@interface FLZenfolioApiSoapSearchSetByCategory (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioSearchSetByCategory* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioSearchSetByCategoryResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

