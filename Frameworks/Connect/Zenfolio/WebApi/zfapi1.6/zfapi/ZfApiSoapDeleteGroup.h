//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapDeleteGroup.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Deletes a Group. <A href="/zf/help/api/ref/methods/deletegroup">More...</A>
*/



@class ZFDeleteGroup;
@class ZFDeleteGroupResponse;

// --------------------------------------------------------------------
// ZFApiSoapDeleteGroup
// --------------------------------------------------------------------
@interface ZFApiSoapDeleteGroup : NSObject{ 
@private
	ZFDeleteGroup* _input;
	ZFDeleteGroupResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFDeleteGroup* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFDeleteGroupResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapDeleteGroup*) apiSoapDeleteGroup; 

@end

@interface ZFApiSoapDeleteGroup (ValueProperties) 
@end


@interface ZFApiSoapDeleteGroup (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFDeleteGroup* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFDeleteGroupResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

