//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapMoveGroup.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Moves a group from one parent group to another. Destination group must belong to the caller. <A href="/Zenfolio/help/api/ref/methods/movegroup">More...</A>
*/



@class FLZenfolioMoveGroup;
@class FLZenfolioMoveGroupResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapMoveGroup
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapMoveGroup : NSObject{ 
@private
	FLZenfolioMoveGroup* _input;
	FLZenfolioMoveGroupResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioMoveGroup* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioMoveGroupResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapMoveGroup*) apiSoapMoveGroup; 

@end

@interface FLZenfolioApiSoapMoveGroup (ValueProperties) 
@end


@interface FLZenfolioApiSoapMoveGroup (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioMoveGroup* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioMoveGroupResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

