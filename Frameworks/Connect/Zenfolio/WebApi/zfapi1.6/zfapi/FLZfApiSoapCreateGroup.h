//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiSoapCreateGroup.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Creates a Group. <A href="/zf/help/api/ref/methods/creategroup">More...</A>
*/



@class FLZfCreateGroup;
@class FLZfCreateGroupResponse;

// --------------------------------------------------------------------
// FLZfApiSoapCreateGroup
// --------------------------------------------------------------------
@interface FLZfApiSoapCreateGroup : NSObject{ 
@private
	FLZfCreateGroup* _input;
	FLZfCreateGroupResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZfCreateGroup* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfCreateGroupResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiSoapCreateGroup*) apiSoapCreateGroup; 

@end

@interface FLZfApiSoapCreateGroup (ValueProperties) 
@end


@interface FLZfApiSoapCreateGroup (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfCreateGroup* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfCreateGroupResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

