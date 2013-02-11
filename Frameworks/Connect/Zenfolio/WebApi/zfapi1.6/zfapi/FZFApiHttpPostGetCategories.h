//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpPostGetCategories.h
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



@class FLZenfolioGetCategoriesHttpPostIn;
@class FLZenfolioCategory;

// --------------------------------------------------------------------
// FLZenfolioApiHttpPostGetCategories
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpPostGetCategories : NSObject{ 
@private
	FLZenfolioGetCategoriesHttpPostIn* _input;
	NSMutableArray* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioGetCategoriesHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSMutableArray* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.
// Type: FLZenfolioCategory*, forKey: Category

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpPostGetCategories*) apiHttpPostGetCategories; 

@end

@interface FLZenfolioApiHttpPostGetCategories (ValueProperties) 
@end


@interface FLZenfolioApiHttpPostGetCategories (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioGetCategoriesHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) NSMutableArray* outputObject;
// This returns _output. It does NOT create it if it's NIL.
// Type: FLZenfolioCategory*, forKey: Category

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

