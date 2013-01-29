//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiSoapUpdateGroup.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Updates a Group. <A href="/zf/help/api/ref/methods/updategroup">More...</A>
*/



@class FLZfUpdateGroup;
@class FLZfUpdateGroupResponse;

// --------------------------------------------------------------------
// FLZfApiSoapUpdateGroup
// --------------------------------------------------------------------
@interface FLZfApiSoapUpdateGroup : NSObject{ 
@private
	FLZfUpdateGroup* _input;
	FLZfUpdateGroupResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZfUpdateGroup* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfUpdateGroupResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiSoapUpdateGroup*) apiSoapUpdateGroup; 

@end

@interface FLZfApiSoapUpdateGroup (ValueProperties) 
@end


@interface FLZfApiSoapUpdateGroup (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfUpdateGroup* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfUpdateGroupResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

