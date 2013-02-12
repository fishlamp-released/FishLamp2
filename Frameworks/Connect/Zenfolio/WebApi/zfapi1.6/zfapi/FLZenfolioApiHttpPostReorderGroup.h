//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpPostReorderGroup.h
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



@class FLZenfolioReorderGroupHttpPostIn;
@class FLZenfolioReorderGroupHttpPostOut;

// --------------------------------------------------------------------
// FLZenfolioApiHttpPostReorderGroup
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpPostReorderGroup : NSObject{ 
@private
	FLZenfolioReorderGroupHttpPostIn* _input;
	FLZenfolioReorderGroupHttpPostOut* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioReorderGroupHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioReorderGroupHttpPostOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpPostReorderGroup*) apiHttpPostReorderGroup; 

@end

@interface FLZenfolioApiHttpPostReorderGroup (ValueProperties) 
@end


@interface FLZenfolioApiHttpPostReorderGroup (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioReorderGroupHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioReorderGroupHttpPostOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

