//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpGetReorderGroup.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Reorders group elements based on the specified sort order. <A href="/Zenfolio/help/api/ref/methods/reordergroup">More...</A>
*/



@class FLZenfolioReorderGroupHttpGetIn;
@class FLZenfolioReorderGroupHttpGetOut;

// --------------------------------------------------------------------
// FLZenfolioApiHttpGetReorderGroup
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpGetReorderGroup : NSObject{ 
@private
	FLZenfolioReorderGroupHttpGetIn* _input;
	FLZenfolioReorderGroupHttpGetOut* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioReorderGroupHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioReorderGroupHttpGetOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpGetReorderGroup*) apiHttpGetReorderGroup; 

@end

@interface FLZenfolioApiHttpGetReorderGroup (ValueProperties) 
@end


@interface FLZenfolioApiHttpGetReorderGroup (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioReorderGroupHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioReorderGroupHttpGetOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

