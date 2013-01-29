//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiSoapDeleteGroup.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Deletes a Group. <A href="/zf/help/api/ref/methods/deletegroup">More...</A>
*/



@class FLZfDeleteGroup;
@class FLZfDeleteGroupResponse;

// --------------------------------------------------------------------
// FLZfApiSoapDeleteGroup
// --------------------------------------------------------------------
@interface FLZfApiSoapDeleteGroup : NSObject{ 
@private
	FLZfDeleteGroup* _input;
	FLZfDeleteGroupResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZfDeleteGroup* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfDeleteGroupResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiSoapDeleteGroup*) apiSoapDeleteGroup; 

@end

@interface FLZfApiSoapDeleteGroup (ValueProperties) 
@end


@interface FLZfApiSoapDeleteGroup (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfDeleteGroup* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfDeleteGroupResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

