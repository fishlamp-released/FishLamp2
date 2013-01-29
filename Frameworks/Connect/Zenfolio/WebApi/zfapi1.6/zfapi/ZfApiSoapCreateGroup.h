//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapCreateGroup.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Creates a Group. <A href="/zf/help/api/ref/methods/creategroup">More...</A>
*/



@class ZFCreateGroup;
@class ZFCreateGroupResponse;

// --------------------------------------------------------------------
// ZFApiSoapCreateGroup
// --------------------------------------------------------------------
@interface ZFApiSoapCreateGroup : NSObject{ 
@private
	ZFCreateGroup* _input;
	ZFCreateGroupResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFCreateGroup* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFCreateGroupResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapCreateGroup*) apiSoapCreateGroup; 

@end

@interface ZFApiSoapCreateGroup (ValueProperties) 
@end


@interface ZFApiSoapCreateGroup (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFCreateGroup* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFCreateGroupResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

