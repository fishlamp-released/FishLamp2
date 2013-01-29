//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiSoapSearchSetByCategory.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Searches photo sets by category id. <A href="/zf/help/api/ref/methods/searchsetbycategory">More...</A>
*/



@class FLZfSearchSetByCategory;
@class FLZfSearchSetByCategoryResponse;

// --------------------------------------------------------------------
// FLZfApiSoapSearchSetByCategory
// --------------------------------------------------------------------
@interface FLZfApiSoapSearchSetByCategory : NSObject{ 
@private
	FLZfSearchSetByCategory* _input;
	FLZfSearchSetByCategoryResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZfSearchSetByCategory* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfSearchSetByCategoryResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiSoapSearchSetByCategory*) apiSoapSearchSetByCategory; 

@end

@interface FLZfApiSoapSearchSetByCategory (ValueProperties) 
@end


@interface FLZfApiSoapSearchSetByCategory (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfSearchSetByCategory* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfSearchSetByCategoryResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

