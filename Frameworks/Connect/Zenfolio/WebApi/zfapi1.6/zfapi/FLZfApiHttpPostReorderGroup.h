//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpPostReorderGroup.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Reorders group elements based on the specified sort order. <A href="/zf/help/api/ref/methods/reordergroup">More...</A>
*/



@class FLZfReorderGroupHttpPostIn;
@class FLZfReorderGroupHttpPostOut;

// --------------------------------------------------------------------
// FLZfApiHttpPostReorderGroup
// --------------------------------------------------------------------
@interface FLZfApiHttpPostReorderGroup : NSObject{ 
@private
	FLZfReorderGroupHttpPostIn* _input;
	FLZfReorderGroupHttpPostOut* _output;
} 


@property (readwrite, retain, nonatomic) FLZfReorderGroupHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfReorderGroupHttpPostOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpPostReorderGroup*) apiHttpPostReorderGroup; 

@end

@interface FLZfApiHttpPostReorderGroup (ValueProperties) 
@end


@interface FLZfApiHttpPostReorderGroup (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfReorderGroupHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfReorderGroupHttpPostOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

