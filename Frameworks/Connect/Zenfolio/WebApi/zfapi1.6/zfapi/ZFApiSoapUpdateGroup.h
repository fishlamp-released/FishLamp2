//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapUpdateGroup.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Updates a Group. <A href="/Zenfolio/help/api/ref/methods/updategroup">More...</A>
*/



@class ZFUpdateGroup;
@class ZFUpdateGroupResponse;

// --------------------------------------------------------------------
// ZFApiSoapUpdateGroup
// --------------------------------------------------------------------
@interface ZFApiSoapUpdateGroup : NSObject{ 
@private
	ZFUpdateGroup* _input;
	ZFUpdateGroupResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFUpdateGroup* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFUpdateGroupResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapUpdateGroup*) apiSoapUpdateGroup; 

@end

@interface ZFApiSoapUpdateGroup (ValueProperties) 
@end


@interface ZFApiSoapUpdateGroup (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFUpdateGroup* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFUpdateGroupResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

