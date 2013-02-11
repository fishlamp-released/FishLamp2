//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapUpdateGroup.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Updates a Group. <A href="/Zenfolio/help/api/ref/methods/updategroup">More...</A>
*/



@class FLZenfolioUpdateGroup;
@class FLZenfolioUpdateGroupResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapUpdateGroup
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapUpdateGroup : NSObject{ 
@private
	FLZenfolioUpdateGroup* _input;
	FLZenfolioUpdateGroupResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioUpdateGroup* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioUpdateGroupResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapUpdateGroup*) apiSoapUpdateGroup; 

@end

@interface FLZenfolioApiSoapUpdateGroup (ValueProperties) 
@end


@interface FLZenfolioApiSoapUpdateGroup (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioUpdateGroup* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioUpdateGroupResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

