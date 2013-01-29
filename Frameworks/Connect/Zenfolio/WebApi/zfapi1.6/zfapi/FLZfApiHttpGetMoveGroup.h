//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpGetMoveGroup.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Moves a group from one parent group to another. Destination group must belong to the caller. <A href="/zf/help/api/ref/methods/movegroup">More...</A>
*/



@class FLZfMoveGroupHttpGetIn;
@class FLZfMoveGroupHttpGetOut;

// --------------------------------------------------------------------
// FLZfApiHttpGetMoveGroup
// --------------------------------------------------------------------
@interface FLZfApiHttpGetMoveGroup : NSObject{ 
@private
	FLZfMoveGroupHttpGetIn* _input;
	FLZfMoveGroupHttpGetOut* _output;
} 


@property (readwrite, retain, nonatomic) FLZfMoveGroupHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfMoveGroupHttpGetOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpGetMoveGroup*) apiHttpGetMoveGroup; 

@end

@interface FLZfApiHttpGetMoveGroup (ValueProperties) 
@end


@interface FLZfApiHttpGetMoveGroup (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfMoveGroupHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfMoveGroupHttpGetOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

