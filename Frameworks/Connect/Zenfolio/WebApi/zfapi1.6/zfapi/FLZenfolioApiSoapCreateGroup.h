//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapCreateGroup.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Creates a Group. <A href="/Zenfolio/help/api/ref/methods/creategroup">More...</A>
*/



@class FLZenfolioCreateGroup;
@class FLZenfolioCreateGroupResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapCreateGroup
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapCreateGroup : NSObject{ 
@private
	FLZenfolioCreateGroup* _input;
	FLZenfolioCreateGroupResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioCreateGroup* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioCreateGroupResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapCreateGroup*) apiSoapCreateGroup; 

@end

@interface FLZenfolioApiSoapCreateGroup (ValueProperties) 
@end


@interface FLZenfolioApiSoapCreateGroup (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioCreateGroup* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioCreateGroupResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

