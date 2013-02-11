//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpGetDeleteGroup.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Deletes a Group. <A href="/Zenfolio/help/api/ref/methods/deletegroup">More...</A>
*/



@class FLZenfolioDeleteGroupHttpGetIn;
@class FLZenfolioDeleteGroupHttpGetOut;

// --------------------------------------------------------------------
// FLZenfolioApiHttpGetDeleteGroup
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpGetDeleteGroup : NSObject{ 
@private
	FLZenfolioDeleteGroupHttpGetIn* _input;
	FLZenfolioDeleteGroupHttpGetOut* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioDeleteGroupHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioDeleteGroupHttpGetOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpGetDeleteGroup*) apiHttpGetDeleteGroup; 

@end

@interface FLZenfolioApiHttpGetDeleteGroup (ValueProperties) 
@end


@interface FLZenfolioApiHttpGetDeleteGroup (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioDeleteGroupHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioDeleteGroupHttpGetOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

