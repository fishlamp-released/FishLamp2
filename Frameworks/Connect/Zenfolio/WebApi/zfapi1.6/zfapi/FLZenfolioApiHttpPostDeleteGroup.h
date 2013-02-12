//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpPostDeleteGroup.h
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



@class FLZenfolioDeleteGroupHttpPostIn;
@class FLZenfolioDeleteGroupHttpPostOut;

// --------------------------------------------------------------------
// FLZenfolioApiHttpPostDeleteGroup
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpPostDeleteGroup : NSObject{ 
@private
	FLZenfolioDeleteGroupHttpPostIn* _input;
	FLZenfolioDeleteGroupHttpPostOut* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioDeleteGroupHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioDeleteGroupHttpPostOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpPostDeleteGroup*) apiHttpPostDeleteGroup; 

@end

@interface FLZenfolioApiHttpPostDeleteGroup (ValueProperties) 
@end


@interface FLZenfolioApiHttpPostDeleteGroup (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioDeleteGroupHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioDeleteGroupHttpPostOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

