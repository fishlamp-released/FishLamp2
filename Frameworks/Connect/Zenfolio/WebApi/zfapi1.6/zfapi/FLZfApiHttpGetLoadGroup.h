//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpGetLoadGroup.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Loads the specified group. <A href="/zf/help/api/ref/methods/loadgroup">More...</A>
*/



@class FLZfLoadGroupHttpGetIn;
@class FLZfGroup;

// --------------------------------------------------------------------
// FLZfApiHttpGetLoadGroup
// --------------------------------------------------------------------
@interface FLZfApiHttpGetLoadGroup : NSObject{ 
@private
	FLZfLoadGroupHttpGetIn* _input;
	FLZfGroup* _output;
} 


@property (readwrite, retain, nonatomic) FLZfLoadGroupHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfGroup* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpGetLoadGroup*) apiHttpGetLoadGroup; 

@end

@interface FLZfApiHttpGetLoadGroup (ValueProperties) 
@end


@interface FLZfApiHttpGetLoadGroup (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfLoadGroupHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfGroup* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

