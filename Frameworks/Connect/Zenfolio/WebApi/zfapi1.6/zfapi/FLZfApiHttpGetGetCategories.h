//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpGetGetCategories.h
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



@class FLZfGetCategoriesHttpGetIn;
@class FLZfCategory;

// --------------------------------------------------------------------
// FLZfApiHttpGetGetCategories
// --------------------------------------------------------------------
@interface FLZfApiHttpGetGetCategories : NSObject{ 
@private
	FLZfGetCategoriesHttpGetIn* _input;
	NSMutableArray* _output;
} 


@property (readwrite, retain, nonatomic) FLZfGetCategoriesHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSMutableArray* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.
// Type: FLZfCategory*, forKey: Category

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpGetGetCategories*) apiHttpGetGetCategories; 

@end

@interface FLZfApiHttpGetGetCategories (ValueProperties) 
@end


@interface FLZfApiHttpGetGetCategories (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfGetCategoriesHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) NSMutableArray* outputObject;
// This returns _output. It does NOT create it if it's NIL.
// Type: FLZfCategory*, forKey: Category

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

