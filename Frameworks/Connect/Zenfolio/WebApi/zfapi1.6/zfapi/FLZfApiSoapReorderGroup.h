//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiSoapReorderGroup.h
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



@class FLZfReorderGroup;
@class FLZfReorderGroupResponse;

// --------------------------------------------------------------------
// FLZfApiSoapReorderGroup
// --------------------------------------------------------------------
@interface FLZfApiSoapReorderGroup : NSObject{ 
@private
	FLZfReorderGroup* _input;
	FLZfReorderGroupResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZfReorderGroup* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfReorderGroupResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiSoapReorderGroup*) apiSoapReorderGroup; 

@end

@interface FLZfApiSoapReorderGroup (ValueProperties) 
@end


@interface FLZfApiSoapReorderGroup (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfReorderGroup* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfReorderGroupResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

