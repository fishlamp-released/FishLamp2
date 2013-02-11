//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpPostLoadGroup.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Loads the specified group. <A href="/Zenfolio/help/api/ref/methods/loadgroup">More...</A>
*/



@class FLZenfolioLoadGroupHttpPostIn;
@class FLZenfolioGroup;

// --------------------------------------------------------------------
// FLZenfolioApiHttpPostLoadGroup
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpPostLoadGroup : NSObject{ 
@private
	FLZenfolioLoadGroupHttpPostIn* _input;
	FLZenfolioGroup* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioLoadGroupHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioGroup* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpPostLoadGroup*) apiHttpPostLoadGroup; 

@end

@interface FLZenfolioApiHttpPostLoadGroup (ValueProperties) 
@end


@interface FLZenfolioApiHttpPostLoadGroup (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioLoadGroupHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioGroup* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

