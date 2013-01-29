//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiSoapGetCategories.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Loads full list of supported categories. <A href="/zf/help/api/ref/methods/getcategories">More...</A>
*/



@class FLZfGetCategories;
@class FLZfGetCategoriesResponse;

// --------------------------------------------------------------------
// FLZfApiSoapGetCategories
// --------------------------------------------------------------------
@interface FLZfApiSoapGetCategories : NSObject{ 
@private
	FLZfGetCategories* _input;
	FLZfGetCategoriesResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZfGetCategories* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfGetCategoriesResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiSoapGetCategories*) apiSoapGetCategories; 

@end

@interface FLZfApiSoapGetCategories (ValueProperties) 
@end


@interface FLZfApiSoapGetCategories (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfGetCategories* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfGetCategoriesResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

